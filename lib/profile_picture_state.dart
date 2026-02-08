// lib/profile_picture_state.dart

import 'package:flutter/foundation.dart';

/// Global profile picture state manager
/// Notifies all widgets when profile picture is updated
class ProfilePictureState {
  static final ProfilePictureState _instance = ProfilePictureState._internal();
  factory ProfilePictureState() => _instance;
  ProfilePictureState._internal();

  /// Current profile picture URL
  final ValueNotifier<String?> profilePictureUrl = ValueNotifier<String?>(null);

  /// Update profile picture URL and notify all listeners
  void updateProfilePicture(String? url) {
    profilePictureUrl.value = url;
  }

  /// Clear profile picture (e.g., on logout)
  void clear() {
    profilePictureUrl.value = null;
  }
}

/// Convenient global accessor
final profilePictureState = ProfilePictureState();