// lib/widgets/service_pricing_widget.dart

import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ServicePricingWidget extends StatefulWidget {
  final List<Map<String, dynamic>> serviceTypes;
  final Map<String, dynamic> certificationStatus;
  final String currencySymbol;
  final Function(int index, bool offered) onToggleService;
  final Function(int index, double price) onUpdatePrice;
  final VoidCallback onSave;
  final bool isLoading;
  final String? Function(String serviceId)? getServiceLabel;

  const ServicePricingWidget({
    super.key,
    required this.serviceTypes,
    required this.certificationStatus,
    required this.currencySymbol,
    required this.onToggleService,
    required this.onUpdatePrice,
    required this.onSave,
    this.isLoading = false,
    this.getServiceLabel,
  });

  @override
  State<ServicePricingWidget> createState() => _ServicePricingWidgetState();
}

class _ServicePricingWidgetState extends State<ServicePricingWidget>
    with TickerProviderStateMixin {
  int _currentStep = 1;
  String? _selectedServiceKey;

  late AnimationController _selectionController;
  late Animation<double> _scaleAnimation;
  late Animation<double> _blurAnimation;
  late Animation<double> _buttonAnimation;

  // Gold accent colors (same in both modes)
  static const Color _goldAccent = Color(0xFFD4AF37);
  static const Color _goldLight = Color(0xFFF4D03F);

  // Service images mapping
  final Map<String, String> _serviceImages = {
    'haircut': 'assets/services/haircut.png',
    'braids': 'assets/services/braids.png',
    'shave': 'assets/services/shave.png',
    'color': 'assets/services/haircoloring.png',
    'manicure': 'assets/services/manicure.png',
    'pedicure': 'assets/services/pedicure.png',
    'nails': 'assets/services/nailart.png',
    'makeup': 'assets/services/makeup.png',
    'facial': 'assets/services/facial.png',
    'waxing': 'assets/services/waxing.png',
    'massage': 'assets/services/massage.png',
    'tattoo': 'assets/services/tattoo.png',
    'styling': 'assets/services/hairstyling.png',
    'treatment': 'assets/services/hairtreatment.png',
    'extensions': 'assets/services/hairextensions.png',
    'other': 'assets/services/other.png',
  };

  @override
  void initState() {
    super.initState();
    _selectionController = AnimationController(
      duration: const Duration(milliseconds: 400),
      vsync: this,
    );

    _scaleAnimation = Tween<double>(begin: 1.0, end: 1.15).animate(
      CurvedAnimation(parent: _selectionController, curve: Curves.easeOutBack),
    );

    _blurAnimation = Tween<double>(begin: 0.0, end: 5.0).animate(
      CurvedAnimation(parent: _selectionController, curve: Curves.easeOut),
    );

    _buttonAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _selectionController,
        curve: const Interval(0.2, 1.0, curve: Curves.easeOutBack),
      ),
    );

    // Auto-advance to step 2 if services already configured
    final hasConfiguredServices = widget.serviceTypes.any(
      (s) => s['offered'] == true && (s['price'] as double) > 0,
    );
    if (hasConfiguredServices) {
      _currentStep = 2;
    }
  }

  @override
  void dispose() {
    _selectionController.dispose();
    super.dispose();
  }

  int get _selectedServicesCount =>
      widget.serviceTypes.where((s) => s['offered'] == true).length;

  String _getServiceLabel(String serviceId) {
    if (widget.getServiceLabel != null) {
      return widget.getServiceLabel!(serviceId) ?? serviceId;
    }
    final labels = {
      'haircut': 'Haircut',
      'braids': 'Braids',
      'shave': 'Shave',
      'color': 'Hair Coloring',
      'manicure': 'Manicure',
      'pedicure': 'Pedicure',
      'nails': 'Nail Art',
      'makeup': 'Makeup',
      'facial': 'Facial',
      'waxing': 'Waxing',
      'massage': 'Massage',
      'tattoo': 'Tattoo',
      'styling': 'Hair Styling',
      'treatment': 'Hair Treatment',
      'extensions': 'Hair Extensions',
      'other': 'Other',
    };
    return labels[serviceId] ?? serviceId;
  }

  void _onServiceTap(String serviceKey) {
    if (_selectedServiceKey == serviceKey) {
      _selectionController.reverse().then((_) {
        if (mounted) {
          setState(() => _selectedServiceKey = null);
        }
      });
    } else {
      setState(() => _selectedServiceKey = serviceKey);
      _selectionController.forward(from: 0);
    }
  }

  void _onSelectConfirm(String serviceKey) {
    final index = widget.serviceTypes.indexWhere((s) => s['id'] == serviceKey);
    if (index == -1) return;

    final service = widget.serviceTypes[index];
    final isCurrentlyOffered = service['offered'] as bool;

    // Check certification requirement
    if (!isCurrentlyOffered && service['requiresCertification'] == true) {
      final hasVerifiedCert =
          widget.certificationStatus[serviceKey]?['has_verified_cert'] == true;
      if (!hasVerifiedCert) {
        _selectionController.reverse();
        setState(() => _selectedServiceKey = null);
        _showCertificationRequired(serviceKey);
        return;
      }
    }

    // Toggle selection
    widget.onToggleService(index, !isCurrentlyOffered);

    _selectionController.reverse();
    setState(() => _selectedServiceKey = null);

    // If enabling, show price dialog
    if (!isCurrentlyOffered) {
      Future.delayed(const Duration(milliseconds: 300), () {
        _showPriceDialog(serviceKey, index);
      });
    }
  }

  void _clearSelection() {
    if (_selectedServiceKey != null) {
      _selectionController.reverse().then((_) {
        if (mounted) {
          setState(() => _selectedServiceKey = null);
        }
      });
    }
  }

  void _showCertificationRequired(String serviceId) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Row(
          children: [
            const Icon(Icons.verified_user, color: Colors.orange),
            const SizedBox(width: 8),
            const Expanded(child: Text('Certification Required')),
          ],
        ),
        content: Text(
          'To offer ${_getServiceLabel(serviceId)}, you need a verified certification. '
          'Please add your certification in the Basic Info tab.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

  void _showPriceDialog(String serviceKey, int index) {
    final controller = TextEditingController();
    final service = widget.serviceTypes[index];
    final currentPrice = service['price'] as double;
    if (currentPrice > 0) {
      controller.text = currentPrice.toStringAsFixed(2);
    }

    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: Column(
          children: [
            Container(
              width: 80,
              height: 80,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: _goldAccent, width: 2),
              ),
              child: ClipOval(
                child: Image.asset(
                  _serviceImages[serviceKey] ?? 'assets/services/other.png',
                  fit: BoxFit.cover,
                  errorBuilder: (_, __, ___) => Container(
                    color: Colors.grey.shade200,
                    child: const Icon(Icons.spa, color: _goldAccent, size: 30),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 12),
            Text(
              'Set Price for ${_getServiceLabel(serviceKey)}',
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 18),
            ),
          ],
        ),
        content: TextField(
          controller: controller,
          keyboardType: const TextInputType.numberWithOptions(decimal: true),
          inputFormatters: [
            FilteringTextInputFormatter.allow(RegExp(r'^\d*\.?\d{0,2}')),
          ],
          autofocus: true,
          decoration: InputDecoration(
            labelText: 'Price',
            prefixText: '${widget.currencySymbol} ',
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
            hintText: '0.00',
          ),
          style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        actions: [
          TextButton(
            onPressed: () {
              if (currentPrice <= 0) {
                widget.onToggleService(index, false);
              }
              Navigator.pop(ctx);
            },
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              final price = double.tryParse(controller.text) ?? 0.0;
              if (price <= 0) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Please enter a valid price'),
                    backgroundColor: Colors.orange,
                  ),
                );
                return;
              }
              widget.onUpdatePrice(index, price);
              Navigator.pop(ctx);
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: _goldAccent,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            child: const Text('Save Price', style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // ===== THEME-AWARE COLORS =====
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final headerColor = isDark ? Colors.white : const Color(0xFF1A1A2E);
    final subtitleColor = isDark ? Colors.grey.shade400 : const Color(0xFF4A4A5A);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildHeader(headerColor, subtitleColor),
        const SizedBox(height: 16),
        _buildProgressBar(),
        const SizedBox(height: 20),

        if (_currentStep == 1)
          _buildServiceSelectionStep()
        else
          _buildPriceDisplayStep(),

        const SizedBox(height: 20),

        if (_currentStep == 2) _buildSaveButton(),
      ],
    );
  }

  Widget _buildHeader(Color headerColor, Color subtitleColor) {
    return Row(
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                _currentStep == 1
                    ? 'Select Your Services'
                    : 'Your Services & Pricing',
                style: TextStyle(
                  fontFamily: 'Georgia',
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                  color: headerColor, // ← THEME-AWARE
                ),
              ),
              const SizedBox(height: 4),
              Text(
                _currentStep == 1
                    ? 'Tap a service to add it to your offerings'
                    : 'Tap to edit price • Long press to remove',
                style: TextStyle(
                  fontSize: 13,
                  color: subtitleColor, // ← THEME-AWARE
                ),
              ),
            ],
          ),
        ),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
          decoration: BoxDecoration(
            gradient: const LinearGradient(colors: [_goldAccent, _goldLight]),
            borderRadius: BorderRadius.circular(20),
          ),
          child: Text(
            'Step $_currentStep/2',
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 12,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildProgressBar() {
    return ClipRRect(
      borderRadius: BorderRadius.circular(4),
      child: LinearProgressIndicator(
        value: _currentStep / 2,
        backgroundColor: Colors.grey.shade300,
        valueColor: const AlwaysStoppedAnimation(_goldAccent),
        minHeight: 4,
      ),
    );
  }

  Widget _buildServiceSelectionStep() {
    final screenWidth = MediaQuery.of(context).size.width;
    final circleSize = (screenWidth - 80) / 2.5;
    final clampedSize = circleSize.clamp(80.0, 120.0);
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return GestureDetector(
      onTap: _clearSelection,
      behavior: HitTestBehavior.translucent,
      child: Column(
        children: [
          AnimatedBuilder(
            animation: _selectionController,
            builder: (context, _) {
              return Wrap(
                spacing: 12,
                runSpacing: 16,
                alignment: WrapAlignment.center,
                children: widget.serviceTypes.map((service) {
                  final serviceId = service['id'] as String;
                  final isOffered = service['offered'] as bool;
                  final isSelected = _selectedServiceKey == serviceId;
                  final hasSelection = _selectedServiceKey != null;

                  return _ServiceSelectionOrb(
                    serviceId: serviceId,
                    serviceName: _getServiceLabel(serviceId),
                    imagePath:
                        _serviceImages[serviceId] ?? 'assets/services/other.png',
                    isOffered: isOffered,
                    isSelected: isSelected,
                    hasSelection: hasSelection,
                    size: clampedSize,
                    scaleValue: _scaleAnimation.value,
                    blurValue: _blurAnimation.value,
                    buttonValue: _buttonAnimation.value.clamp(0.0, 1.0),
                    onTap: () => _onServiceTap(serviceId),
                    onSelectConfirm: () => _onSelectConfirm(serviceId),
                    isDarkMode: isDark, // ← PASS DARK MODE FLAG
                  );
                }).toList(),
              );
            },
          ),

          const SizedBox(height: 20),

          if (_selectedServicesCount > 0)
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.green.shade50,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.green.shade200),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.check_circle, color: Colors.green.shade700, size: 20),
                  const SizedBox(width: 8),
                  Text(
                    '$_selectedServicesCount service${_selectedServicesCount > 1 ? 's' : ''} selected',
                    style: TextStyle(
                      color: Colors.green.shade700,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),

          const SizedBox(height: 16),

          if (_selectedServicesCount > 0)
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () => setState(() => _currentStep = 2),
                style: ElevatedButton.styleFrom(
                  backgroundColor: _goldAccent,
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Continue to Pricing',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                        fontSize: 15,
                      ),
                    ),
                    SizedBox(width: 8),
                    Icon(Icons.arrow_forward, color: Colors.white, size: 18),
                  ],
                ),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildPriceDisplayStep() {
    final offeredServices =
        widget.serviceTypes.where((s) => s['offered'] == true).toList();
    final screenWidth = MediaQuery.of(context).size.width;
    final circleSize = (screenWidth - 80) / 2.5;
    final clampedSize = circleSize.clamp(90.0, 130.0);
    final isDark = Theme.of(context).brightness == Brightness.dark;

    if (offeredServices.isEmpty) {
      return Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: isDark ? Colors.orange.shade900.withOpacity(0.3) : Colors.orange.shade50,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: isDark ? Colors.orange.shade700 : Colors.orange.shade200,
          ),
        ),
        child: Column(
          children: [
            Icon(
              Icons.info_outline,
              color: isDark ? Colors.orange.shade300 : Colors.orange.shade700,
              size: 40,
            ),
            const SizedBox(height: 12),
            Text(
              'No services selected yet',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: isDark ? Colors.orange.shade300 : Colors.orange.shade700,
              ),
            ),
            const SizedBox(height: 8),
            TextButton(
              onPressed: () => setState(() => _currentStep = 1),
              child: const Text('Select Services'),
            ),
          ],
        ),
      );
    }

    return Column(
      children: [
        Wrap(
          spacing: 16,
          runSpacing: 20,
          alignment: WrapAlignment.center,
          children: offeredServices.map((service) {
            final serviceId = service['id'] as String;
            final price = service['price'] as double;
            final serviceIndex =
                widget.serviceTypes.indexWhere((s) => s['id'] == serviceId);

            return _ServicePriceDisplay(
              serviceId: serviceId,
              serviceName: _getServiceLabel(serviceId),
              imagePath:
                  _serviceImages[serviceId] ?? 'assets/services/other.png',
              price: price,
              currencySymbol: widget.currencySymbol,
              size: clampedSize,
              onTap: () => _showPriceDialog(serviceId, serviceIndex),
              onLongPress: () => widget.onToggleService(serviceIndex, false),
              isDarkMode: isDark, // ← PASS DARK MODE FLAG
            );
          }).toList(),
        ),

        const SizedBox(height: 24),

        OutlinedButton.icon(
          onPressed: () => setState(() => _currentStep = 1),
          icon: const Icon(Icons.add),
          label: const Text('Add More Services'),
          style: OutlinedButton.styleFrom(
            foregroundColor: _goldAccent,
            side: const BorderSide(color: _goldAccent),
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildSaveButton() {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: widget.isLoading ? null : widget.onSave,
        style: ElevatedButton.styleFrom(
          backgroundColor: _goldAccent,
          padding: const EdgeInsets.symmetric(vertical: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        child: widget.isLoading
            ? const SizedBox(
                height: 20,
                width: 20,
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                  color: Colors.white,
                ),
              )
            : const Text(
                'Save Pricing',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                  fontSize: 16,
                ),
              ),
      ),
    );
  }
}

// ===== Service Selection Orb (Step 1) - THEME AWARE =====
class _ServiceSelectionOrb extends StatefulWidget {
  final String serviceId;
  final String serviceName;
  final String imagePath;
  final bool isOffered;
  final bool isSelected;
  final bool hasSelection;
  final double size;
  final double scaleValue;
  final double blurValue;
  final double buttonValue;
  final VoidCallback onTap;
  final VoidCallback onSelectConfirm;
  final bool isDarkMode; // ← NEW

  const _ServiceSelectionOrb({
    required this.serviceId,
    required this.serviceName,
    required this.imagePath,
    required this.isOffered,
    required this.isSelected,
    required this.hasSelection,
    required this.size,
    required this.scaleValue,
    required this.blurValue,
    required this.buttonValue,
    required this.onTap,
    required this.onSelectConfirm,
    required this.isDarkMode,
  });

  @override
  State<_ServiceSelectionOrb> createState() => _ServiceSelectionOrbState();
}

class _ServiceSelectionOrbState extends State<_ServiceSelectionOrb>
    with SingleTickerProviderStateMixin {
  late AnimationController _hoverController;
  late Animation<double> _hoverScale;

  static const Color _goldAccent = Color(0xFFD4AF37);
  static const Color _goldLight = Color(0xFFF4D03F);

  @override
  void initState() {
    super.initState();
    _hoverController = AnimationController(
      duration: const Duration(milliseconds: 120),
      vsync: this,
    );
    _hoverScale = Tween<double>(begin: 1.0, end: 1.08).animate(
      CurvedAnimation(parent: _hoverController, curve: Curves.easeOut),
    );
  }

  @override
  void dispose() {
    _hoverController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // ===== THEME-AWARE COLORS =====
    final serviceNameColor = widget.isDarkMode 
        ? Colors.white 
        : const Color(0xFF2D2D3A);
    final serviceNameSelectedColor = widget.isDarkMode 
        ? _goldLight 
        : const Color(0xFFB8860B);
    final offeredColor = widget.isDarkMode 
        ? Colors.green.shade300 
        : Colors.green.shade700;

    double scale = 1.0;
    if (widget.isSelected) {
      scale = widget.scaleValue.clamp(0.5, 2.0);
    } else if (widget.hasSelection) {
      scale = 0.85;
    }

    double opacity = 1.0;
    double blur = 0.0;
    if (widget.hasSelection && !widget.isSelected) {
      blur = widget.blurValue.clamp(0.0, 10.0);
      opacity = 0.35;
    }

    final safeButtonOpacity = widget.buttonValue.clamp(0.0, 1.0);

    return GestureDetector(
      onTap: widget.onTap,
      onTapDown: (_) => _hoverController.forward(),
      onTapUp: (_) => _hoverController.reverse(),
      onTapCancel: () => _hoverController.reverse(),
      child: AnimatedBuilder(
        animation: _hoverController,
        builder: (context, child) {
          final hoverScale = widget.isSelected ? 1.0 : _hoverScale.value;

          return AnimatedOpacity(
            duration: const Duration(milliseconds: 250),
            opacity: opacity.clamp(0.0, 1.0),
            child: Transform.scale(
              scale: (scale * hoverScale).clamp(0.1, 3.0),
              child: SizedBox(
                width: widget.size,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Stack(
                      alignment: Alignment.center,
                      clipBehavior: Clip.none,
                      children: [
                        if (widget.isSelected)
                          Container(
                            width: widget.size + 10,
                            height: widget.size + 10,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              boxShadow: [
                                BoxShadow(
                                  color: _goldAccent.withOpacity(
                                      (0.5 * safeButtonOpacity).clamp(0.0, 1.0)),
                                  blurRadius: 18,
                                  spreadRadius: 2,
                                ),
                              ],
                            ),
                          ),

                        Container(
                          width: widget.size,
                          height: widget.size,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(
                              color: widget.isOffered
                                  ? Colors.green
                                  : (widget.isSelected
                                      ? _goldAccent
                                      : _goldAccent.withOpacity(0.5)),
                              width: widget.isOffered ? 3 : (widget.isSelected ? 3 : 2),
                            ),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black
                                    .withOpacity(widget.isSelected ? 0.25 : 0.12),
                                blurRadius: widget.isSelected ? 12 : 6,
                                offset: Offset(0, widget.isSelected ? 5 : 3),
                              ),
                            ],
                          ),
                          child: ClipOval(
                            child: ImageFiltered(
                              imageFilter: ImageFilter.blur(
                                sigmaX: blur,
                                sigmaY: blur,
                              ),
                              child: Image.asset(
                                widget.imagePath,
                                fit: BoxFit.cover,
                                width: widget.size,
                                height: widget.size,
                                errorBuilder: (context, error, stackTrace) {
                                  return Container(
                                    color: widget.isDarkMode 
                                        ? Colors.grey.shade800 
                                        : Colors.grey.shade200,
                                    child: Icon(
                                      Icons.spa,
                                      size: widget.size * 0.35,
                                      color: _goldAccent,
                                    ),
                                  );
                                },
                              ),
                            ),
                          ),
                        ),

                        if (widget.isOffered && !widget.isSelected)
                          Positioned(
                            bottom: 0,
                            right: 0,
                            child: Container(
                              width: 22,
                              height: 22,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: Colors.green,
                                border: Border.all(color: Colors.white, width: 2),
                              ),
                              child: const Icon(
                                Icons.check,
                                color: Colors.white,
                                size: 12,
                              ),
                            ),
                          ),

                        if (widget.isSelected && safeButtonOpacity > 0.01)
                          Opacity(
                            opacity: safeButtonOpacity,
                            child: Transform.scale(
                              scale: (0.5 + (0.5 * safeButtonOpacity)).clamp(0.1, 1.5),
                              child: Container(
                                width: widget.size,
                                height: widget.size,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  gradient: LinearGradient(
                                    begin: Alignment.topCenter,
                                    end: Alignment.bottomCenter,
                                    colors: [
                                      Colors.black.withOpacity(0.15),
                                      Colors.black.withOpacity(0.65),
                                    ],
                                  ),
                                ),
                                child: Center(
                                  child: GestureDetector(
                                    onTap: widget.onSelectConfirm,
                                    child: Container(
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 12,
                                        vertical: 6,
                                      ),
                                      decoration: BoxDecoration(
                                        gradient: LinearGradient(
                                          colors: widget.isOffered
                                              ? [Colors.red.shade400, Colors.red.shade600]
                                              : [_goldAccent, _goldLight],
                                        ),
                                        borderRadius: BorderRadius.circular(16),
                                        boxShadow: [
                                          BoxShadow(
                                            color: (widget.isOffered
                                                    ? Colors.red
                                                    : _goldAccent)
                                                .withOpacity(0.4),
                                            blurRadius: 8,
                                            offset: const Offset(0, 2),
                                          ),
                                        ],
                                      ),
                                      child: Text(
                                        widget.isOffered ? 'REMOVE' : 'SELECT',
                                        style: const TextStyle(
                                          color: Colors.white,
                                          fontSize: 10,
                                          fontWeight: FontWeight.bold,
                                          letterSpacing: 1,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                      ],
                    ),

                    const SizedBox(height: 6),

                    // ===== THEME-AWARE SERVICE NAME =====
                    Text(
                      widget.serviceName,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontFamily: 'Georgia',
                        fontSize: 11,
                        fontWeight: widget.isSelected || widget.isOffered
                            ? FontWeight.w700
                            : FontWeight.w600,
                        color: widget.isOffered
                            ? offeredColor
                            : (widget.isSelected
                                ? serviceNameSelectedColor
                                : serviceNameColor),
                        letterSpacing: 0.2,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

// ===== Service Price Display (Step 2) - THEME AWARE =====
class _ServicePriceDisplay extends StatelessWidget {
  final String serviceId;
  final String serviceName;
  final String imagePath;
  final double price;
  final String currencySymbol;
  final double size;
  final VoidCallback onTap;
  final VoidCallback onLongPress;
  final bool isDarkMode; // ← NEW

  static const Color _goldAccent = Color(0xFFD4AF37);

  const _ServicePriceDisplay({
    required this.serviceId,
    required this.serviceName,
    required this.imagePath,
    required this.price,
    required this.currencySymbol,
    required this.size,
    required this.onTap,
    required this.onLongPress,
    required this.isDarkMode,
  });

  @override
  Widget build(BuildContext context) {
    // ===== THEME-AWARE COLORS =====
    final serviceNameColor = isDarkMode 
        ? Colors.white 
        : const Color(0xFF2D2D3A);
    final priceColor = isDarkMode 
        ? Colors.green.shade300 
        : Colors.green.shade700;
    final hintColor = isDarkMode 
        ? Colors.grey.shade500 
        : Colors.grey.shade500;

    return GestureDetector(
      onTap: onTap,
      onLongPress: onLongPress,
      child: SizedBox(
        width: size,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Circular image - NO BOX
            Container(
              width: size,
              height: size,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: _goldAccent, width: 3),
                boxShadow: [
                  BoxShadow(
                    color: _goldAccent.withOpacity(0.3),
                    blurRadius: 12,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: ClipOval(
                child: Image.asset(
                  imagePath,
                  fit: BoxFit.cover,
                  width: size,
                  height: size,
                  errorBuilder: (_, __, ___) => Container(
                    color: isDarkMode ? Colors.grey.shade800 : Colors.grey.shade200,
                    child: Icon(Icons.spa, color: _goldAccent, size: size * 0.35),
                  ),
                ),
              ),
            ),

            const SizedBox(height: 8),

            // ===== THEME-AWARE SERVICE NAME =====
            Text(
              serviceName,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontFamily: 'Georgia',
                fontSize: 12,
                fontWeight: FontWeight.w600,
                color: serviceNameColor, // ← THEME-AWARE
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),

            const SizedBox(height: 4),

            // ===== THEME-AWARE PRICE =====
            Text(
              '$currencySymbol${price.toStringAsFixed(2)}',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: priceColor, // ← THEME-AWARE
              ),
            ),

            const SizedBox(height: 4),

            // ===== THEME-AWARE HINT =====
            Text(
              'Tap to edit',
              style: TextStyle(
                fontSize: 9,
                color: hintColor, // ← THEME-AWARE
              ),
            ),
          ],
        ),
      ),
    );
  }
}