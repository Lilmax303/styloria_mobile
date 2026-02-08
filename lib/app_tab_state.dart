// lib/app_tab_state.dart

import 'package:flutter/foundation.dart';
import 'package:styloria_mobile/profile_picture_state.dart'; // Import from existing file

/// Global bottom-tab index controller for MainShell.
/// Any screen can set `mainTabIndex.value = <index>` to switch tabs.
final ValueNotifier<int> mainTabIndex = ValueNotifier<int>(0);
final ValueNotifier<int> bookingsRefreshTick = ValueNotifier<int>(0);

/// Call this on logout to clear profile picture state
void clearProfilePictureState() {
  profilePictureState.clear();
}