// lib/preview_screen.dart

import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:styloria_mobile/gen_l10n/app_localizations.dart';
import 'widgets/background_layer.dart';
import 'widgets/service_selector_widget.dart'; // ✅ Import ServiceItem

class PreviewScreen extends StatefulWidget {
  final VoidCallback onLogin;
  final VoidCallback onRegister;

  const PreviewScreen({
    super.key,
    required this.onLogin,
    required this.onRegister,
  });

  @override
  State<PreviewScreen> createState() => _PreviewScreenState();
}

class _PreviewScreenState extends State<PreviewScreen>
    with TickerProviderStateMixin {

  String? _selectedServiceKey;
  bool _showAll = false;

  // ✅ Same colors as ServiceSelectorWidget
  static const Color _headerTextColor = Color(0xFF1A1A2E);
  static const Color _serviceNameColor = Color(0xFF2D2D3A);
  static const Color _serviceNameSelectedColor = Color(0xFFB8860B);
  static const Color _goldAccent = Color(0xFFD4AF37);
  static const Color _goldLight = Color(0xFFF4D03F);
  static const double _fixedCircleSize = 105.0;
  static const double _circleSpacing = 16.0;
  static const double _horizontalPadding = 16.0;

  // ✅ Same animation controllers as ServiceSelectorWidget
  late AnimationController _selectionController;
  late Animation<double> _scaleAnimation;
  late Animation<double> _blurAnimation;
  late Animation<double> _buttonAnimation;

  // ✅ Same service definitions as ServiceSelectorWidget
  static const List<_PreviewServiceDef> _topServiceDefs = [
    _PreviewServiceDef(key: 'haircut',   nameKey: 'serviceHaircutLabel',       imagePath: 'assets/services/haircut.png'),
    _PreviewServiceDef(key: 'braids',    nameKey: 'serviceBraidsLabel',        imagePath: 'assets/services/braids.png'),
    _PreviewServiceDef(key: 'tattoo',    nameKey: 'serviceTattooLabel',        imagePath: 'assets/services/tattoo.png'),
    _PreviewServiceDef(key: 'makeup',    nameKey: 'serviceMakeupLabel',        imagePath: 'assets/services/makeup.png'),
    _PreviewServiceDef(key: 'manicure',  nameKey: 'serviceManicureLabel',      imagePath: 'assets/services/manicure.png'),
    _PreviewServiceDef(key: 'pedicure',  nameKey: 'servicePedicureLabel',      imagePath: 'assets/services/pedicure.png'),
    _PreviewServiceDef(key: 'nails',     nameKey: 'serviceNailArtLabel',       imagePath: 'assets/services/nailart.png'),
    _PreviewServiceDef(key: 'massage',   nameKey: 'serviceMassageLabel',       imagePath: 'assets/services/massage.png'),
    _PreviewServiceDef(key: 'styling',   nameKey: 'serviceHairStylingLabel',   imagePath: 'assets/services/hairstyling.png'),
  ];

  static const List<_PreviewServiceDef> _hiddenServiceDefs = [
    _PreviewServiceDef(key: 'shave',      nameKey: 'serviceShaveLabel',          imagePath: 'assets/services/shave.png'),
    _PreviewServiceDef(key: 'color',      nameKey: 'serviceHairColoringLabel',   imagePath: 'assets/services/haircoloring.png'),
    _PreviewServiceDef(key: 'facial',     nameKey: 'serviceFacialLabel',         imagePath: 'assets/services/facial.png'),
    _PreviewServiceDef(key: 'waxing',     nameKey: 'serviceWaxingLabel',         imagePath: 'assets/services/waxing.png'),
    _PreviewServiceDef(key: 'treatment',  nameKey: 'serviceHairTreatmentLabel',  imagePath: 'assets/services/hairtreatment.png'),
    _PreviewServiceDef(key: 'extensions', nameKey: 'serviceHairExtensionsLabel', imagePath: 'assets/services/hairextensions.png'),
  ];

  @override
  void initState() {
    super.initState();

    _selectionController = AnimationController(
      duration: const Duration(milliseconds: 400),
      vsync: this,
    );

    _scaleAnimation = Tween<double>(begin: 1.0, end: 1.2).animate(
      CurvedAnimation(
        parent: _selectionController,
        curve: Curves.easeOutBack,
      ),
    );

    _blurAnimation = Tween<double>(begin: 0.0, end: 6.0).animate(
      CurvedAnimation(
        parent: _selectionController,
        curve: Curves.easeOut,
      ),
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

  // ✅ Resolve localized service names - same as ServiceSelectorWidget
  String _resolveServiceName(String nameKey, AppLocalizations l10n) {
    switch (nameKey) {
      case 'serviceHaircutLabel':       return l10n.serviceHaircutLabel;
      case 'serviceBraidsLabel':        return l10n.serviceBraidsLabel;
      case 'serviceTattooLabel':        return l10n.serviceTattooLabel;
      case 'serviceMakeupLabel':        return l10n.serviceMakeupLabel;
      case 'serviceManicureLabel':      return l10n.serviceManicureLabel;
      case 'servicePedicureLabel':      return l10n.servicePedicureLabel;
      case 'serviceNailArtLabel':       return l10n.serviceNailArtLabel;
      case 'serviceMassageLabel':       return l10n.serviceMassageLabel;
      case 'serviceHairStylingLabel':   return l10n.serviceHairStylingLabel;
      case 'serviceShaveLabel':         return l10n.serviceShaveLabel;
      case 'serviceHairColoringLabel':  return l10n.serviceHairColoringLabel;
      case 'serviceFacialLabel':        return l10n.serviceFacialLabel;
      case 'serviceWaxingLabel':        return l10n.serviceWaxingLabel;
      case 'serviceHairTreatmentLabel': return l10n.serviceHairTreatmentLabel;
      case 'serviceHairExtensionsLabel':return l10n.serviceHairExtensionsLabel;
      default: return nameKey;
    }
  }

  void _onServiceTap(String serviceKey) {
    if (_selectedServiceKey == serviceKey) {
      // ✅ Tapped same service - deselect
      _selectionController.reverse().then((_) {
        if (mounted) setState(() => _selectedServiceKey = null);
      });
    } else {
      // ✅ New service selected
      setState(() => _selectedServiceKey = serviceKey);
      _selectionController.forward(from: 0);
    }
  }

  // ✅ Instead of booking, show login/register prompt
  void _onServiceConfirm(String serviceKey) {
    _selectionController.reverse();
    setState(() => _selectedServiceKey = null);
    _showLoginPrompt(serviceKey);
  }

  void _clearSelection() {
    if (_selectedServiceKey != null) {
      _selectionController.reverse().then((_) {
        if (mounted) setState(() => _selectedServiceKey = null);
      });
    }
  }

  // ✅ Show bottom sheet prompting login/register
  void _showLoginPrompt(String serviceKey) {
    final l10n = AppLocalizations.of(context);

    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (context) => Container(
        padding: const EdgeInsets.all(24),
        decoration: const BoxDecoration(
          color: Color(0xFF1A1A2E),
          borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [

            // Handle bar
            Container(
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                color: Colors.white24,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            const SizedBox(height: 20),

            // Gold lock icon
            Container(
              width: 60,
              height: 60,
              decoration: BoxDecoration(
                color: _goldAccent.withOpacity(0.15),
                shape: BoxShape.circle,
                border: Border.all(
                  color: _goldAccent.withOpacity(0.4),
                  width: 1.5,
                ),
              ),
              child: const Icon(
                Icons.lock_outline,
                color: _goldAccent,
                size: 30,
              ),
            ),
            const SizedBox(height: 16),

            // Title
            Text(
              l10n.previewLoginPromptTitle,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 8),

            // Subtitle
            Text(
              l10n.previewLoginPromptSubtitle,
              style: const TextStyle(
                color: Colors.white60,
                fontSize: 14,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 28),

            // Register Button
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                  widget.onRegister();
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: _goldAccent,
                  foregroundColor: Colors.black,
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: Text(
                  l10n.previewGetStarted,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 15,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 12),

            // Login Button
            SizedBox(
              width: double.infinity,
              child: OutlinedButton(
                onPressed: () {
                  Navigator.pop(context);
                  widget.onLogin();
                },
                style: OutlinedButton.styleFrom(
                  foregroundColor: Colors.white,
                  side: BorderSide(color: Colors.white.withOpacity(0.4)),
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: Text(
                  l10n.previewAlreadyHaveAccount,
                  style: const TextStyle(fontSize: 14),
                ),
              ),
            ),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);

    // ✅ Build service items same way as ServiceSelectorWidget
    final topServices = _topServiceDefs
        .map((def) => ServiceItem(
              key: def.key,
              name: _resolveServiceName(def.nameKey, l10n),
              imagePath: def.imagePath,
            ))
        .toList();

    final hiddenServices = _hiddenServiceDefs
        .map((def) => ServiceItem(
              key: def.key,
              name: _resolveServiceName(def.nameKey, l10n),
              imagePath: def.imagePath,
            ))
        .toList();

    final allServices = [
      ...topServices,
      if (_showAll) ...hiddenServices,
    ];

    return Scaffold(
      body: BackgroundLayer(
        imageAsset: 'assets/backgrounds/bg_login_black_marble.jpg',
        overlayColor: const Color(0xFF0B0F14),
        overlayOpacity: 0.68,
        child: SafeArea(
          child: GestureDetector(
            onTap: _clearSelection,
            behavior: HitTestBehavior.translucent,
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(
                horizontal: 0,
                vertical: 16,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [

                  // ══════════════════════════
                  // LOGO + APP NAME
                  // ══════════════════════════
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24),
                    child: Center(
                      child: Column(
                        children: [
                          // Gold S logo circle
                          Container(
                            width: 90,
                            height: 90,
                            decoration: BoxDecoration(
                              color: _goldAccent.withOpacity(0.15),
                              shape: BoxShape.circle,
                              border: Border.all(
                                color: _goldAccent.withOpacity(0.5),
                                width: 2,
                              ),
                            ),
                            child: Center(
                              child: Text(
                                'S',
                                style: TextStyle(
                                  fontSize: 52,
                                  fontWeight: FontWeight.bold,
                                  color: _goldAccent,
                                  fontFamily: 'Georgia',
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(height: 12),

                          // App Name
                          const Text(
                            'Styloria',
                            style: TextStyle(
                              fontSize: 30,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                              letterSpacing: 1.5,
                              fontFamily: 'Georgia',
                            ),
                          ),
                          const SizedBox(height: 6),

                          // Tagline with gold color
                          Text(
                            l10n.previewTagline,
                            style: TextStyle(
                              fontSize: 13,
                              color: _goldAccent,
                              letterSpacing: 1.8,
                              fontWeight: FontWeight.w500,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    ),
                  ),

                  const SizedBox(height: 28),

                  // ══════════════════════════
                  // SERVICES HEADER
                  // ✅ Same style as ServiceSelectorWidget
                  // ══════════════════════════
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Column(
                      children: [
                        Text(
                          l10n.previewServicesTitle,
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            fontFamily: 'Georgia',
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                            letterSpacing: 0.3,
                            color: Colors.white,
                            height: 1.3,
                          ),
                        ),
                        const SizedBox(height: 6),
                        Text(
                          l10n.previewServicesSubtitle,
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            fontSize: 13,
                            color: Colors.white60,
                          ),
                        ),
                        const SizedBox(height: 10),
                        // ✅ Same gold divider as ServiceSelectorWidget
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

                  const SizedBox(height: 16),

                  // ══════════════════════════
                  // SERVICES GRID
                  // ✅ Exact same orb style as ServiceSelectorWidget
                  // ══════════════════════════
                  Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: _horizontalPadding,
                    ),
                    child: AnimatedBuilder(
                      animation: _selectionController,
                      builder: (context, _) {
                        return GridView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          gridDelegate:
                              SliverGridDelegateWithMaxCrossAxisExtent(
                            maxCrossAxisExtent: _fixedCircleSize + 20,
                            crossAxisSpacing: _circleSpacing,
                            mainAxisSpacing: 12.0,
                            childAspectRatio: 0.70,
                          ),
                          itemCount: allServices.length,
                          itemBuilder: (context, index) {
                            final service = allServices[index];
                            final isSelected =
                                _selectedServiceKey == service.key;
                            final hasSelection =
                                _selectedServiceKey != null;

                            return _PreviewServiceOrb(
                              service: service,
                              size: _fixedCircleSize,
                              isSelected: isSelected,
                              hasSelection: hasSelection,
                              scaleValue: _scaleAnimation.value,
                              blurValue: _blurAnimation.value,
                              buttonValue:
                                  _buttonAnimation.value.clamp(0.0, 1.0),
                              onTap: () => _onServiceTap(service.key),
                              onSelectConfirm: () =>
                                  _onServiceConfirm(service.key),
                              nameColor: Colors.white,
                              nameSelectedColor: _serviceNameSelectedColor,
                              // ✅ Different label for preview
                              selectLabel: l10n.previewBookNowLabel,
                            );
                          },
                        );
                      },
                    ),
                  ),

                  // ══════════════════════════
                  // SHOW MORE/LESS BUTTON
                  // ✅ Same style as ServiceSelectorWidget
                  // ══════════════════════════
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 20),
                    child: Center(
                      child: GestureDetector(
                        onTap: () =>
                            setState(() => _showAll = !_showAll),
                        child: AnimatedContainer(
                          duration: const Duration(milliseconds: 300),
                          padding: const EdgeInsets.symmetric(
                            horizontal: 20,
                            vertical: 10,
                          ),
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              colors: _showAll
                                  ? [
                                      const Color(0xFF6B7280),
                                      const Color(0xFF4B5563),
                                    ]
                                  : [
                                      _goldAccent,
                                      const Color(0xFFB8860B),
                                    ],
                            ),
                            borderRadius: BorderRadius.circular(25),
                            boxShadow: [
                              BoxShadow(
                                color: (_showAll
                                        ? Colors.grey
                                        : _goldAccent)
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
                                _showAll
                                    ? l10n.showLess
                                    : l10n.showMore,
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
                                duration:
                                    const Duration(milliseconds: 300),
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
                  ),

                  // ══════════════════════════
                  // FEATURE HIGHLIGHTS
                  // ══════════════════════════
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Container(
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.05),
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(
                          color: _goldAccent.withOpacity(0.2),
                        ),
                      ),
                      child: Column(
                        children: [
                          _FeatureRow(
                            icon: Icons.search,
                            text: l10n.previewFeatureBrowse,
                            goldColor: _goldAccent,
                          ),
                          const SizedBox(height: 12),
                          _FeatureRow(
                            icon: Icons.verified_user,
                            text: l10n.previewFeatureVerified,
                            goldColor: _goldAccent,
                          ),
                          const SizedBox(height: 12),
                          _FeatureRow(
                            icon: Icons.payments_outlined,
                            text: l10n.previewFeatureSecurePay,
                            goldColor: _goldAccent,
                          ),
                          const SizedBox(height: 12),
                          _FeatureRow(
                            icon: Icons.star_outline,
                            text: l10n.previewFeatureReviews,
                            goldColor: _goldAccent,
                          ),
                        ],
                      ),
                    ),
                  ),

                  const SizedBox(height: 28),

                  // ══════════════════════════
                  // CTA BUTTONS
                  // ══════════════════════════
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Column(
                      children: [
                        // Register Button
                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                            onPressed: widget.onRegister,
                            style: ElevatedButton.styleFrom(
                              backgroundColor: _goldAccent,
                              foregroundColor: Colors.black,
                              padding: const EdgeInsets.symmetric(
                                vertical: 16,
                              ),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                              elevation: 4,
                            ),
                            child: Text(
                              l10n.previewGetStarted,
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),

                        const SizedBox(height: 12),

                        // Login Button
                        SizedBox(
                          width: double.infinity,
                          child: OutlinedButton(
                            onPressed: widget.onLogin,
                            style: OutlinedButton.styleFrom(
                              foregroundColor: Colors.white,
                              side: BorderSide(
                                color: Colors.white.withOpacity(0.5),
                              ),
                              padding: const EdgeInsets.symmetric(
                                vertical: 16,
                              ),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                            child: Text(
                              l10n.previewAlreadyHaveAccount,
                              style: const TextStyle(fontSize: 15),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 16),

                  // Footer note
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24),
                    child: Text(
                      l10n.previewFooterNote,
                      style: const TextStyle(
                        color: Colors.white38,
                        fontSize: 11,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),

                  const SizedBox(height: 24),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

// ══════════════════════════════
// INTERNAL SERVICE DEFINITION
// ══════════════════════════════
class _PreviewServiceDef {
  final String key;
  final String nameKey;
  final String imagePath;

  const _PreviewServiceDef({
    required this.key,
    required this.nameKey,
    required this.imagePath,
  });
}

// ══════════════════════════════════════════════════════════════
// PREVIEW SERVICE ORB
// ✅ Exact same as _ServiceOrb but shows login prompt on confirm
// ══════════════════════════════════════════════════════════════
class _PreviewServiceOrb extends StatefulWidget {
  final ServiceItem service;
  final double size;
  final bool isSelected;
  final bool hasSelection;
  final double scaleValue;
  final double blurValue;
  final double buttonValue;
  final VoidCallback onTap;
  final VoidCallback onSelectConfirm;
  final Color nameColor;
  final Color nameSelectedColor;
  final String selectLabel;

  const _PreviewServiceOrb({
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
    required this.selectLabel,
  });

  @override
  State<_PreviewServiceOrb> createState() => _PreviewServiceOrbState();
}

class _PreviewServiceOrbState extends State<_PreviewServiceOrb>
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
          final hoverScale =
              widget.isSelected ? 1.0 : _hoverScale.value;

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
                        // ✅ Gold glow when selected
                        if (widget.isSelected)
                          Positioned(
                            child: Container(
                              width: widget.size + 12,
                              height: widget.size + 12,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                boxShadow: [
                                  BoxShadow(
                                    color: _goldAccent.withOpacity(
                                      (0.5 * safeButtonOpacity)
                                          .clamp(0.0, 1.0),
                                    ),
                                    blurRadius: 20,
                                    spreadRadius: 2,
                                  ),
                                ],
                              ),
                            ),
                          ),

                        // ✅ Circular image orb - exact same as home screen
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
                                blurRadius:
                                    widget.isSelected ? 15 : 8,
                                offset: Offset(
                                    0, widget.isSelected ? 6 : 3),
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
                                errorBuilder:
                                    (context, error, stackTrace) {
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

                        // ✅ "Book Now" overlay - shows login prompt
                        if (widget.isSelected &&
                            safeButtonOpacity > 0.01)
                          Opacity(
                            opacity: safeButtonOpacity,
                            child: Transform.scale(
                              scale: (0.5 +
                                      (0.5 * safeButtonOpacity))
                                  .clamp(0.1, 1.5),
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
                                      padding:
                                          const EdgeInsets.symmetric(
                                        horizontal: 16,
                                        vertical: 8,
                                      ),
                                      decoration: BoxDecoration(
                                        gradient:
                                            const LinearGradient(
                                          colors: [
                                            _goldAccent,
                                            _goldLight,
                                          ],
                                        ),
                                        borderRadius:
                                            BorderRadius.circular(20),
                                        boxShadow: [
                                          BoxShadow(
                                            color: _goldAccent
                                                .withOpacity(0.4),
                                            blurRadius: 10,
                                            offset:
                                                const Offset(0, 3),
                                          ),
                                        ],
                                      ),
                                      child: Text(
                                        widget.selectLabel,
                                        style: const TextStyle(
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

                    // ✅ Service name - same font/style as home screen
                    Text(
                      widget.service.name,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontFamily: 'Georgia',
                        fontSize: widget.isSelected ? 13 : 12,
                        fontWeight: widget.isSelected
                            ? FontWeight.w700
                            : FontWeight.w600,
                        color: widget.isSelected
                            ? widget.nameSelectedColor
                            : widget.nameColor,
                        letterSpacing: 0.3,
                        shadows: const [
                          Shadow(
                            color: Colors.black54,
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

// ══════════════════════════════
// FEATURE ROW WIDGET
// ══════════════════════════════
class _FeatureRow extends StatelessWidget {
  final IconData icon;
  final String text;
  final Color goldColor;

  const _FeatureRow({
    required this.icon,
    required this.text,
    required this.goldColor,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            color: goldColor.withOpacity(0.12),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Icon(icon, color: goldColor, size: 22),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: Text(
            text,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 14,
            ),
          ),
        ),
        Icon(Icons.check_circle, color: goldColor, size: 18),
      ],
    );
  }
}