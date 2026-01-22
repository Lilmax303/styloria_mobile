// lib/support_chat_screen.dart

import 'package:flutter/material.dart';
import 'api_client.dart'; // Ensure this file exists and contains the necessary static methods
import 'package:styloria_mobile/gen_l10n/app_localizations.dart';


class SupportChatScreen extends StatefulWidget {
  const SupportChatScreen({super.key});

  @override
  State<SupportChatScreen> createState() => _SupportChatScreenState();
}

class _SupportChatScreenState extends State<SupportChatScreen> {
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
    final l10n = AppLocalizations.of(context)!;
    setState(() {
      _loading = true;
      _error = null;
    });

    // 1. Get or Create the thread
    final thread = await ApiClient.getOrCreateSupportThread();

    if (!mounted) return;

    if (thread == null) {
      setState(() {
        _loading = false;
        _error = l10n.unableStartSupportChat;
      });
      return;
    }

    final threadId = thread['id'] as int?;
    if (threadId == null) {
      setState(() {
        _loading = false;
        _error = l10n.invalidSupportThreadReturned;
      });
      return;
    }

    // 2. Fetch existing messages
    final messages = await ApiClient.getSupportMessages(threadId);

    setState(() {
      _threadId = threadId;
      _messages = messages ?? [];
      _loading = false;
    });
  }

  Future<void> _sendMessage() async {
    final l10n = AppLocalizations.of(context)!;
    final text = _inputController.text.trim();
    if (text.isEmpty || _threadId == null) return;

    setState(() {
      _sending = true;
      _error = null;
    });

    final msg = await ApiClient.sendSupportMessage(_threadId!, text);

    if (!mounted) return;

    setState(() {
      _sending = false;
    });

    if (msg == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(l10n.messageNotSentPolicy),
          backgroundColor: Colors.red,
        ),
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
    final l10n = AppLocalizations.of(context)!;
    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.chatWithSupportTitle),
      ),
      body: Column(
        children: [
          // Chat Area
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
                            style: const TextStyle(color: Colors.red),
                          ),
                        ),
                      )
                    : RefreshIndicator(
                        onRefresh: () async {
                          if (_threadId != null) {
                            final messages =
                                await ApiClient.getSupportMessages(_threadId!);
                            if (!mounted) return;
                            setState(() {
                              _messages = messages ?? [];
                            });
                          } else {
                            await _loadThreadAndMessages();
                          }
                        },
                        child: _messages.isEmpty
                            ? Center(
                                child: Text(l10n.noMessagesYet),
                              )
                            : ListView.builder(
                                padding: const EdgeInsets.all(12.0),
                                itemCount: _messages.length,
                                itemBuilder: (context, index) {
                                  final msg = _messages[index] as Map<String, dynamic>;
                                  final sender = msg['sender'] as Map<String, dynamic>?;
                                  final senderName = sender?['username']?.toString() ?? 'Support';
                                  final content = msg['content']?.toString() ?? '';
                                  final createdAt = msg['created_at']?.toString() ?? '';

                                  // Simple check to align messages left or right based on sender
                                  // (Assuming 'Support' is the admin, others are the user)
                                  // You may need to adjust this logic based on your API response
                                  final isSupport = senderName == l10n.supportDefaultName;

                                  return Padding(
                                    padding: const EdgeInsets.symmetric(vertical: 4.0),
                                    child: Column(
                                      crossAxisAlignment: isSupport
                                          ? CrossAxisAlignment.start
                                          : CrossAxisAlignment.end,
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
                                          constraints: BoxConstraints(
                                            maxWidth: MediaQuery.of(context).size.width * 0.75,
                                          ),
                                          decoration: BoxDecoration(
                                            color: isSupport
                                                ? Theme.of(context).colorScheme.secondaryContainer
                                                : Theme.of(context).colorScheme.primaryContainer,
                                            borderRadius: BorderRadius.circular(12),
                                          ),
                                          padding: const EdgeInsets.all(12.0),
                                          child: Text(content),
                                        ),
                                        const SizedBox(height: 2),
                                        Text(
                                          createdAt,
                                          style: TextStyle(
                                            fontSize: 10,
                                            color: Colors.grey[600],
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
          // Input Area
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 6.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _inputController,
                    minLines: 1,
                    maxLines: 4,
                    textCapitalization: TextCapitalization.sentences,
                    decoration: InputDecoration(
                      hintText: l10n.typeMessageHint,
                      border: const OutlineInputBorder(),
                      contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
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
                  color: Theme.of(context).primaryColor,
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