// lib/support_chat_screen.dart

import 'dart:async';
import 'package:flutter/material.dart';
import 'api_client.dart';
import 'package:styloria_mobile/gen_l10n/app_localizations.dart';

class SupportChatScreen extends StatefulWidget {
  const SupportChatScreen({super.key});

  @override
  State<SupportChatScreen> createState() => _SupportChatScreenState();
}

class _SupportChatScreenState extends State<SupportChatScreen> {
  int? _threadId;
  bool _threadActive = true;
  bool? _threadRated;
  bool _loading = true;
  bool _sending = false;
  String? _error;
  List<Map<String, dynamic>> _messages = [];
  final TextEditingController _inputController = TextEditingController();
  final ScrollController _scrollController = ScrollController();

  // Polling
  Timer? _pollTimer;
  String? _lastMessageTimestamp;

  // Inactivity
  Timer? _inactivityTimer;
  final int _timeoutSeconds = 300;

  // Rating
  int _selectedRating = 0;
  final TextEditingController _ratingCommentController = TextEditingController();
  bool _submittingRating = false;
  bool _ratingSubmitted = false;

  bool _initialized = false;

  @override
  void initState() {
    super.initState();
    _startInactivityTimer();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (!_initialized) {
      _initialized = true;
      _loadThreadAndMessages();
    }
  }

  @override
  void dispose() {
    _pollTimer?.cancel();
    _inactivityTimer?.cancel();
    _inputController.dispose();
    _scrollController.dispose();
    _ratingCommentController.dispose();
    super.dispose();
  }

  // ── INACTIVITY TIMER ──────────────────────────────────

  void _startInactivityTimer() {
    _inactivityTimer?.cancel();
    _inactivityTimer = Timer(Duration(seconds: _timeoutSeconds), _showTimeoutWarning);
  }

  void _resetInactivityTimer() {
    if (_inactivityTimer != null && _inactivityTimer!.isActive) {
      _startInactivityTimer();
    }
  }

  void _showTimeoutWarning() {
    if (!mounted) return;
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (ctx) => AlertDialog(
        title: const Text("Are you still there?"),
        content: const Text(
          "We haven't heard from you in a while. To ensure we can help everyone, "
          "this chat will close soon.",
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(ctx).pop();
              Navigator.of(context).pop();
            },
            child: const Text("Exit Chat"),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.of(ctx).pop();
              _startInactivityTimer();
            },
            child: const Text("I'm here"),
          ),
        ],
      ),
    );
  }

  // ── POLLING (REAL-TIME) ────────────────────────────────

  void _startPolling() {
    _pollTimer?.cancel();
    _pollTimer = Timer.periodic(const Duration(seconds: 3), (_) => _pollNewMessages());
  }

  Future<void> _pollNewMessages() async {
    if (_threadId == null || !mounted) return;

    try {
      final newMessages = await ApiClient.getSupportMessages(
        _threadId!,
        since: _lastMessageTimestamp,
      );

      if (!mounted || newMessages == null || newMessages.isEmpty) return;

      final List<Map<String, dynamic>> typed = newMessages
          .map((m) => Map<String, dynamic>.from(m as Map))
          .toList();

      // Check if thread was closed (system message about resolution)
      bool threadJustClosed = false;
      for (final msg in typed) {
        if (msg['is_system_message'] == true) {
          final content = (msg['content'] ?? '').toString().toLowerCase();
          if (content.contains('marked as resolved') || content.contains('thread has been')) {
            threadJustClosed = true;
          }
        }
      }

      setState(() {
        _messages.addAll(typed);
        _lastMessageTimestamp = typed.last['created_at']?.toString();
        if (threadJustClosed) {
          _threadActive = false;
        }
      });

      _scrollToBottom();
    } catch (e) {
      debugPrint('Poll error: $e');
    }
  }

  // ── LOAD THREAD ────────────────────────────────────────

  Future<void> _loadThreadAndMessages() async {
    setState(() {
      _loading = true;
      _error = null;
    });

    try {
      final thread = await ApiClient.getOrCreateSupportThread();

      if (!mounted) return;
      if (thread == null || thread['id'] == null) {
        final l10n = AppLocalizations.of(context)!;
        setState(() {
          _loading = false;
          _error = l10n.unableStartSupportChat;
        });
        return;
      }

      final threadId = thread['id'] as int;
      final isActive = thread['is_active'] as bool? ?? true;
      final hasRating = thread['rating'] != null;
      final messages = await ApiClient.getSupportMessages(threadId);

      if (!mounted) return;

      final List<Map<String, dynamic>> typed = (messages ?? [])
          .map((m) => Map<String, dynamic>.from(m as Map))
          .toList();

      setState(() {
        _threadId = threadId;
        _threadActive = isActive;
        _threadRated = hasRating;
        _ratingSubmitted = hasRating;
        _messages = typed;
        _loading = false;
        if (typed.isNotEmpty) {
          _lastMessageTimestamp = typed.last['created_at']?.toString();
        }
      });

      _startPolling();
      WidgetsBinding.instance.addPostFrameCallback((_) => _scrollToBottom());
    } catch (e) {
      debugPrint('Support chat load error: $e');
      if (!mounted) return;
      final l10n = AppLocalizations.of(context)!;
      setState(() {
        _loading = false;
        _error = l10n.unableStartSupportChat;
      });
    }
  }

  // ── SEND MESSAGE ───────────────────────────────────────

  Future<void> _sendMessage() async {
    final l10n = AppLocalizations.of(context)!;
    final text = _inputController.text.trim();
    if (text.isEmpty || _threadId == null || !_threadActive) return;

    _resetInactivityTimer();
    setState(() { _sending = true; });

    final msg = await ApiClient.sendSupportMessage(_threadId!, text);

    if (!mounted) return;
    setState(() { _sending = false; });

    if (msg == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(l10n.messageNotSentPolicy), backgroundColor: Colors.red),
      );
      return;
    }

    final typed = Map<String, dynamic>.from(msg);
    _inputController.clear();
    setState(() {
      _messages.add(typed);
      _lastMessageTimestamp = typed['created_at']?.toString();
    });
    _scrollToBottom();
  }

  // ── SUBMIT RATING ──────────────────────────────────────

  Future<void> _submitRating() async {
    if (_selectedRating == 0 || _threadId == null) return;

    setState(() { _submittingRating = true; });

    final success = await ApiClient.rateSupportThread(
      _threadId!,
      _selectedRating,
      _ratingCommentController.text.trim(),
    );

    if (!mounted) return;
    setState(() {
      _submittingRating = false;
      if (success) _ratingSubmitted = true;
    });

    if (success) {
      _pollTimer?.cancel(); // Stop polling since we're leaving
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Thank you for your feedback! We truly appreciate it. 💛"),
          backgroundColor: Colors.green,
        ),
      );
      // Auto-exit after short delay so user sees the success message
      await Future.delayed(const Duration(seconds: 2));
      if (mounted) {
        Navigator.of(context).pop();
      }
    }
  }

  // ── SCROLL ─────────────────────────────────────────────

  void _scrollToBottom() {
    if (_scrollController.hasClients) {
      Future.delayed(const Duration(milliseconds: 100), () {
        if (_scrollController.hasClients) {
          _scrollController.animateTo(
            _scrollController.position.maxScrollExtent,
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeOut,
          );
        }
      });
    }
  }

  // ── HELPER: GET SENDER NAME ────────────────────────────

  String _getSenderName(Map<String, dynamic>? sender, bool isSystem) {
    if (isSystem || sender == null) return 'Styloria Support';
    final bool isStaff = sender['is_staff'] == true;
    final first = sender['first_name']?.toString() ?? '';
    final last = sender['last_name']?.toString() ?? '';
    final full = '$first $last'.trim();
    String name = full.isNotEmpty ? full : (sender['username']?.toString() ?? 'User');
    if (isStaff) name = '$name (Support agent)';
    return name;
  }

  // ═══════════════════════════════════════════════════════
  // BUILD
  // ═══════════════════════════════════════════════════════

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final primaryColor = Theme.of(context).primaryColor;

    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.chatWithSupportTitle),
        centerTitle: true,
        elevation: 0.5,
        actions: [
          if (_threadActive)
            IconButton(
              icon: const Icon(Icons.refresh, size: 20),
              onPressed: _loadThreadAndMessages,
              tooltip: 'Refresh',
            ),
        ],
      ),
      body: _loading
          ? const Center(child: CircularProgressIndicator())
          : _error != null
              ? Center(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(_error!, style: const TextStyle(color: Colors.red)),
                      const SizedBox(height: 16),
                      ElevatedButton(
                        onPressed: _loadThreadAndMessages,
                        child: const Text('Retry'),
                      ),
                    ],
                  ),
                )
              : Column(
                  children: [
                    // ── MESSAGES LIST ──
                    Expanded(
                      child: ListView.builder(
                        controller: _scrollController,
                        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                        itemCount: _messages.length + (_showRatingWidget ? 1 : 0),
                        itemBuilder: (context, index) {
                          // Rating widget at the bottom
                          if (index == _messages.length && _showRatingWidget) {
                            return _buildRatingWidget();
                          }
                          return _buildMessageBubble(_messages[index], primaryColor);
                        },
                      ),
                    ),

                    // ── INPUT BAR ──
                    _buildInputBar(l10n, primaryColor),
                  ],
                ),
    );
  }

  bool get _showRatingWidget =>
      !_threadActive && !_ratingSubmitted && _threadRated != true;

  // ── MESSAGE BUBBLE ─────────────────────────────────────

  Widget _buildMessageBubble(Map<String, dynamic> msg, Color primaryColor) {
    final sender = msg['sender'] as Map<String, dynamic>?;
    final isSystem = msg['is_system_message'] == true || sender == null;
    
    // THE FIX: Check is_staff properly with fallback
    final bool isSenderStaff = sender?['is_staff'] == true;
    final isMe = !isSystem && !isSenderStaff;
    
    final content = msg['content']?.toString() ?? '';
    final senderName = _getSenderName(sender, isSystem);

    // Parse time
    String timeStr = '';
    try {
      final raw = msg['created_at']?.toString() ?? '';
      if (raw.length >= 16) {
        timeStr = raw.substring(11, 16);
      }
    } catch (_) {}

    // ── SYSTEM MESSAGE ──
    if (isSystem) {
      return Padding(
        padding: const EdgeInsets.symmetric(vertical: 10),
        child: Center(
          child: Container(
            constraints: BoxConstraints(
              maxWidth: MediaQuery.of(context).size.width * 0.85,
            ),
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
            decoration: BoxDecoration(
              color: Colors.grey.shade100,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: Colors.grey.shade300, width: 0.5),
            ),
            child: Column(
              children: [
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.support_agent, size: 14, color: Colors.grey.shade600),
                    const SizedBox(width: 4),
                    Text(
                      'Styloria Support',
                      style: TextStyle(
                        fontSize: 11,
                        fontStyle: FontStyle.italic,
                        fontWeight: FontWeight.w600,
                        color: Colors.grey.shade600,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 6),
                Text(
                  content,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 13,
                    fontStyle: FontStyle.italic,
                    color: Colors.grey.shade700,
                    height: 1.5,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  timeStr,
                  style: TextStyle(fontSize: 10, color: Colors.grey.shade500),
                ),
              ],
            ),
          ),
        ),
      );
    }

    // ── CHAT BUBBLE ──
    // User messages → RIGHT (primaryColor/gold)
    // Support/Admin messages → LEFT (grey/white)
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: isMe ? MainAxisAlignment.end : MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          // Support avatar on left
          if (!isMe) ...[
            CircleAvatar(
              radius: 14,
              backgroundColor: Colors.grey.shade300,
              child: Icon(Icons.support_agent, size: 16, color: Colors.grey.shade700),
            ),
            const SizedBox(width: 8),
          ],

          // Bubble
          Flexible(
            child: Container(
              constraints: BoxConstraints(
                maxWidth: MediaQuery.of(context).size.width * 0.72,
              ),
              padding: const EdgeInsets.fromLTRB(14, 8, 14, 10),
              decoration: BoxDecoration(
                color: isMe ? primaryColor : Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: const Radius.circular(18),
                  topRight: const Radius.circular(18),
                  bottomLeft: isMe ? const Radius.circular(18) : const Radius.circular(4),
                  bottomRight: isMe ? const Radius.circular(4) : const Radius.circular(18),
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.06),
                    blurRadius: 6,
                    offset: const Offset(0, 2),
                  ),
                ],
                border: isMe ? null : Border.all(color: Colors.grey.shade200),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Sender name — italic, small, different color per side
                  Text(
                    isMe ? 'You' : senderName,
                    style: TextStyle(
                      fontSize: 11,
                      fontStyle: FontStyle.italic,
                      fontWeight: FontWeight.w600,
                      color: isMe
                          ? Colors.white.withOpacity(0.8)
                          : Colors.blueGrey.shade600,
                      letterSpacing: 0.2,
                    ),
                  ),
                  const SizedBox(height: 4),

                  // Message content
                  Text(
                    content,
                    style: TextStyle(
                      fontSize: 15,
                      color: isMe ? Colors.white : Colors.black87,
                      height: 1.4,
                    ),
                  ),
                  const SizedBox(height: 4),

                  // Timestamp
                  Align(
                    alignment: Alignment.bottomRight,
                    child: Text(
                      timeStr,
                      style: TextStyle(
                        fontSize: 10,
                        color: isMe ? Colors.white60 : Colors.grey.shade400,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),

          // User avatar on right
          if (isMe) ...[
            const SizedBox(width: 8),
            CircleAvatar(
              radius: 14,
              backgroundColor: primaryColor.withOpacity(0.2),
              child: Icon(Icons.person, size: 16, color: primaryColor),
            ),
          ],
        ],
      ),
    );
  }

  // ── RATING WIDGET ──────────────────────────────────────

  Widget _buildRatingWidget() {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 20, horizontal: 4),
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Colors.amber.shade50, Colors.white],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.amber.shade200),
        boxShadow: [
          BoxShadow(
            color: Colors.amber.withOpacity(0.1),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          // Icon
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.amber.shade100,
              shape: BoxShape.circle,
            ),
            child: Icon(Icons.star_rounded, size: 32, color: Colors.amber.shade700),
          ),
          const SizedBox(height: 16),

          // Title
          const Text(
            "We'd Love Your Feedback!",
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Color(0xFF1a1a2e),
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 8),

          // Message
          Text(
            "Thank you for reaching out to Styloria Support! "
            "Your experience matters deeply to us. We'd be truly grateful if you could "
            "take a moment to rate your conversation and share any thoughts — "
            "it helps us serve you and our community even better.",
            style: TextStyle(
              fontSize: 13,
              color: Colors.grey.shade700,
              height: 1.5,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 20),

          // Stars
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(5, (i) {
              final starNum = i + 1;
              return GestureDetector(
                onTap: () => setState(() => _selectedRating = starNum),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 4),
                  child: AnimatedScale(
                    scale: _selectedRating >= starNum ? 1.2 : 1.0,
                    duration: const Duration(milliseconds: 200),
                    child: Icon(
                      _selectedRating >= starNum ? Icons.star_rounded : Icons.star_outline_rounded,
                      size: 40,
                      color: _selectedRating >= starNum
                          ? Colors.amber.shade600
                          : Colors.grey.shade400,
                    ),
                  ),
                ),
              );
            }),
          ),
          if (_selectedRating > 0) ...[
            const SizedBox(height: 8),
            Text(
              _ratingLabel,
              style: TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w600,
                color: Colors.amber.shade800,
              ),
            ),
          ],
          const SizedBox(height: 16),

          // Comment field
          TextField(
            controller: _ratingCommentController,
            maxLines: 3,
            decoration: InputDecoration(
              hintText: 'Share your thoughts (optional)...',
              hintStyle: TextStyle(color: Colors.grey.shade400, fontSize: 13),
              filled: true,
              fillColor: Colors.white,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(14),
                borderSide: BorderSide(color: Colors.grey.shade300),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(14),
                borderSide: BorderSide(color: Colors.grey.shade300),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(14),
                borderSide: BorderSide(color: Colors.amber.shade400, width: 1.5),
              ),
              contentPadding: const EdgeInsets.all(14),
            ),
          ),
          const SizedBox(height: 16),

          // Submit button
          SizedBox(
            width: double.infinity,
            height: 48,
            child: ElevatedButton(
              onPressed: _selectedRating > 0 && !_submittingRating ? _submitRating : null,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.amber.shade600,
                foregroundColor: Colors.white,
                disabledBackgroundColor: Colors.grey.shade300,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                elevation: 2,
              ),
              child: _submittingRating
                  ? const SizedBox(
                      height: 20,
                      width: 20,
                      child: CircularProgressIndicator(strokeWidth: 2, color: Colors.white),
                    )
                  : const Text(
                      'Submit Feedback',
                      style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
                    ),
            ),
          ),

          const SizedBox(height: 8),
          Text(
            'Your feedback is anonymous and helps improve our service.',
            style: TextStyle(fontSize: 11, color: Colors.grey.shade500),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  String get _ratingLabel {
    switch (_selectedRating) {
      case 1: return '😞 Poor';
      case 2: return '😐 Fair';
      case 3: return '🙂 Good';
      case 4: return '😊 Great';
      case 5: return '🤩 Excellent!';
      default: return '';
    }
  }

  // ── INPUT BAR ──────────────────────────────────────────

  Widget _buildInputBar(AppLocalizations l10n, Color primaryColor) {
    final bool canSend = _threadActive;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, -3),
          ),
        ],
      ),
      child: SafeArea(
        child: !canSend
            ? Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(vertical: 14),
                decoration: BoxDecoration(
                  color: Colors.grey.shade100,
                  borderRadius: BorderRadius.circular(24),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.lock_outline, size: 16, color: Colors.grey.shade500),
                    const SizedBox(width: 8),
                    Text(
                      'This conversation has ended',
                      style: TextStyle(
                        color: Colors.grey.shade500,
                        fontSize: 14,
                        fontStyle: FontStyle.italic,
                      ),
                    ),
                  ],
                ),
              )
            : Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: _inputController,
                      minLines: 1,
                      maxLines: 4,
                      onChanged: (_) => _resetInactivityTimer(),
                      textCapitalization: TextCapitalization.sentences,
                      decoration: InputDecoration(
                        hintText: l10n.typeMessageHint,
                        hintStyle: TextStyle(color: Colors.grey.shade400),
                        filled: true,
                        fillColor: Colors.grey.shade100,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(24),
                          borderSide: BorderSide.none,
                        ),
                        contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: primaryColor,
                      boxShadow: [
                        BoxShadow(
                          color: primaryColor.withOpacity(0.3),
                          blurRadius: 8,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    child: _sending
                        ? const Padding(
                            padding: EdgeInsets.all(12),
                            child: SizedBox(
                              width: 24,
                              height: 24,
                              child: CircularProgressIndicator(strokeWidth: 2, color: Colors.white),
                            ),
                          )
                        : IconButton(
                            icon: const Icon(Icons.send_rounded, color: Colors.white, size: 22),
                            onPressed: _sendMessage,
                          ),
                  ),
                ],
              ),
      ),
    );
  }
}