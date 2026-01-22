// lib/service_request_screen.dart - NEW: User creates request, picks cost, pays!

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';  // Get current location
import 'package:styloria_mobile/gen_l10n/app_localizations.dart';

import 'api_client.dart';
import 'booking_detail_screen.dart';  // After create, show detail

class ServiceRequestScreen extends StatefulWidget {
  const ServiceRequestScreen({super.key});

  @override
  State<ServiceRequestScreen> createState() => _ServiceRequestScreenState();
}

class _ServiceRequestScreenState extends State<ServiceRequestScreen> {
  final _formKey = GlobalKey<FormState>();
  String _serviceType = 'haircut';  // Dropdown options
  DateTime _appointmentTime = DateTime.now().add(const Duration(hours: 1));
  String _notes = '';
  List<Map<String, dynamic>> _priceOptions = [];  // From API
  double? _selectedPrice;
  bool _loadingLocation = true;
  Position? _currentPosition;

  @override
  void initState() {
    super.initState();
    _getCurrentLocation();
  }

  Future<void> _getCurrentLocation() async {
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // Handle...
      return;
    }
    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
    }
    if (permission == LocationPermission.whileInUse || permission == LocationPermission.always) {
      final position = await Geolocator.getCurrentPosition();
      setState(() {
        _currentPosition = position;
        _loadingLocation = false;
      });
    }
  }

  Future<void> _loadPriceOptions() async {
    // Assume API call for service_type
    // _priceOptions = await ApiClient.getPriceOptions(serviceType);
  }

  Future<void> _createRequest() async {
    if (!_formKey.currentState!.validate() || _currentPosition == null || _selectedPrice == null) return;

    final created = await ApiClient.createServiceRequest(
      appointmentTime: _appointmentTime.toIso8601String(),
      latitude: _currentPosition!.latitude,
      longitude: _currentPosition!.longitude,
      serviceType: _serviceType,
      notes: _notes,
    );

    if (created != null) {
      // Pay upfront
      final clientSecret = await ApiClient.createPaymentIntent(created['id'], offeredPrice: _selectedPrice);
      if (clientSecret != null) {
        // TODO: Stripe payment sheet (add flutter_stripe)
        // Success -> Navigator.push(BookingDetailScreen(booking: created));
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(AppLocalizations.of(context).requestCreatedAndPaidBroadcast)),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return Scaffold(
      appBar: AppBar(title: Text(l10n.newServiceRequestTitle)),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                decoration: InputDecoration(
                  labelText: l10n.offeredPriceLabel,
                  hintText: l10n.offeredPriceHint,
                  border: OutlineInputBorder(),
                ),
                keyboardType: const TextInputType.numberWithOptions(decimal: true),
                onChanged: (v) => setState(() => _selectedPrice = double.tryParse(v)),
                validator: (v) {
                  final p = double.tryParse((v ?? '').trim());
                  if (p == null || p <= 0) return l10n.enterValidPrice;
                  return null;
                },
              ),
              const SizedBox(height: 12),
              ElevatedButton(
                onPressed: _createRequest,
                child: Text(
                  _selectedPrice == null 
                      ? l10n.bookAndPay
                      : l10n.bookAndPayAmount('\$${_selectedPrice!.toStringAsFixed(2)}'),
                ),
              ),             
              DropdownButtonFormField<String>(
                value: _serviceType,
                items: [
                  DropdownMenuItem(value: 'haircut', child: Text(l10n.haircutService)),
                  DropdownMenuItem(value: 'styling', child: Text(l10n.stylingService)),
                ],
                onChanged: (v) => setState(() => _serviceType = v!),
              ),
              ListTile(
                title: Text(l10n.timeLabel),
                subtitle: Text(_appointmentTime.toString()),
                trailing: const Icon(Icons.schedule),
                onTap: () async {
                  final date = await showDatePicker(
                    context: context,
                    initialDate: _appointmentTime,
                    firstDate: DateTime.now(),
                    lastDate: DateTime.now().add(const Duration(days: 365)),
                  );
                  if (date == null) return;

                  final time = await showTimePicker(
                    context: context,
                    initialTime: TimeOfDay.fromDateTime(_appointmentTime),
                  );
                  if (time == null) return;

                  setState(() {
                    _appointmentTime = DateTime(
                      date.year,
                      date.month,
                      date.day,
                      time.hour,
                      time.minute,
                    );
                  });
                },
              ),
              TextFormField(
                decoration: InputDecoration(labelText: l10n.notesLabel),
                maxLines: 3,
                onChanged: (v) => _notes = v,
              ),
              if (_loadingLocation) const CircularProgressIndicator(),
              if (_currentPosition != null)
                Text(l10n.locationLatLng(_currentPosition!.latitude, _currentPosition!.longitude)),
              // Price picker chips
              // ElevatedButton(onPressed: _createRequest, child: Text('Book & Pay \$$_selectedPrice')),
            ],
          ),
        ),
      ),
    );
  }
}