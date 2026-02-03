// lib/chat_screen.dart

import 'package:flutter/material.dart';
import 'dart:async';
import 'api_client.dart';
import 'package:styloria_mobile/gen_l10n/app_localizations.dart';
import 'utils/datetime_helper.dart';
import 'services/notification_service.dart';

class ChatScreen extends StatefulWidget {
  final int serviceRequestId;
  final Map<String, dynamic> booking;

  const ChatScreen({
    super.key,
    required this.serviceRequestId,
    required this.booking,
  });

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  int? _threadId;
  bool _loading = true;
  bool _sending = false;
  String? _error;
  List<dynamic> _messages = [];
  final TextEditingController _inputController = TextEditingController();
  final ScrollController _scrollController = ScrollController();

  // Current user info to determine message alignment
  int? _currentUserId;
  String? _currentUsername;

  // Subscription to chat message notifications
  StreamSubscription? _chatSubscription;

  @override
  void initState() {
    super.initState();
    _loadCurrentUser();
    _loadThreadAndMessages();
    _subscribeToMessages();
  }

  @override
  void dispose() {
    _inputController.dispose();
    _scrollController.dispose();
    _chatSubscription?.cancel();
    super.dispose();
  }

  void _subscribeToMessages() {
    _chatSubscription = NotificationService.instance.chatMessages.listen((notification) {
      // Check if this message is for our current thread
      final threadId = notification['thread_id'];
      final senderId = notification['sender_id'];

      // Only refresh if:
      // 1. It's for this thread
      // 2. It's not from us (we already added our own messages)
      if (threadId == _threadId && senderId != _currentUserId) {
        _refreshMessages();
      }
    });
  }

  Future<void> _refreshMessages() async {
    if (_threadId == null) return;

    final messages = await ApiClient.getChatMessages(_threadId!);
    if (!mounted) return;

    setState(() {
      _messages = messages ?? [];
    });

    _scrollToBottom();
  }

  Future<void> _loadCurrentUser() async {
    final user = await ApiClient.getCurrentUser();
    if (!mounted) return;
    setState(() {
      _currentUserId = user?['id'] as int?;
      _currentUsername = user?['username']?.toString();
    });
  }

  Future<void> _loadThreadAndMessages() async {
    setState(() {
      _loading = true;
      _error = null;
    });

    final thread = await ApiClient.getOrCreateChatThreadForRequest(
      widget.serviceRequestId,
    );

    if (!mounted) return;

    if (thread == null) {
      setState(() {
        _loading = false;
        _error = AppLocalizations.of(context).unableToStartChat;
      });
      return;
    }

    final threadId = thread['id'] as int?;
    if (threadId == null) {
      setState(() {
        _loading = false;
        _error = AppLocalizations.of(context).invalidChatThreadFromServer;
      });
      return;
    }

    final messages = await ApiClient.getChatMessages(threadId);

    if (!mounted) return;

    setState(() {
      _threadId = threadId;
      _messages = messages ?? [];
      _loading = false;
    });

    // Scroll to bottom after loading messages
    _scrollToBottom();
  }

  void _scrollToBottom() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_scrollController.hasClients) {
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
    });
  }

  bool _isMyMessage(Map<String, dynamic> msg) {
    final sender = msg['sender'] as Map<String, dynamic>?;
    if (sender == null) return false;
    
    // Try matching by ID first (most reliable)
    final senderId = sender['id'];
    if (_currentUserId != null && senderId != null) {
      if (senderId is int) {
        return senderId == _currentUserId;
      }
      return int.tryParse(senderId.toString()) == _currentUserId;
    }
    
    // Fallback to username matching
    final senderUsername = sender['username']?.toString();
    if (_currentUsername != null && senderUsername != null) {
      return senderUsername == _currentUsername;
    }

    return false;
  }

  Future<void> _sendMessage() async {
    final text = _inputController.text.trim();
    if (text.isEmpty || _threadId == null) return;

    setState(() {
      _sending = true;
      _error = null;
    });

    final msg = await ApiClient.sendChatMessage(_threadId!, text);

    if (!mounted) return;

    setState(() {
      _sending = false;
    });

    if (msg == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(AppLocalizations.of(context).messageNotSentPolicy)),
      );
      return;
    }

    _inputController.clear();

    setState(() {
      _messages.add(msg);
    });

    // Scroll to bottom after sending
    _scrollToBottom();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final id = widget.booking['id']?.toString() ?? '';
    final cs = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.chatForBookingTitle(id)),
      ),
      body: Column(
        children: [
          Expanded(
            child: _loading
                ? const Center(child: CircularProgressIndicator())
                : _error != null
                    ? Center(
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Text(
                            _error!,
                            textAlign: TextAlign.center,
                          ),
                        ),
                      )
                    : RefreshIndicator(
                        onRefresh: () async {
                          if (_threadId != null) {
                            final messages =
                                await ApiClient.getChatMessages(_threadId!);
                            if (!mounted) return;
                            setState(() {
                              _messages = messages ?? [];
                            });
                          } else {
                            await _loadThreadAndMessages();
                          }
                        },
                        child: ListView.builder(
                          controller: _scrollController,
                          padding: const EdgeInsets.all(12.0),
                          itemCount: _messages.length,
                          itemBuilder: (context, index) {
                            final msg = _messages[index] as Map<String, dynamic>;
                            final sender = msg['sender'] as Map<String, dynamic>?;
                            final senderName =
                                sender?['username']?.toString() ?? l10n.unknown;
                            final content = msg['content']?.toString() ?? '';
                            final createdAt = msg['created_at']?.toString() ?? '';
                            final isMe = _isMyMessage(msg);

                            return _buildMessageBubble(
                              context: context,
                              content: content,
                              senderName: senderName,
                              createdAt: createdAt,
                              isMe: isMe,
                            );
                          },
                        ),
                      ),
          ),
          const Divider(height: 1),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 6.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _inputController,
                    minLines: 1,
                    maxLines: 4,
                    textInputAction: TextInputAction.send,
                    onSubmitted: (_) => _sendMessage(),
                    decoration: InputDecoration(
                      hintText: l10n.typeMessageHint,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(24),
                      ),
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 10,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                Container(
                  decoration: BoxDecoration(
                    color: cs.primary,
                    shape: BoxShape.circle,
                  ),
                  child: IconButton(
                    icon: _sending
                        ? SizedBox(
                            height: 18,
                            width: 18,
                            child: CircularProgressIndicator(
                              strokeWidth: 2,
                              color: cs.onPrimary,
                            ),
                          )
                        : Icon(Icons.send, color: cs.onPrimary),
                    onPressed: _sending ? null : _sendMessage,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMessageBubble({
    required BuildContext context,
    required String content,
    required String senderName,
    required String createdAt,
    required bool isMe,
  }) {
    final cs = Theme.of(context).colorScheme;
    
    // Colors for message bubbles
    final myBubbleColor = cs.primary;
    final myTextColor = cs.onPrimary;
    final otherBubbleColor = Colors.grey.shade200;
    final otherTextColor = Colors.black87;
    
    // Bubble border radius
    final myBorderRadius = const BorderRadius.only(
      topLeft: Radius.circular(16),
      topRight: Radius.circular(16),
      bottomLeft: Radius.circular(16),
      bottomRight: Radius.circular(4), // Small corner on sender's side
    );
    
    final otherBorderRadius = const BorderRadius.only(
      topLeft: Radius.circular(16),
      topRight: Radius.circular(16),
      bottomLeft: Radius.circular(4), // Small corner on sender's side
      bottomRight: Radius.circular(16),
    );
    
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        mainAxisAlignment: isMe ? MainAxisAlignment.end : MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          if (isMe) const Spacer(flex: 1), // Push to right for my messages
          
          Flexible(
            flex: 3,
            child: Column(
              crossAxisAlignment: isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
              children: [
                // Show sender name only for other person's messages
                if (!isMe) ...[
                  Padding(
                    padding: const EdgeInsets.only(left: 8, bottom: 2),
                    child: Text(
                      senderName,
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 11,
                        color: Colors.grey.shade600,
                      ),
                    ),
                  ),
                ],
                
                // Message bubble
                Container(
                  decoration: BoxDecoration(
                    color: isMe ? myBubbleColor : otherBubbleColor,
                    borderRadius: isMe ? myBorderRadius : otherBorderRadius,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.05),
                        blurRadius: 2,
                        offset: const Offset(0, 1),
                      ),
                    ],
                  ),
                  constraints: BoxConstraints(
                    maxWidth: MediaQuery.of(context).size.width * 0.75,
                  ),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 14,
                    vertical: 10,
                  ),
                  child: Text(
                    content,
                    style: TextStyle(
                      color: isMe ? myTextColor : otherTextColor,
                      fontSize: 15,
                    ),
                  ),
                ),
                
                // Timestamp
                Padding(
                  padding: EdgeInsets.only(
                    top: 2,
                    left: isMe ? 0 : 8,
                    right: isMe ? 8 : 0,
                  ),
                  child: Text(
                    createdAt.isNotEmpty
                        ? DateTimeHelper.formatMetadataTime(createdAt)
                        : '',
                    style: TextStyle(
                      fontSize: 10,
                      color: Colors.grey.shade500,
                    ),
                  ),
                ),
              ],
            ),
          ),
          
          if (!isMe) const Spacer(flex: 1), // Push to left for other's messages
        ],
      ),
    );
  }
}