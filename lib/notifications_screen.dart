// lib/notifications_screen.dart

import 'package:flutter/material.dart';
import 'api_client.dart';
import 'package:styloria_mobile/gen_l10n/app_localizations.dart';

class NotificationsScreen extends StatefulWidget {
  const NotificationsScreen({super.key});

  @override
  State<NotificationsScreen> createState() => _NotificationsScreenState();
}

class _NotificationsScreenState extends State<NotificationsScreen> {
  bool _loading = true;
  String? _error;
  List<dynamic>? _notifications;

  @override
  void initState() {
    super.initState();
    _loadNotifications();
  }

  Future<void> _loadNotifications() async {
    setState(() {
      _loading = true;
      _error = null;
    });

    final data = await ApiClient.getNotifications();

    if (!mounted) return;

    setState(() {
      _loading = false;
      if (data == null) {
        _error = AppLocalizations.of(context).failedToLoadNotifications;
      } else {
        _notifications = data;
      }
    });
  }

  Future<void> _markRead(int id) async {
    final ok = await ApiClient.markNotificationRead(id);
    if (ok) {
      _loadNotifications();
    } else {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(AppLocalizations.of(context).failedToMarkAsRead)),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final l10n = AppLocalizations.of(context);

    return Scaffold(
      appBar: AppBar(title: Text(l10n.navNotifications)),
      body: _loading
          ? const Center(child: CircularProgressIndicator())
          : _error != null
              ? Center(child: Text(_error!))
              : _notifications == null || _notifications!.isEmpty
                  ? Center(child: Text(l10n.noNotificationsYet))
                  : RefreshIndicator(
                      onRefresh: _loadNotifications,
                      child: ListView.builder(
                        padding: const EdgeInsets.all(8.0),
                        itemCount: _notifications!.length,
                        itemBuilder: (context, index) {
                          final n = _notifications![index] as Map<String, dynamic>;
                          final id = n['id'] as int;
                          final message = n['message']?.toString() ?? '';
                          final read = n['read'] as bool? ?? false;
                          final createdAt =
                              n['timestamp']?.toString() ??
                                  n['created_at']?.toString() ??
                                  '';

                          final Color cardColor = read
                              ? theme.cardColor
                              : (isDark
                                  ? theme.colorScheme.primary.withAlpha(64) // ~25%
                                  : Colors.blue.shade50);

                          return Card(
                            color: cardColor,
                            child: ListTile(
                              title: Text(message),
                              subtitle: Text(
                                createdAt,
                                style: theme.textTheme.bodySmall,
                              ),
                              trailing: read
                                  ? Icon(
                                      Icons.check,
                                      color: theme.colorScheme.secondary,
                                    )
                                  : TextButton(
                                      onPressed: () => _markRead(id),
                                      child: Text(l10n.markRead),
                                    ),
                            ),
                          );
                        },
                      ),
                    ),
    );
  }
}