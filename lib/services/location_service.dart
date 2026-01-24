// lib/services/location_service.dart

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// Centralized location service for permission handling and location retrieval
class LocationService {
  static const String _permissionAskedKey = 'location_permission_asked';
  static const String _permissionGrantedKey = 'location_permission_granted';

  /// Check if location services are enabled on the device
  static Future<bool> isLocationServiceEnabled() async {
    return await Geolocator.isLocationServiceEnabled();
  }

  /// Check current permission status
  static Future<LocationPermission> checkPermission() async {
    return await Geolocator.checkPermission();
  }

  /// Request location permission
  static Future<LocationPermission> requestPermission() async {
    return await Geolocator.requestPermission();
  }

  /// Check if permission is granted (while using or always)
  static Future<bool> isPermissionGranted() async {
    final permission = await checkPermission();
    return permission == LocationPermission.whileInUse ||
           permission == LocationPermission.always;
  }

  /// Check if permission is permanently denied
  static Future<bool> isPermissionPermanentlyDenied() async {
    final permission = await checkPermission();
    return permission == LocationPermission.deniedForever;
  }

  /// Get current position (if permission granted)
  static Future<Position?> getCurrentPosition() async {
    try {
      final serviceEnabled = await isLocationServiceEnabled();
      if (!serviceEnabled) return null;

      final permission = await checkPermission();
      if (permission == LocationPermission.denied) {
        final requested = await requestPermission();
        if (requested == LocationPermission.denied ||
            requested == LocationPermission.deniedForever) {
          return null;
        }
      }

      if (permission == LocationPermission.deniedForever) {
        return null;
      }

      return await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );
    } catch (e) {
      debugPrint('LocationService.getCurrentPosition error: $e');
      return null;
    }
  }

  /// Request permission with full flow (check -> request -> return result)
  static Future<LocationPermissionResult> requestLocationPermission() async {
    try {
      // Check if location services are enabled
      final serviceEnabled = await isLocationServiceEnabled();
      if (!serviceEnabled) {
        return LocationPermissionResult(
          granted: false,
          status: LocationPermissionStatus.serviceDisabled,
        );
      }

      // Check current permission
      LocationPermission permission = await checkPermission();

      if (permission == LocationPermission.denied) {
        // Request permission
        permission = await requestPermission();
      }

      if (permission == LocationPermission.deniedForever) {
        await _savePermissionState(granted: false);
        return LocationPermissionResult(
          granted: false,
          status: LocationPermissionStatus.permanentlyDenied,
        );
      }

      if (permission == LocationPermission.denied) {
        await _savePermissionState(granted: false);
        return LocationPermissionResult(
          granted: false,
          status: LocationPermissionStatus.denied,
        );
      }

      // Permission granted
      await _savePermissionState(granted: true);
      return LocationPermissionResult(
        granted: true,
        status: LocationPermissionStatus.granted,
      );
    } catch (e) {
      debugPrint('LocationService.requestLocationPermission error: $e');
      return LocationPermissionResult(
        granted: false,
        status: LocationPermissionStatus.error,
        errorMessage: e.toString(),
      );
    }
  }

  /// Save permission state to local storage
  static Future<void> _savePermissionState({required bool granted}) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_permissionAskedKey, true);
    await prefs.setBool(_permissionGrantedKey, granted);
  }

  /// Check if we've already asked for permission before
  static Future<bool> hasAskedPermissionBefore() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(_permissionAskedKey) ?? false;
  }

  /// Get cached permission granted state
  static Future<bool> getCachedPermissionGranted() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(_permissionGrantedKey) ?? false;
  }

  /// Open app settings (for permanently denied case)
  static Future<bool> openAppSettings() async {
    return await Geolocator.openAppSettings();
  }

  /// Open location settings (for service disabled case)
  static Future<bool> openLocationSettings() async {
    return await Geolocator.openLocationSettings();
  }
}

/// Result of a location permission request
class LocationPermissionResult {
  final bool granted;
  final LocationPermissionStatus status;
  final String? errorMessage;

  LocationPermissionResult({
    required this.granted,
    required this.status,
    this.errorMessage,
  });
}

/// Status of location permission
enum LocationPermissionStatus {
  granted,
  denied,
  permanentlyDenied,
  serviceDisabled,
  error,
}