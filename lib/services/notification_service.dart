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
  
  // View more/less state
  bool _expanded = false;
  static const int _initialItemsToShow = 10;

  // Multi-select state
  bool _isSelectionMode = false;
  final Set<int> _selectedIds = {};

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
      // Exit selection mode on refresh
      _isSelectionMode = false;
      _selectedIds.clear();
    });
  }

  // ==================== SELECTION MODE METHODS ====================

  void _enterSelectionMode(int initialId) {
    setState(() {
      _isSelectionMode = true;
      _selectedIds.add(initialId);
    });
  }

  void _exitSelectionMode() {
    setState(() {
      _isSelectionMode = false;
      _selectedIds.clear();
    });
  }

  void _toggleSelection(int id) {
    setState(() {
      if (_selectedIds.contains(id)) {
        _selectedIds.remove(id);
        // Exit selection mode if no items selected
        if (_selectedIds.isEmpty) {
          _isSelectionMode = false;
        }
      } else {
        _selectedIds.add(id);
      }
    });
  }

  void _selectAll() {
    if (_notifications == null) return;
    setState(() {
      _selectedIds.clear();
      for (final n in _notifications!) {
        final id = n['id'] as int?;
        if (id != null) {
          _selectedIds.add(id);
        }
      }
    });
  }

  void _deselectAll() {
    setState(() {
      _selectedIds.clear();
    });
  }

  Future<void> _deleteSelected() async {
    if (_selectedIds.isEmpty) return;

    final count = _selectedIds.length;
    final confirm = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Delete Selected'),
        content: Text('Are you sure you want to delete $count notification(s)? This cannot be undone.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx, false),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () => Navigator.pop(ctx, true),
            style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
            child: const Text('Delete'),
          ),
        ],
      ),
    );

    if (confirm != true) return;

    // Store for potential restoration
    final idsToDelete = _selectedIds.toList();
    final removedItems = <int, Map<String, dynamic>>{};
    
    for (final id in idsToDelete) {
      final index = _notifications?.indexWhere((n) => n['id'] == id) ?? -1;
      if (index >= 0) {
        removedItems[id] = Map<String, dynamic>.from(_notifications![index]);
      }
    }

    // Optimistically remove from UI
    setState(() {
      _notifications?.removeWhere((n) => idsToDelete.contains(n['id']));
      _selectedIds.clear();
      _isSelectionMode = false;
    });

    // Call API
    final result = await ApiClient.deleteSelectedNotifications(idsToDelete);
    
    if (!mounted) return;

    final deletedCount = result['deleted_count'] ?? 0;
    
    if (deletedCount > 0) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Deleted $deletedCount notification(s)'),
          duration: const Duration(seconds: 2),
        ),
      );
    } else {
      // Restore on failure
      setState(() {
        for (final entry in removedItems.entries) {
          _notifications?.add(entry.value);
        }
        // Re-sort by timestamp/id
        _notifications?.sort((a, b) {
          final aTime = a['timestamp'] ?? a['created_at'] ?? '';
          final bTime = b['timestamp'] ?? b['created_at'] ?? '';
          return bTime.compareTo(aTime);
        });
      });
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Failed to delete notifications'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  // ==================== EXISTING METHODS ====================

  Future<void> _markRead(int id) async {
    final ok = await ApiClient.markNotificationRead(id);
    if (ok) {
      setState(() {
        final index = _notifications?.indexWhere((n) => n['id'] == id);
        if (index != null && index >= 0) {
          _notifications![index]['read'] = true;
        }
      });
    } else {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(AppLocalizations.of(context).failedToMarkAsRead)),
      );
    }
  }

  Future<void> _deleteNotification(int id) async {
    final ok = await ApiClient.deleteNotification(id);
    
    if (!mounted) return;
    
    if (ok) {
      setState(() {
        _notifications?.removeWhere((n) => n['id'] == id);
      });
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Notification deleted'),
          duration: Duration(seconds: 2),
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Failed to delete notification')),
      );
    }
  }

  void _handleSwipeDelete(int id) {
    final removedIndex = _notifications?.indexWhere((n) => n['id'] == id) ?? -1;
    if (removedIndex < 0) return;
    
    final removedItem = Map<String, dynamic>.from(_notifications![removedIndex]);
    
    setState(() {
      _notifications!.removeAt(removedIndex);
    });
    
    ApiClient.deleteNotification(id).then((ok) {
      if (!mounted) return;
      
      if (ok) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Notification deleted'),
            duration: Duration(seconds: 2),
          ),
        );
      } else {
        setState(() {
          final insertAt = removedIndex.clamp(0, _notifications?.length ?? 0);
          _notifications?.insert(insertAt, removedItem);
        });
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Failed to delete notification. Restored.'),
            backgroundColor: Colors.orange,
          ),
        );
      }
    }).catchError((e) {
      if (!mounted) return;
      setState(() {
        final insertAt = removedIndex.clamp(0, _notifications?.length ?? 0);
        _notifications?.insert(insertAt, removedItem);
      });
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Network error. Notification restored.'),
          backgroundColor: Colors.red,
        ),
      );
    });
  }

  Future<void> _markAllRead() async {
    final ok = await ApiClient.markAllNotificationsRead();
    if (ok) {
      setState(() {
        for (var n in _notifications ?? []) {
          n['read'] = true;
        }
      });
    }
  }

  Future<void> _clearAll() async {
    final confirm = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Clear All Notifications'),
        content: const Text('Are you sure you want to delete all notifications? This cannot be undone.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx, false),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () => Navigator.pop(ctx, true),
            style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
            child: const Text('Clear All'),
          ),
        ],
      ),
    );

    if (confirm != true) return;

    final ok = await ApiClient.clearAllNotifications();
    if (ok) {
      setState(() {
        _notifications = [];
        _isSelectionMode = false;
        _selectedIds.clear();
      });
    }
  }

  void _openNotificationDetail(Map<String, dynamic> notification) {
    // Don't open detail in selection mode - toggle selection instead
    if (_isSelectionMode) {
      _toggleSelection(notification['id'] as int);
      return;
    }

    final id = notification['id'] as int;
    final read = notification['read'] as bool? ?? false;

    if (!read) {
      _markRead(id);
    }

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (ctx) => _NotificationDetailSheet(
        notification: notification,
        onDelete: () {
          Navigator.pop(ctx);
          _deleteNotification(id);
        },
      ),
    );
  }

  _NotificationStyle _getNotificationStyle(String message) {
    if (message.contains('Good news') || message.contains('available')) {
      return _NotificationStyle(Icons.celebration, Colors.green, 'Good News');
    } else if (message.contains('sorry') || message.contains('no available')) {
      return _NotificationStyle(Icons.info_outline, Colors.orange, 'Info');
    } else if (message.contains('Payment') || message.contains('paid')) {
      return _NotificationStyle(Icons.payment, Colors.blue, 'Payment');
    } else if (message.contains('cancelled')) {
      return _NotificationStyle(Icons.cancel, Colors.red, 'Cancellation');
    } else if (message.contains('accepted')) {
      return _NotificationStyle(Icons.check_circle, Colors.green, 'Accepted');
    } else if (message.contains('completed')) {
      return _NotificationStyle(Icons.task_alt, Colors.teal, 'Completed');
    } else if (message.contains('message') || message.contains('💬')) {
      return _NotificationStyle(Icons.chat_bubble, Colors.purple, 'Message');
    } else if (message.contains('review') || message.contains('rating')) {
      return _NotificationStyle(Icons.star, Colors.amber, 'Review');
    } else if (message.contains('New Job') || message.contains('🆕')) {
      return _NotificationStyle(Icons.work, Colors.indigo, 'New Job');
    }
    return _NotificationStyle(Icons.notifications, Colors.blueGrey, 'Notification');
  }

  Map<String, List<Map<String, dynamic>>> _groupNotificationsByDate() {
    final Map<String, List<Map<String, dynamic>>> grouped = {
      'Today': [],
      'Yesterday': [],
      'This Week': [],
      'Earlier': [],
    };

    if (_notifications == null) return grouped;

    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final yesterday = today.subtract(const Duration(days: 1));
    final weekAgo = today.subtract(const Duration(days: 7));

    for (final n in _notifications!) {
      final notification = n as Map<String, dynamic>;
      final timestampStr = notification['timestamp']?.toString() ??
          notification['created_at']?.toString() ??
          '';

      DateTime? timestamp;
      if (timestampStr.isNotEmpty) {
        try {
          timestamp = DateTime.parse(timestampStr).toLocal();
        } catch (_) {}
      }

      if (timestamp == null) {
        grouped['Earlier']!.add(notification);
        continue;
      }

      final notificationDate = DateTime(timestamp.year, timestamp.month, timestamp.day);

      if (notificationDate == today) {
        grouped['Today']!.add(notification);
      } else if (notificationDate == yesterday) {
        grouped['Yesterday']!.add(notification);
      } else if (notificationDate.isAfter(weekAgo)) {
        grouped['This Week']!.add(notification);
      } else {
        grouped['Earlier']!.add(notification);
      }
    }

    return grouped;
  }

  // ==================== BUILD METHODS ====================

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final cs = theme.colorScheme;
    final isDark = theme.brightness == Brightness.dark;
    final l10n = AppLocalizations.of(context);

    final unreadCount = _notifications?.where((n) => n['read'] != true).length ?? 0;
    final totalCount = _notifications?.length ?? 0;
    final allSelected = _selectedIds.length == totalCount && totalCount > 0;

    return Scaffold(
      appBar: _isSelectionMode 
          ? _buildSelectionAppBar(cs, allSelected)
          : _buildNormalAppBar(cs, l10n, unreadCount),
      body: _buildBody(theme, cs, isDark, l10n),
    );
  }

  PreferredSizeWidget _buildNormalAppBar(ColorScheme cs, AppLocalizations l10n, int unreadCount) {
    return AppBar(
      title: Row(
        children: [
          Text(l10n.navNotifications),
          if (unreadCount > 0) ...[
            const SizedBox(width: 8),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
              decoration: BoxDecoration(
                color: cs.primary,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Text(
                '$unreadCount',
                style: TextStyle(
                  color: cs.onPrimary,
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ],
      ),
      actions: [
        if (_notifications != null && _notifications!.isNotEmpty) ...[
          // Select mode button
          IconButton(
            icon: const Icon(Icons.checklist),
            tooltip: 'Select notifications',
            onPressed: () {
              setState(() {
                _isSelectionMode = true;
              });
            },
          ),
          PopupMenuButton<String>(
            icon: const Icon(Icons.more_vert),
            onSelected: (value) {
              switch (value) {
                case 'mark_all':
                  _markAllRead();
                  break;
                case 'clear_all':
                  _clearAll();
                  break;
              }
            },
            itemBuilder: (ctx) => [
              PopupMenuItem(
                value: 'mark_all',
                child: Row(
                  children: [
                    Icon(Icons.done_all, color: cs.primary, size: 20),
                    const SizedBox(width: 12),
                    const Text('Mark all as read'),
                  ],
                ),
              ),
              const PopupMenuItem(
                value: 'clear_all',
                child: Row(
                  children: [
                    Icon(Icons.delete_sweep, color: Colors.red, size: 20),
                    SizedBox(width: 12),
                    Text('Clear all', style: TextStyle(color: Colors.red)),
                  ],
                ),
              ),
            ],
          ),
        ],
      ],
    );
  }

  PreferredSizeWidget _buildSelectionAppBar(ColorScheme cs, bool allSelected) {
    return AppBar(
      leading: IconButton(
        icon: const Icon(Icons.close),
        onPressed: _exitSelectionMode,
      ),
      title: Text(
        '${_selectedIds.length} selected',
        style: const TextStyle(fontWeight: FontWeight.w600),
      ),
      backgroundColor: cs.primaryContainer,
      foregroundColor: cs.onPrimaryContainer,
      actions: [
        // Select/Deselect All
        IconButton(
          icon: Icon(allSelected ? Icons.deselect : Icons.select_all),
          tooltip: allSelected ? 'Deselect all' : 'Select all',
          onPressed: allSelected ? _deselectAll : _selectAll,
        ),
        // Delete selected
        if (_selectedIds.isNotEmpty)
          IconButton(
            icon: const Icon(Icons.delete),
            tooltip: 'Delete selected',
            onPressed: _deleteSelected,
          ),
      ],
    );
  }

  Widget _buildBody(ThemeData theme, ColorScheme cs, bool isDark, AppLocalizations l10n) {
    if (_loading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (_error != null) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.error_outline, size: 64, color: Colors.grey[400]),
            const SizedBox(height: 16),
            Text(_error!, style: TextStyle(color: Colors.grey[600])),
            const SizedBox(height: 16),
            ElevatedButton.icon(
              onPressed: _loadNotifications,
              icon: const Icon(Icons.refresh),
              label: const Text('Retry'),
            ),
          ],
        ),
      );
    }

    if (_notifications == null || _notifications!.isEmpty) {
      return _buildEmptyState(cs);
    }

    final grouped = _groupNotificationsByDate();
    
    final List<dynamic> displayItems = [];
    int totalAdded = 0;
    
    for (final section in ['Today', 'Yesterday', 'This Week', 'Earlier']) {
      final items = grouped[section]!;
      if (items.isEmpty) continue;
      
      displayItems.add({'_isHeader': true, 'title': section, 'count': items.length});
      
      for (final item in items) {
        if (!_expanded && totalAdded >= _initialItemsToShow) break;
        displayItems.add(item);
        totalAdded++;
      }
      
      if (!_expanded && totalAdded >= _initialItemsToShow) break;
    }

    final totalNotifications = _notifications!.length;
    final hasMore = totalNotifications > _initialItemsToShow;

    return Column(
      children: [
        // Selection mode hint
        if (_isSelectionMode)
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            color: Colors.blue.shade50,
            child: Row(
              children: [
                Icon(Icons.info_outline, size: 16, color: Colors.blue.shade700),
                const SizedBox(width: 8),
                Text(
                  'Tap notifications to select. Long press to exit.',
                  style: TextStyle(fontSize: 12, color: Colors.blue.shade700),
                ),
              ],
            ),
          ),
        Expanded(
          child: RefreshIndicator(
            onRefresh: _loadNotifications,
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(vertical: 8),
              itemCount: displayItems.length + (hasMore ? 1 : 0),
              itemBuilder: (context, index) {
                if (index == displayItems.length) {
                  return _buildViewMoreButton(totalNotifications);
                }

                final item = displayItems[index];

                if (item is Map && item['_isHeader'] == true) {
                  return _buildSectionHeader(item['title'], item['count'], cs);
                }

                final notification = item as Map<String, dynamic>;
                return _buildNotificationCard(notification, theme, cs, isDark);
              },
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildEmptyState(ColorScheme cs) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              color: cs.primaryContainer.withOpacity(0.3),
              shape: BoxShape.circle,
            ),
            child: Icon(
              Icons.notifications_none,
              size: 64,
              color: cs.primary.withOpacity(0.5),
            ),
          ),
          const SizedBox(height: 24),
          Text(
            'No notifications yet',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w600,
              color: Colors.grey[700],
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'When you get notifications, they\'ll show up here',
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey[500],
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildSectionHeader(String title, int count, ColorScheme cs) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
      child: Row(
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w700,
              color: cs.primary,
              letterSpacing: 0.5,
            ),
          ),
          const SizedBox(width: 8),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
            decoration: BoxDecoration(
              color: cs.primaryContainer,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Text(
              '$count',
              style: TextStyle(
                fontSize: 11,
                fontWeight: FontWeight.bold,
                color: cs.onPrimaryContainer,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildNotificationCard(
    Map<String, dynamic> notification,
    ThemeData theme,
    ColorScheme cs,
    bool isDark,
  ) {
    final id = notification['id'] as int;
    final message = notification['message']?.toString() ?? '';
    final read = notification['read'] as bool? ?? false;
    final createdAt = notification['timestamp']?.toString() ??
        notification['created_at']?.toString() ??
        '';

    final style = _getNotificationStyle(message);
    final timeDisplay = createdAt.isNotEmpty
        ? DateTimeHelper.formatMetadataTime(createdAt)
        : '';

    final isSelected = _selectedIds.contains(id);

    // Card colors
    Color cardColor;
    if (isSelected) {
      cardColor = cs.primaryContainer;
    } else if (read) {
      cardColor = isDark ? cs.surface : Colors.white;
    } else {
      cardColor = isDark ? cs.primary.withOpacity(0.15) : cs.primary.withOpacity(0.08);
    }

    final borderColor = isSelected
        ? cs.primary
        : read
            ? Colors.transparent
            : cs.primary.withOpacity(0.3);

    // In selection mode, don't use Dismissible
    if (_isSelectionMode) {
      return Card(
        color: cardColor,
        elevation: isSelected ? 2 : (read ? 0 : 2),
        margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
          side: BorderSide(color: borderColor, width: isSelected ? 2 : 1),
        ),
        child: InkWell(
          onTap: () => _toggleSelection(id),
          onLongPress: _exitSelectionMode,
          borderRadius: BorderRadius.circular(12),
          child: Padding(
            padding: const EdgeInsets.all(12),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Checkbox
                Checkbox(
                  value: isSelected,
                  onChanged: (_) => _toggleSelection(id),
                  activeColor: cs.primary,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(4),
                  ),
                ),
                const SizedBox(width: 8),
                // Icon
                Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: style.color.withOpacity(0.1),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(style.icon, color: style.color, size: 22),
                ),
                const SizedBox(width: 12),
                // Content
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                        decoration: BoxDecoration(
                          color: style.color.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: Text(
                          style.label,
                          style: TextStyle(
                            fontSize: 10,
                            fontWeight: FontWeight.w600,
                            color: style.color,
                          ),
                        ),
                      ),
                      const SizedBox(height: 6),
                      Text(
                        message,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: read ? FontWeight.normal : FontWeight.w600,
                          color: isDark ? Colors.white : Colors.black87,
                        ),
                      ),
                      const SizedBox(height: 6),
                      Row(
                        children: [
                          Icon(Icons.access_time, size: 12, color: Colors.grey[500]),
                          const SizedBox(width: 4),
                          Text(
                            timeDisplay,
                            style: TextStyle(fontSize: 11, color: Colors.grey[500]),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    }

    // Normal mode with Dismissible
    return Dismissible(
      key: Key('notification_$id'),
      direction: DismissDirection.endToStart,
      background: Container(
        alignment: Alignment.centerRight,
        padding: const EdgeInsets.only(right: 20),
        margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
        decoration: BoxDecoration(
          color: Colors.red.shade400,
          borderRadius: BorderRadius.circular(12),
        ),
        child: const Icon(Icons.delete, color: Colors.white),
      ),
      confirmDismiss: (direction) async {
        final result = await showDialog<bool>(
          context: context,
          builder: (ctx) => AlertDialog(
            title: const Text('Delete Notification'),
            content: const Text('Are you sure you want to delete this notification?'),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(ctx, false),
                child: const Text('Cancel'),
              ),
              ElevatedButton(
                onPressed: () => Navigator.pop(ctx, true),
                style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
                child: const Text('Delete'),
              ),
            ],
          ),
        );
        return result ?? false;
      },
      onDismissed: (direction) => _handleSwipeDelete(id),
      child: Card(
        color: cardColor,
        elevation: read ? 0 : 2,
        margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
          side: BorderSide(color: borderColor, width: 1),
        ),
        child: InkWell(
          onTap: () => _openNotificationDetail(notification),
          onLongPress: () => _enterSelectionMode(id),
          borderRadius: BorderRadius.circular(12),
          child: Padding(
            padding: const EdgeInsets.all(12),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Icon
                Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: style.color.withOpacity(0.1),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(style.icon, color: style.color, size: 22),
                ),
                const SizedBox(width: 12),
                // Content
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                        decoration: BoxDecoration(
                          color: style.color.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: Text(
                          style.label,
                          style: TextStyle(
                            fontSize: 10,
                            fontWeight: FontWeight.w600,
                            color: style.color,
                          ),
                        ),
                      ),
                      const SizedBox(height: 6),
                      Text(
                        message,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: read ? FontWeight.normal : FontWeight.w600,
                          color: isDark ? Colors.white : Colors.black87,
                        ),
                      ),
                      const SizedBox(height: 6),
                      Row(
                        children: [
                          Icon(Icons.access_time, size: 12, color: Colors.grey[500]),
                          const SizedBox(width: 4),
                          Text(
                            timeDisplay,
                            style: TextStyle(fontSize: 11, color: Colors.grey[500]),
                          ),
                          const Spacer(),
                          if (!read)
                            Container(
                              width: 8,
                              height: 8,
                              decoration: BoxDecoration(
                                color: cs.primary,
                                shape: BoxShape.circle,
                              ),
                            ),
                        ],
                      ),
                    ],
                  ),
                ),
                Icon(Icons.chevron_right, color: Colors.grey[400], size: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildViewMoreButton(int totalCount) {
    final remaining = totalCount - _initialItemsToShow;
    
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Center(
        child: TextButton.icon(
          onPressed: () {
            setState(() {
              _expanded = !_expanded;
            });
          },
          icon: Icon(
            _expanded ? Icons.keyboard_arrow_up : Icons.keyboard_arrow_down,
          ),
          label: Text(
            _expanded ? 'View Less' : 'View More ($remaining more)',
            style: const TextStyle(fontWeight: FontWeight.w600),
          ),
        ),
      ),
    );
  }
}

// Helper class for notification styling
class _NotificationStyle {
  final IconData icon;
  final Color color;
  final String label;

  _NotificationStyle(this.icon, this.color, this.label);
}

// Notification Detail Bottom Sheet
class _NotificationDetailSheet extends StatelessWidget {
  final Map<String, dynamic> notification;
  final VoidCallback onDelete;

  const _NotificationDetailSheet({
    required this.notification,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final cs = theme.colorScheme;
    final isDark = theme.brightness == Brightness.dark;

    final message = notification['message']?.toString() ?? '';
    final createdAt = notification['timestamp']?.toString() ??
        notification['created_at']?.toString() ??
        '';

    final timeDisplay = createdAt.isNotEmpty
        ? DateTimeHelper.formatMetadataTime(createdAt)
        : '';

    IconData icon = Icons.notifications;
    Color iconColor = cs.primary;
    String category = 'Notification';

    if (message.contains('Good news') || message.contains('available')) {
      icon = Icons.celebration;
      iconColor = Colors.green;
      category = 'Good News';
    } else if (message.contains('sorry') || message.contains('no available')) {
      icon = Icons.info_outline;
      iconColor = Colors.orange;
      category = 'Information';
    } else if (message.contains('Payment') || message.contains('paid')) {
      icon = Icons.payment;
      iconColor = Colors.blue;
      category = 'Payment';
    } else if (message.contains('cancelled')) {
      icon = Icons.cancel;
      iconColor = Colors.red;
      category = 'Cancellation';
    } else if (message.contains('accepted')) {
      icon = Icons.check_circle;
      iconColor = Colors.green;
      category = 'Booking Accepted';
    } else if (message.contains('completed')) {
      icon = Icons.task_alt;
      iconColor = Colors.teal;
      category = 'Completed';
    } else if (message.contains('message') || message.contains('💬')) {
      icon = Icons.chat_bubble;
      iconColor = Colors.purple;
      category = 'Message';
    } else if (message.contains('review') || message.contains('rating')) {
      icon = Icons.star;
      iconColor = Colors.amber;
      category = 'Review';
    } else if (message.contains('New Job') || message.contains('🆕')) {
      icon = Icons.work;
      iconColor = Colors.indigo;
      category = 'New Job';
    }

    return Container(
      decoration: BoxDecoration(
        color: isDark ? cs.surface : Colors.white,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            margin: const EdgeInsets.only(top: 12),
            width: 40,
            height: 4,
            decoration: BoxDecoration(
              color: Colors.grey[300],
              borderRadius: BorderRadius.circular(2),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(14),
                      decoration: BoxDecoration(
                        color: iconColor.withOpacity(0.1),
                        shape: BoxShape.circle,
                      ),
                      child: Icon(icon, color: iconColor, size: 28),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                            decoration: BoxDecoration(
                              color: iconColor.withOpacity(0.1),
                              borderRadius: BorderRadius.circular(6),
                            ),
                            child: Text(
                              category,
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                                color: iconColor,
                              ),
                            ),
                          ),
                          const SizedBox(height: 4),
                          if (timeDisplay.isNotEmpty)
                            Row(
                              children: [
                                Icon(Icons.access_time, size: 14, color: Colors.grey[500]),
                                const SizedBox(width: 4),
                                Text(
                                  timeDisplay,
                                  style: TextStyle(fontSize: 12, color: Colors.grey[500]),
                                ),
                              ],
                            ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                const Divider(),
                const SizedBox(height: 16),
                Text(
                  message,
                  style: TextStyle(
                    fontSize: 16,
                    height: 1.5,
                    color: isDark ? Colors.white : Colors.black87,
                  ),
                ),
                const SizedBox(height: 24),
                Row(
                  children: [
                    Expanded(
                      child: OutlinedButton.icon(
                        onPressed: onDelete,
                        icon: const Icon(Icons.delete_outline, color: Colors.red),
                        label: const Text('Delete', style: TextStyle(color: Colors.red)),
                        style: OutlinedButton.styleFrom(
                          side: const BorderSide(color: Colors.red),
                          padding: const EdgeInsets.symmetric(vertical: 12),
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () => Navigator.pop(context),
                        style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(vertical: 12),
                        ),
                        child: const Text('Close'),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: MediaQuery.of(context).padding.bottom + 8),
              ],
            ),
          ),
        ],
      ),
    );
  }
}