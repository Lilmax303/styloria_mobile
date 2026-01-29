// lib/utils/datetime_helper.dart

import 'package:intl/intl.dart';

class DateTimeHelper {
  /// Format appointment time (the exact time user chose for service delivery)
  /// Shows: "Wed, Jan 29, 3:00 PM"
  static String formatAppointmentTime(String? isoString) {
    if (isoString == null || isoString.isEmpty) return 'Not set';
    
    try {
      final utc = DateTime.parse(isoString);
      final local = utc.toLocal();
      
      // Format: "Wed, Jan 29, 3:00 PM"
      final formatter = DateFormat('EEE, MMM d, h:mm a');
      return formatter.format(local);
    } catch (e) {
      return isoString;
    }
  }

  /// Format metadata timestamps (created_at, accepted_at, etc.)
  /// Shows relative time for recent events, absolute for older
  static String formatMetadataTime(String? isoString, {bool showRelative = true}) {
    if (isoString == null || isoString.isEmpty) return 'Unknown';
    
    try {
      final utc = DateTime.parse(isoString);
      final local = utc.toLocal();
      final now = DateTime.now();
      final difference = now.difference(local);
      
      // Show relative time for events within last 24 hours
      if (showRelative && difference.inHours < 24) {
        return _formatRelativeTime(difference);
      }
      
      // Show absolute time for older events
      // Format: "Jan 28, 10:45 AM"
      final formatter = DateFormat('MMM d, h:mm a');
      return formatter.format(local);
    } catch (e) {
      return isoString;
    }
  }

  /// Format relative time (e.g., "2 hours ago", "Just now")
  static String _formatRelativeTime(Duration difference) {
    if (difference.inSeconds < 60) {
      return 'Just now';
    } else if (difference.inMinutes < 60) {
      final minutes = difference.inMinutes;
      return '$minutes ${minutes == 1 ? 'minute' : 'minutes'} ago';
    } else {
      final hours = difference.inHours;
      return '$hours ${hours == 1 ? 'hour' : 'hours'} ago';
    }
  }

  /// Format date only (for booking list)
  /// Shows: "Jan 29"
  static String formatDateOnly(String? isoString) {
    if (isoString == null || isoString.isEmpty) return '';
    
    try {
      final utc = DateTime.parse(isoString);
      final local = utc.toLocal();
      final formatter = DateFormat('MMM d');
      return formatter.format(local);
    } catch (e) {
      return '';
    }
  }

  /// Format time only (for booking list)
  /// Shows: "3:00 PM"
  static String formatTimeOnly(String? isoString) {
    if (isoString == null || isoString.isEmpty) return '';
    
    try {
      final utc = DateTime.parse(isoString);
      final local = utc.toLocal();
      final formatter = DateFormat('h:mm a');
      return formatter.format(local);
    } catch (e) {
      return '';
    }
  }

  /// Get timezone abbreviation (e.g., "EST", "GMT")
  static String getTimezoneAbbreviation() {
    final now = DateTime.now();
    final offset = now.timeZoneOffset;
    final hours = offset.inHours;
    final minutes = offset.inMinutes.remainder(60).abs();
    
    if (hours >= 0) {
      return 'GMT+${hours}${minutes > 0 ? ':${minutes.toString().padLeft(2, '0')}' : ''}';
    } else {
      return 'GMT${hours}${minutes > 0 ? ':${minutes.toString().padLeft(2, '0')}' : ''}';
    }
  }

  /// Check if appointment is today
  static bool isToday(String? isoString) {
    if (isoString == null || isoString.isEmpty) return false;
    
    try {
      final utc = DateTime.parse(isoString);
      final local = utc.toLocal();
      final now = DateTime.now();
      
      return local.year == now.year &&
             local.month == now.month &&
             local.day == now.day;
    } catch (e) {
      return false;
    }
  }

  /// Check if appointment is in the past
  static bool isPast(String? isoString) {
    if (isoString == null || isoString.isEmpty) return false;
    
    try {
      final utc = DateTime.parse(isoString);
      final local = utc.toLocal();
      return local.isBefore(DateTime.now());
    } catch (e) {
      return false;
    }
  }

  /// Format for booking detail screen (full detail)
  /// Shows: "Wednesday, January 29, 2026 at 3:00 PM"
  static String formatDetailedDateTime(String? isoString) {
    if (isoString == null || isoString.isEmpty) return 'Not set';
    
    try {
      final utc = DateTime.parse(isoString);
      final local = utc.toLocal();
      final formatter = DateFormat('EEEE, MMMM d, y \'at\' h:mm a');
      return formatter.format(local);
    } catch (e) {
      return isoString;
    }
  }
}