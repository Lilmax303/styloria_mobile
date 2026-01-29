// lib/chat_screen.dart

import 'package:flutter/material.dart';
import 'api_client.dart';
import 'package:styloria_mobile/gen_l10n/app_localizations.dart';
import 'utils/datetime_helper.dart';

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

  @override
  void initState() {
    super.initState();
    _loadThreadAndMessages();
  }

  @override
  void dispose() {
    _inputController.dispose();
    super.dispose();
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
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final id = widget.booking['id']?.toString() ?? '';
    final timeColor = Theme.of(context).textTheme.bodySmall?.color;

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
                          padding: const EdgeInsets.all(12.0),
                          itemCount: _messages.length,
                          itemBuilder: (context, index) {
                            final msg = _messages[index] as Map<String, dynamic>;
                            final sender = msg['sender'] as Map<String, dynamic>?;
                            final senderName =
                                sender?['username']?.toString() ?? l10n.unknown;
                            final content = msg['content']?.toString() ?? '';
                            final createdAt = msg['created_at']?.toString() ?? '';

                            return Padding(
                              padding: const EdgeInsets.symmetric(vertical: 4.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    senderName,
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 12,
                                    ),
                                  ),
                                  const SizedBox(height: 2),
                                  Container(
                                    decoration: BoxDecoration(
                                      color: Theme.of(context)
                                          .colorScheme
                                          .primary
                                          .withAlpha(20),
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(content),
                                  ),
                                  const SizedBox(height: 2),
                                  // ✅ IMPROVED: Timezone-aware timestamp
                                  Text(
                                    createdAt.isNotEmpty
                                        ? DateTimeHelper.formatMetadataTime(createdAt)
                                        : '',
                                    style: TextStyle(
                                      fontSize: 10,
                                      color: timeColor,
                                    ),
                                  ),
                                ],
                              ),
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
                    decoration: InputDecoration(
                      hintText: l10n.typeMessageHint,
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                IconButton(
                  icon: _sending
                      ? const SizedBox(
                          height: 18,
                          width: 18,
                          child: CircularProgressIndicator(strokeWidth: 2),
                        )
                      : const Icon(Icons.send),
                  onPressed: _sending ? null : _sendMessage,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}