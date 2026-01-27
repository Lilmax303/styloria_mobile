// lib/services/location_service.dart

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:geocoding/geocoding.dart' as geocoding;
import 'package:http/http.dart' as http;

/// Centralized location service for permission handling, location retrieval, and geocoding
class LocationService {
  static const String _permissionAskedKey = 'location_permission_asked';
  static const String _permissionGrantedKey = 'location_permission_granted';
  
  // Nominatim API for fallback geocoding
  static const String _nominatimBaseUrl = 'https://nominatim.openstreetmap.org';

  // ═══════════════════════════════════════════════════════════════════════════
  // EXISTING CODE - GPS & Permissions (keep all your existing methods)
  // ═══════════════════════════════════════════════════════════════════════════

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
      final serviceEnabled = await isLocationServiceEnabled();
      if (!serviceEnabled) {
        return LocationPermissionResult(
          granted: false,
          status: LocationPermissionStatus.serviceDisabled,
        );
      }

      LocationPermission permission = await checkPermission();

      if (permission == LocationPermission.denied) {
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

  static Future<void> _savePermissionState({required bool granted}) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_permissionAskedKey, true);
    await prefs.setBool(_permissionGrantedKey, granted);
  }

  static Future<bool> hasAskedPermissionBefore() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(_permissionAskedKey) ?? false;
  }

  static Future<bool> getCachedPermissionGranted() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(_permissionGrantedKey) ?? false;
  }

  static Future<bool> openAppSettings() async {
    return await Geolocator.openAppSettings();
  }

  static Future<bool> openLocationSettings() async {
    return await Geolocator.openLocationSettings();
  }

  // ═════════════════════════════════════════════════════════════
  // NEW CODE - Geocoding (coordinates ↔ address)
  // ═════════════════════════════════════════════════════════════

  /// Reverse geocode: Convert coordinates to human-readable address
  /// Uses native geocoding with Nominatim fallback
  static Future<String?> getAddressFromCoordinates(
    double latitude,
    double longitude,
  ) async {
    // Try native geocoding first
    try {
      final placemarks = await geocoding.placemarkFromCoordinates(
        latitude,
        longitude,
      ).timeout(const Duration(seconds: 8));

      if (placemarks.isNotEmpty) {
        final p = placemarks.first;
        final parts = [
          p.street,
          p.subLocality,
          p.locality,
          p.administrativeArea,
          p.country,
        ].where((s) => s != null && s.isNotEmpty).cast<String>().toList();

        if (parts.isNotEmpty) {
          debugPrint('Native geocoding succeeded');
          return parts.join(', ');
        }
      }
    } catch (e) {
      debugPrint('Native reverse geocoding failed: $e');
    }

    // Fallback to Nominatim API
    try {
      final address = await _reverseGeocodeNominatim(latitude, longitude);
      if (address != null) {
        debugPrint('Nominatim fallback succeeded');
        return address;
      }
    } catch (e) {
      debugPrint('Nominatim reverse geocoding failed: $e');
    }

    debugPrint('All reverse geocoding methods failed for: $latitude, $longitude');
    return null;
  }

  /// Forward geocode: Convert address to coordinates
  /// Uses native geocoding with Nominatim fallback
  static Future<GeocodingResult?> getCoordinatesFromAddress(
    String address,
  ) async {
    if (address.trim().isEmpty) return null;

    // Try native geocoding first
    try {
      final locations = await geocoding.locationFromAddress(address)
          .timeout(const Duration(seconds: 8));

      if (locations.isNotEmpty) {
        debugPrint('Native forward geocoding succeeded');
        return GeocodingResult(
          latitude: locations.first.latitude,
          longitude: locations.first.longitude,
        );
      }
    } catch (e) {
      debugPrint('Native forward geocoding failed: $e');
    }

    // Fallback to Nominatim API
    try {
      final result = await _forwardGeocodeNominatim(address);
      if (result != null) {
        debugPrint('Nominatim forward geocoding succeeded');
        return result;
      }
    } catch (e) {
      debugPrint('Nominatim forward geocoding failed: $e');
    }

    debugPrint('All forward geocoding methods failed for: $address');
    return null;
  }

  /// Get current position WITH address (convenience method)
  static Future<PositionWithAddress?> getCurrentPositionWithAddress() async {
    final position = await getCurrentPosition();
    if (position == null) return null;

    final address = await getAddressFromCoordinates(
      position.latitude,
      position.longitude,
    );

    return PositionWithAddress(
      position: position,
      address: address,
    );
  }

  // ════════════════════════════════════════════════════════════════════
  // PRIVATE - Nominatim Fallback Methods
  // ════════════════════════════════════════════════════════════════════

  /// Nominatim reverse geocoding (coordinates → address)
  static Future<String?> _reverseGeocodeNominatim(
    double latitude,
    double longitude,
  ) async {
    final url = Uri.parse(
      '$_nominatimBaseUrl/reverse?format=json&lat=$latitude&lon=$longitude&zoom=18&addressdetails=1',
    );

    final response = await http.get(
      url,
      headers: {
        'User-Agent': 'Styloria-App/1.0 (contact@styloria.com)',
        'Accept': 'application/json',
      },
    ).timeout(const Duration(seconds: 10));

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      final displayName = data['display_name'] as String?;

      if (displayName != null && displayName.isNotEmpty) {
        // Nominatim returns very detailed addresses, trim if too long
        final parts = displayName.split(', ');
        if (parts.length > 5) {
          return parts.take(5).join(', ');
        }
        return displayName;
      }
    }

    return null;
  }

  /// Nominatim forward geocoding (address → coordinates)
  static Future<GeocodingResult?> _forwardGeocodeNominatim(
    String address,
  ) async {
    final url = Uri.parse(
      '$_nominatimBaseUrl/search?format=json&q=${Uri.encodeComponent(address)}&limit=1',
    );

    final response = await http.get(
      url,
      headers: {
        'User-Agent': 'Styloria-App/1.0 (contact@styloria.com)',
        'Accept': 'application/json',
      },
    ).timeout(const Duration(seconds: 10));

    if (response.statusCode == 200) {
      final data = json.decode(response.body) as List;

      if (data.isNotEmpty) {
        final first = data.first;
        final lat = double.tryParse(first['lat']?.toString() ?? '');
        final lng = double.tryParse(first['lon']?.toString() ?? '');

        if (lat != null && lng != null) {
          return GeocodingResult(latitude: lat, longitude: lng);
        }
      }
    }

    return null;
  }
}

// ═══════════════════════════════════════════════════════════════════════════
// DATA CLASSES
// ═══════════════════════════════════════════════════════════════════════════

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

/// Result of forward geocoding (address → coordinates)
class GeocodingResult {
  final double latitude;
  final double longitude;

  GeocodingResult({
    required this.latitude,
    required this.longitude,
  });
}

/// Position with optional address
class PositionWithAddress {
  final Position position;
  final String? address;

  PositionWithAddress({
    required this.position,
    this.address,
  });

  double get latitude => position.latitude;
  double get longitude => position.longitude;
}