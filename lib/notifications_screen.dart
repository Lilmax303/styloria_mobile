// lib/notifications_screen.dart

import 'package:flutter/material.dart';
import 'api_client.dart';
import 'package:styloria_mobile/gen_l10n/app_localizations.dart';
import 'utils/datetime_helper.dart';

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
        SnackBar(
          content: Text(
            AppLocalizations.of(context).failedToMarkAsRead,
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final l10n = AppLocalizations.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.navNotifications),
      ),
      body: _loading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : _error != null
              ? Center(
                  child: Text(_error!),
                )
              : _notifications == null || _notifications!.isEmpty
                  ? Center(
                      child: Text(l10n.noNotificationsYet),
                    )
                  : RefreshIndicator(
                      onRefresh: _loadNotifications,
                      child: ListView.builder(
                        padding: const EdgeInsets.all(8.0),
                        itemCount: _notifications!.length,
                        itemBuilder: (context, index) {
                          final n =
                              _notifications![index] as Map<String, dynamic>;

                          final id = n['id'] as int;
                          final message = n['message']?.toString() ?? '';
                          final read = n['read'] as bool? ?? false;

                          final createdAt =
                              n['timestamp']?.toString() ??
                                  n['created_at']?.toString() ??
                                  '';

                          // ✅ Format timestamp
                          final timeDisplay = createdAt.isNotEmpty
                              ? DateTimeHelper.formatMetadataTime(createdAt)
                              : '';

                          // ✅ Card color for unread
                          final Color cardColor = read
                              ? theme.cardColor
                              : (isDark
                                  ? theme.colorScheme.primary.withAlpha(64)
                                  : Colors.blue.shade50);

                          // ✅ Notification icon
                          IconData notificationIcon = Icons.notifications;
                          Color iconColor = theme.colorScheme.primary;

                          if (message.contains('Good news') ||
                              message.contains('available')) {
                            notificationIcon = Icons.celebration;
                            iconColor = Colors.green;
                          } else if (message.contains('sorry') ||
                              message.contains('no available')) {
                            notificationIcon = Icons.info_outline;
                            iconColor = Colors.orange;
                          } else if (message.contains('Payment') ||
                              message.contains('paid')) {
                            notificationIcon = Icons.payment;
                            iconColor = Colors.blue;
                          }

                          return Card(
                            color: cardColor,
                            elevation: read ? 0 : 2,
                            margin: const EdgeInsets.symmetric(
                              horizontal: 8,
                              vertical: 4,
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                              side: read
                                  ? BorderSide.none
                                  : BorderSide(
                                      color: theme.colorScheme.primary
                                          .withOpacity(0.3),
                                      width: 1,
                                    ),
                            ),
                            child: ListTile(
                              // ✅ Leading icon
                              leading: Container(
                                padding: const EdgeInsets.all(8),
                                decoration: BoxDecoration(
                                  color: iconColor.withOpacity(0.1),
                                  shape: BoxShape.circle,
                                ),
                                child: Icon(
                                  notificationIcon,
                                  color: iconColor,
                                  size: 20,
                                ),
                              ),

                              title: Text(
                                message,
                                style: TextStyle(
                                  fontWeight: read
                                      ? FontWeight.normal
                                      : FontWeight.w600,
                                ),
                              ),

                              subtitle: timeDisplay.isNotEmpty
                                  ? Padding(
                                      padding:
                                          const EdgeInsets.only(top: 4),
                                      child: Row(
                                        children: [
                                          Icon(
                                            Icons.access_time,
                                            size: 12,
                                            color: theme.textTheme.bodySmall
                                                ?.color,
                                          ),
                                          const SizedBox(width: 4),
                                          Text(
                                            timeDisplay,
                                            style: theme
                                                .textTheme.bodySmall
                                                ?.copyWith(
                                                  fontSize: 11,
                                                ),
                                          ),
                                        ],
                                      ),
                                    )
                                  : null,

                              // ✅ Trailing action
                              trailing: read
                                  ? Container(
                                      padding: const EdgeInsets.all(6),
                                      decoration: BoxDecoration(
                                        color: Colors.green
                                            .withOpacity(0.1),
                                        shape: BoxShape.circle,
                                      ),
                                      child: const Icon(
                                        Icons.check,
                                        color: Colors.green,
                                        size: 16,
                                      ),
                                    )
                                  : OutlinedButton(
                                      onPressed: () => _markRead(id),
                                      style: OutlinedButton.styleFrom(
                                        padding:
                                            const EdgeInsets.symmetric(
                                          horizontal: 12,
                                          vertical: 4,
                                        ),
                                        minimumSize: Size.zero,
                                        tapTargetSize:
                                            MaterialTapTargetSize
                                                .shrinkWrap,
                                      ),
                                      child: Text(
                                        l10n.markRead,
                                        style: const TextStyle(
                                          fontSize: 11,
                                        ),
                                      ),
                                    ),
                            ),
                          );
                        },
                      ),
                    ),
    );
  }
}
