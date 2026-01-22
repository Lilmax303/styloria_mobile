// lib/provider_map_screen.dart

import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'api_client.dart';
import 'package:styloria_mobile/gen_l10n/app_localizations.dart';

class ProviderMapScreen extends StatefulWidget {
  final int bookingId;
  final bool isProvider;
  
  const ProviderMapScreen({
    super.key,
    required this.bookingId,
    required this.isProvider,
  });

  @override
  State<ProviderMapScreen> createState() => _ProviderMapScreenState();
}

class _ProviderMapScreenState extends State<ProviderMapScreen> {
  GoogleMapController? _mapController;
  Position? _currentPosition;
  LatLng? _otherPartyPosition;
  
  Set<Marker> _markers = {};
  bool _loading = true;
  String? _error;
  
  // Timer for periodic updates
  Timer? _locationTimer;

  @override
  void initState() {
    super.initState();
    _getCurrentLocation();
    _startLocationUpdates();
    _fetchOtherPartyLocation();
  }

  @override
  void dispose() {
    _locationTimer?.cancel();
    _mapController?.dispose();
    super.dispose();
  }

  Future<void> _getCurrentLocation() async {
    try {
      bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) {
        setState(() => _error = AppLocalizations.of(context).locationServicesDisabled);
        return;
      }

      LocationPermission permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          setState(() => _error = AppLocalizations.of(context).locationPermissionDenied);
          return;
        }
      }

      if (permission == LocationPermission.deniedForever) {
        setState(() => _error = AppLocalizations.of(context).locationPermissionPermanentlyDenied);
        return;
      }

      Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );

      setState(() {
        _currentPosition = position;
        _updateMarkers();
      });

      // Send location to server
      await _sendLocationToServer(position.latitude, position.longitude);

    } catch (e) {
      setState(() => _error = AppLocalizations.of(context).failedToGetLocationWithValue(e.toString()));
    }
  }

  Future<void> _sendLocationToServer(double lat, double lng) async {
    try {
      await ApiClient.updateLocation(
        bookingId: widget.bookingId,
        latitude: lat,
        longitude: lng,
        isProvider: widget.isProvider,
      );
    } catch (e) {
      print('Failed to send location: $e');
    }
  }

  Future<void> _fetchOtherPartyLocation() async {
    try {
      final location = await ApiClient.getOtherPartyLocation(widget.bookingId);
      if (location != null) {
        setState(() {
          _otherPartyPosition = LatLng(location['latitude'], location['longitude']);
          _updateMarkers();
        });
      }
    } catch (e) {
      print('Failed to fetch other party location: $e');
    }
  }

  void _startLocationUpdates() {
    // Update location every 30 seconds
    _locationTimer = Timer.periodic(const Duration(seconds: 30), (timer) {
      if (_currentPosition != null) {
        _sendLocationToServer(
          _currentPosition!.latitude,
          _currentPosition!.longitude,
        );
        _fetchOtherPartyLocation();
      }
    });
  }

  void _updateMarkers() {
    _markers.clear();

    if (_currentPosition != null) {
      _markers.add(
        Marker(
          markerId: const MarkerId('current'),
          position: LatLng(
            _currentPosition!.latitude,
            _currentPosition!.longitude,
          ),
          infoWindow: InfoWindow(
            title: widget.isProvider
                ? AppLocalizations.of(context).youProvider
                : AppLocalizations.of(context).youCustomer,
          ),
          icon: BitmapDescriptor.defaultMarkerWithHue(
            widget.isProvider ? BitmapDescriptor.hueBlue : BitmapDescriptor.hueGreen,
          ),
        ),
      );
    }

    if (_otherPartyPosition != null) {
      _markers.add(
        Marker(
          markerId: const MarkerId('other_party'),
          position: _otherPartyPosition!,
          infoWindow: InfoWindow(
            title: widget.isProvider
                ? AppLocalizations.of(context).customer
                : AppLocalizations.of(context).providerGeneric,
          ),
          icon: BitmapDescriptor.defaultMarkerWithHue(
            widget.isProvider ? BitmapDescriptor.hueGreen : BitmapDescriptor.hueBlue,
          ),
        ),
      );
    }

    // Update map bounds to show both markers
    if (_currentPosition != null && _otherPartyPosition != null) {
      _updateCameraBounds();
    }
  }

  void _updateCameraBounds() {
    if (_mapController == null) return;

    LatLngBounds bounds = LatLngBounds(
      southwest: LatLng(
        _currentPosition!.latitude < _otherPartyPosition!.latitude
            ? _currentPosition!.latitude
            : _otherPartyPosition!.latitude,
        _currentPosition!.longitude < _otherPartyPosition!.longitude
            ? _currentPosition!.longitude
            : _otherPartyPosition!.longitude,
      ),
      northeast: LatLng(
        _currentPosition!.latitude > _otherPartyPosition!.latitude
            ? _currentPosition!.latitude
            : _otherPartyPosition!.latitude,
        _currentPosition!.longitude > _otherPartyPosition!.longitude
            ? _currentPosition!.longitude
            : _otherPartyPosition!.longitude,
      ),
    );

    _mapController!.animateCamera(
      CameraUpdate.newLatLngBounds(bounds, 50),
    );
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.liveLocationTrackingTitle),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () {
              _getCurrentLocation();
              _fetchOtherPartyLocation();
            },
          ),
        ],
      ),
      body: Column(
        children: [
          // Status bar
          Container(
            padding: const EdgeInsets.all(12),
            color: Colors.blue[50],
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  l10n.bookingTitle(widget.bookingId.toString()),
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(
                    color: Colors.blue,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    l10n.live,
                    style: const TextStyle(color: Colors.white, fontSize: 12),
                  )
                ),
              ],
            ),
          ),
          
          // Map
          Expanded(
            child: _error != null
                ? Center(child: Text(_error!))
                : _currentPosition == null
                    ? const Center(child: CircularProgressIndicator())
                    : GoogleMap(
                        initialCameraPosition: CameraPosition(
                          target: LatLng(
                            _currentPosition!.latitude,
                            _currentPosition!.longitude,
                          ),
                          zoom: 14,
                        ),
                        markers: _markers,
                        myLocationEnabled: true,
                        myLocationButtonEnabled: true,
                        onMapCreated: (controller) {
                          setState(() {
                            _mapController = controller;
                            _updateCameraBounds();
                          });
                        },
                      ),
          ),
          
          // Legend
          Container(
            padding: const EdgeInsets.all(12),
            color: Colors.grey[100],
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Row(
                  children: [
                    Container(
                      width: 12,
                      height: 12,
                      decoration: BoxDecoration(
                        color: Colors.blue,
                        shape: BoxShape.circle,
                      ),
                    ),
                    const SizedBox(width: 8),
                    Text(l10n.providerGeneric),
                  ],
                ),
                Row(
                  children: [
                    Container(
                      width: 12,
                      height: 12,
                      decoration: BoxDecoration(
                        color: Colors.green,
                        shape: BoxShape.circle,
                      ),
                    ),
                    const SizedBox(width: 8),
                    Text(l10n.customer),
                  ],
                ),
              ],
            ),
          ),
          
          // Action buttons
          Padding(
            padding: const EdgeInsets.all(12),
            child: Row(
              children: [
                Expanded(
                  child: ElevatedButton.icon(
                    onPressed: () {
                      // View booking details
                      // You can implement navigation to booking details
                    },
                    icon: const Icon(Icons.info_outline),
                    label: Text(l10n.bookingDetails),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: ElevatedButton.icon(
                    onPressed: () {
                      // Navigate using Google Maps
                      if (_otherPartyPosition != null) {
                        _openInMaps();
                      }
                    },
                    icon: const Icon(Icons.navigation),
                    label: Text(l10n.navigate),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green,
                      foregroundColor: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _openInMaps() async {
    if (_otherPartyPosition == null || _currentPosition == null) return;
    
    final String url = 'https://www.google.com/maps/dir/?api=1&'
        'origin=${_currentPosition!.latitude},${_currentPosition!.longitude}&'
        'destination=${_otherPartyPosition!.latitude},${_otherPartyPosition!.longitude}&'
        'travelmode=driving';
    
    // Use url_launcher to open in maps app
    // await launchUrl(Uri.parse(url));
  }
}