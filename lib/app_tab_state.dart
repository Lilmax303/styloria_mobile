// lib/app_tab_state.dart



import 'package:flutter/foundation.dart';

/// Global bottom-tab index controller for MainShell.
/// Any screen can set `mainTabIndex.value = <index>` to switch tabs.
final ValueNotifier<int> mainTabIndex = ValueNotifier<int>(0);
final ValueNotifier<int> bookingsRefreshTick = ValueNotifier<int>(0);