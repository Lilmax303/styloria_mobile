// lib/widgets/service_selector_widget.dart

import 'dart:ui';
import 'package:flutter/material.dart';
import '../booking_form_screen.dart';

class ServiceSelectorWidget extends StatefulWidget {
  const ServiceSelectorWidget({super.key});

  @override
  State<ServiceSelectorWidget> createState() => _ServiceSelectorWidgetState();
}

class _ServiceSelectorWidgetState extends State<ServiceSelectorWidget>
    with TickerProviderStateMixin {
  bool _showAll = false;
  String? _selectedServiceKey;

  late AnimationController _selectionController;
  late Animation<double> _scaleAnimation;
  late Animation<double> _blurAnimation;
  late Animation<double> _buttonAnimation;

  // ===== FIXED: Explicit colors that work on light marble background =====
  static const Color _headerTextColor = Color(0xFF1A1A2E);      // Dark navy - always visible
  static const Color _serviceNameColor = Color(0xFF2D2D3A);     // Dark grey - always visible
  static const Color _serviceNameSelectedColor = Color(0xFFB8860B); // Dark gold - always visible
  static const Color _goldAccent = Color(0xFFD4AF37);
  static const Color _goldLight = Color(0xFFF4D03F);

  final List<ServiceItem> _topServices = [
    ServiceItem(key: 'haircut', name: 'Haircut', imagePath: 'assets/services/haircut.png'),
    ServiceItem(key: 'braids', name: 'Braids', imagePath: 'assets/services/braids.png'),
    ServiceItem(key: 'tattoo', name: 'Tattoo', imagePath: 'assets/services/tattoo.png'),
    ServiceItem(key: 'makeup', name: 'Makeup', imagePath: 'assets/services/makeup.png'),
    ServiceItem(key: 'manicure', name: 'Manicure', imagePath: 'assets/services/manicure.png'),
    ServiceItem(key: 'pedicure', name: 'Pedicure', imagePath: 'assets/services/pedicure.png'),
    ServiceItem(key: 'nails', name: 'Nail Art', imagePath: 'assets/services/nailart.png'),
    ServiceItem(key: 'massage', name: 'Massage', imagePath: 'assets/services/massage.png'),
    ServiceItem(key: 'styling', name: 'Hair Styling', imagePath: 'assets/services/hairstyling.png'),
  ];

  final List<ServiceItem> _hiddenServices = [
    ServiceItem(key: 'shave', name: 'Shave', imagePath: 'assets/services/shave.png'),
    ServiceItem(key: 'color', name: 'Hair Coloring', imagePath: 'assets/services/haircoloring.png'),
    ServiceItem(key: 'facial', name: 'Facial', imagePath: 'assets/services/facial.png'),
    ServiceItem(key: 'waxing', name: 'Waxing', imagePath: 'assets/services/waxing.png'),
    ServiceItem(key: 'treatment', name: 'Hair Treatment', imagePath: 'assets/services/hairtreatment.png'),
    ServiceItem(key: 'extensions', name: 'Extensions', imagePath: 'assets/services/hairextensions.png'),
  ];

  @override
  void initState() {
    super.initState();
    _selectionController = AnimationController(
      duration: const Duration(milliseconds: 400),
      vsync: this,
    );

    _scaleAnimation = Tween<double>(begin: 1.0, end: 1.2).animate(
      CurvedAnimation(parent: _selectionController, curve: Curves.easeOutBack),
    );

    _blurAnimation = Tween<double>(begin: 0.0, end: 6.0).animate(
      CurvedAnimation(parent: _selectionController, curve: Curves.easeOut),
    );

    _buttonAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _selectionController,
        curve: const Interval(0.2, 1.0, curve: Curves.easeOutBack),
      ),
    );
  }

  @override
  void dispose() {
    _selectionController.dispose();
    super.dispose();
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
    _selectionController.reverse();
    setState(() => _selectedServiceKey = null);

    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => BookingFormScreen(preSelectedService: serviceKey),
      ),
    );
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

  @override
  Widget build(BuildContext context) {
    final allServices = [..._topServices, if (_showAll) ..._hiddenServices];
    final screenWidth = MediaQuery.of(context).size.width;

    final circleSize = (screenWidth - 56) / 2.5;
    final clampedSize = circleSize.clamp(80.0, 140.0);

    return GestureDetector(
      onTap: _clearSelection,
      behavior: HitTestBehavior.translucent,
      child: Column(
        children: [
          // ===== FIXED: Header with explicit dark color =====
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
            child: Column(
              children: [
                Text(
                  'Which service can we help you with?',
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontFamily: 'Georgia',
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    letterSpacing: 0.3,
                    color: _headerTextColor,  // ← FIXED: Always dark
                    height: 1.3,
                  ),
                ),
                const SizedBox(height: 10),
                Container(
                  width: 50,
                  height: 2.5,
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      colors: [_goldAccent, _goldLight],
                    ),
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
              ],
            ),
          ),

          // Services Grid
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: AnimatedBuilder(
              animation: _selectionController,
              builder: (context, _) {
                return Wrap(
                  spacing: 12,
                  runSpacing: 16,
                  alignment: WrapAlignment.center,
                  children: allServices.map((service) {
                    final isSelected = _selectedServiceKey == service.key;
                    final hasSelection = _selectedServiceKey != null;

                    return _ServiceOrb(
                      service: service,
                      size: clampedSize,
                      isSelected: isSelected,
                      hasSelection: hasSelection,
                      scaleValue: _scaleAnimation.value,
                      blurValue: _blurAnimation.value,
                      buttonValue: _buttonAnimation.value.clamp(0.0, 1.0),
                      onTap: () => _onServiceTap(service.key),
                      onSelectConfirm: () => _onSelectConfirm(service.key),
                      // ===== FIXED: Pass explicit colors =====
                      nameColor: _serviceNameColor,
                      nameSelectedColor: _serviceNameSelectedColor,
                    );
                  }).toList(),
                );
              },
            ),
          ),

          // Show More/Less button
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 20),
            child: GestureDetector(
              onTap: () => setState(() => _showAll = !_showAll),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: _showAll
                        ? [const Color(0xFF6B7280), const Color(0xFF4B5563)]
                        : [_goldAccent, const Color(0xFFB8860B)],
                  ),
                  borderRadius: BorderRadius.circular(25),
                  boxShadow: [
                    BoxShadow(
                      color: (_showAll ? Colors.grey : _goldAccent)
                          .withOpacity(0.3),
                      blurRadius: 8,
                      offset: const Offset(0, 3),
                    ),
                  ],
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      _showAll ? 'Show Less' : 'Show More',
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                        fontSize: 13,
                        letterSpacing: 0.3,
                      ),
                    ),
                    const SizedBox(width: 6),
                    AnimatedRotation(
                      turns: _showAll ? 0.5 : 0,
                      duration: const Duration(milliseconds: 300),
                      child: const Icon(
                        Icons.keyboard_arrow_down,
                        color: Colors.white,
                        size: 18,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// Service data model
class ServiceItem {
  final String key;
  final String name;
  final String imagePath;

  ServiceItem({
    required this.key,
    required this.name,
    required this.imagePath,
  });
}

// Individual Service Orb
class _ServiceOrb extends StatefulWidget {
  final ServiceItem service;
  final double size;
  final bool isSelected;
  final bool hasSelection;
  final double scaleValue;
  final double blurValue;
  final double buttonValue;
  final VoidCallback onTap;
  final VoidCallback onSelectConfirm;
  // ===== FIXED: Accept explicit colors =====
  final Color nameColor;
  final Color nameSelectedColor;

  const _ServiceOrb({
    required this.service,
    required this.size,
    required this.isSelected,
    required this.hasSelection,
    required this.scaleValue,
    required this.blurValue,
    required this.buttonValue,
    required this.onTap,
    required this.onSelectConfirm,
    required this.nameColor,
    required this.nameSelectedColor,
  });

  @override
  State<_ServiceOrb> createState() => _ServiceOrbState();
}

class _ServiceOrbState extends State<_ServiceOrb>
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
    final cs = Theme.of(context).colorScheme;

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
                    // Circular image
                    Stack(
                      alignment: Alignment.center,
                      clipBehavior: Clip.none,
                      children: [
                        // Glow effect
                        if (widget.isSelected)
                          Positioned(
                            child: Container(
                              width: widget.size + 12,
                              height: widget.size + 12,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                boxShadow: [
                                  BoxShadow(
                                    color: _goldAccent
                                        .withOpacity((0.5 * safeButtonOpacity).clamp(0.0, 1.0)),
                                    blurRadius: 20,
                                    spreadRadius: 2,
                                  ),
                                ],
                              ),
                            ),
                          ),

                        // Main circular image
                        Container(
                          width: widget.size,
                          height: widget.size,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(
                              color: widget.isSelected
                                  ? _goldAccent
                                  : _goldAccent.withOpacity(0.5),
                              width: widget.isSelected ? 3 : 2,
                            ),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(
                                  widget.isSelected ? 0.25 : 0.12,
                                ),
                                blurRadius: widget.isSelected ? 15 : 8,
                                offset: Offset(0, widget.isSelected ? 6 : 3),
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
                                widget.service.imagePath,
                                fit: BoxFit.cover,
                                width: widget.size,
                                height: widget.size,
                                errorBuilder: (context, error, stackTrace) {
                                  return Container(
                                    color: cs.surfaceContainerHighest,
                                    child: Icon(
                                      Icons.spa,
                                      size: widget.size * 0.35,
                                      color: cs.onSurfaceVariant,
                                    ),
                                  );
                                },
                              ),
                            ),
                          ),
                        ),

                        // SELECT button overlay
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
                                        horizontal: 16,
                                        vertical: 8,
                                      ),
                                      decoration: BoxDecoration(
                                        gradient: const LinearGradient(
                                          colors: [_goldAccent, _goldLight],
                                        ),
                                        borderRadius: BorderRadius.circular(20),
                                        boxShadow: [
                                          BoxShadow(
                                            color: _goldAccent.withOpacity(0.4),
                                            blurRadius: 10,
                                            offset: const Offset(0, 3),
                                          ),
                                        ],
                                      ),
                                      child: const Text(
                                        'SELECT',
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 11,
                                          fontWeight: FontWeight.bold,
                                          letterSpacing: 1.2,
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

                    const SizedBox(height: 8),

                    // ===== FIXED: Service name with explicit dark color =====
                    Text(
                      widget.service.name,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontFamily: 'Georgia',
                        fontSize: widget.isSelected ? 13 : 12,
                        fontWeight: widget.isSelected
                            ? FontWeight.w700
                            : FontWeight.w600,
                        // ===== FIXED: Use explicit colors, not theme colors =====
                        color: widget.isSelected
                            ? widget.nameSelectedColor  // Dark gold
                            : widget.nameColor,          // Dark grey
                        letterSpacing: 0.3,
                        // ===== BONUS: Add shadow for extra readability =====
                        shadows: const [
                          Shadow(
                            color: Colors.white,
                            blurRadius: 4,
                          ),
                        ],
                      ),
                      maxLines: 1,
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