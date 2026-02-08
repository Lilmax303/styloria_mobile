// lib/widgets/provider_action_widget.dart

import 'dart:ui';
import 'package:flutter/material.dart';
import '../notifications_screen.dart';
import '../provider_profile_screen.dart';
import '../provider_wallet_screen.dart';
import '../open_jobs_screen.dart';
import '../my_reviews_screen.dart';
import '../booking_form_screen.dart';

class ProviderActionWidget extends StatefulWidget {
  const ProviderActionWidget({super.key});

  @override
  State<ProviderActionWidget> createState() => _ProviderActionWidgetState();
}

class _ProviderActionWidgetState extends State<ProviderActionWidget>
    with TickerProviderStateMixin {
  bool _showAll = false;
  String? _selectedActionKey;

  late AnimationController _selectionController;
  late Animation<double> _scaleAnimation;
  late Animation<double> _blurAnimation;
  late Animation<double> _buttonAnimation;

  // Fixed colors for light marble background
  static const Color _headerTextColor = Color(0xFF1A1A2E);
  static const Color _actionNameColor = Color(0xFF2D2D3A);
  static const Color _actionNameSelectedColor = Color(0xFFB8860B);
  static const Color _goldAccent = Color(0xFFD4AF37);
  static const Color _goldLight = Color(0xFFF4D03F);

  // Top 4 actions (always visible - 2 rows of 2)
  final List<ProviderActionItem> _topActions = [
    ProviderActionItem(
      key: 'browse_jobs',
      name: 'Browse Jobs',
      imagePath: 'assets/provider_actions/browse_jobs.png',
      icon: Icons.work_outline,
    ),
    ProviderActionItem(
      key: 'wallet',
      name: 'Wallet',
      imagePath: 'assets/provider_actions/wallet.png',
      icon: Icons.account_balance_wallet,
    ),
    ProviderActionItem(
      key: 'manage_profile',
      name: 'Manage Profile',
      imagePath: 'assets/provider_actions/manage_profile.png',
      icon: Icons.person_outline,
    ),
    ProviderActionItem(
      key: 'notifications',
      name: 'Notifications',
      imagePath: 'assets/provider_actions/notifications.png',
      icon: Icons.notifications_outlined,
    ),
  ];

  // Hidden actions (shown when "Show More" is tapped)
  final List<ProviderActionItem> _hiddenActions = [
    ProviderActionItem(
      key: 'new_booking',
      name: 'New Booking',
      imagePath: 'assets/provider_actions/new_booking.png',
      icon: Icons.calendar_today,
    ),
    ProviderActionItem(
      key: 'reviews',
      name: 'My Reviews',
      imagePath: 'assets/provider_actions/reviews.png',
      icon: Icons.star_outline,
    ),
    ProviderActionItem(
      key: 'portfolio',
      name: 'Portfolio',
      imagePath: 'assets/provider_actions/portfolio.png',
      icon: Icons.photo_library_outlined,
    ),
    ProviderActionItem(
      key: 'pricing',
      name: 'Services & Pricing',
      imagePath: 'assets/provider_actions/pricing.png',
      icon: Icons.attach_money,
    ),
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

  void _onActionTap(String actionKey) {
    if (_selectedActionKey == actionKey) {
      _selectionController.reverse().then((_) {
        if (mounted) {
          setState(() => _selectedActionKey = null);
        }
      });
    } else {
      setState(() => _selectedActionKey = actionKey);
      _selectionController.forward(from: 0);
    }
  }

  void _onSelectConfirm(String actionKey) {
    _selectionController.reverse();
    setState(() => _selectedActionKey = null);
    _handleAction(actionKey);
  }

  void _clearSelection() {
    if (_selectedActionKey != null) {
      _selectionController.reverse().then((_) {
        if (mounted) {
          setState(() => _selectedActionKey = null);
        }
      });
    }
  }

  void _handleAction(String actionId) {
    switch (actionId) {
      case 'notifications':
        Navigator.of(context).push(
          MaterialPageRoute(builder: (_) => const NotificationsScreen()),
        );
        break;

      case 'manage_profile':
        Navigator.of(context).push(
          MaterialPageRoute(builder: (_) => const ProviderProfileScreen()),
        );
        break;

      case 'wallet':
        Navigator.of(context).push(
          MaterialPageRoute(builder: (_) => const ProviderWalletScreen()),
        );
        break;

      case 'browse_jobs':
        Navigator.of(context).push(
          MaterialPageRoute(builder: (_) => const OpenJobsScreen()),
        );
        break;

      case 'reviews':
        Navigator.of(context).push(
          MaterialPageRoute(builder: (_) => const MyReviewsScreen()),
        );
        break;

      case 'new_booking':
        Navigator.of(context).push(
          MaterialPageRoute(builder: (_) => const BookingFormScreen()),
        );
        break;

      case 'portfolio':
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (_) => const ProviderProfileScreen(
              initialTab: ProviderProfileTab.portfolio,
            ),
          ),
        );
        break;

      case 'pricing':
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (_) => const ProviderProfileScreen(
              initialTab: ProviderProfileTab.pricing,
            ),
          ),
        );
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    final allActions = [..._topActions, if (_showAll) ..._hiddenActions];
    final screenWidth = MediaQuery.of(context).size.width;

    // ===== 2 PER ROW - Same calculation as ServiceSelectorWidget =====
    final circleSize = (screenWidth - 56) / 2.5;
    final clampedSize = circleSize.clamp(80.0, 140.0);

    return GestureDetector(
      onTap: _clearSelection,
      behavior: HitTestBehavior.translucent,
      child: Column(
        children: [
          // Header
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
            child: Column(
              children: [
                const Text(
                  'What would you like to do today?',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontFamily: 'Georgia',
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    letterSpacing: 0.3,
                    color: _headerTextColor,
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

          // Actions Grid - 2 per row
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: AnimatedBuilder(
              animation: _selectionController,
              builder: (context, _) {
                return Wrap(
                  spacing: 12,
                  runSpacing: 16,
                  alignment: WrapAlignment.center,
                  children: allActions.map((action) {
                    final isSelected = _selectedActionKey == action.key;
                    final hasSelection = _selectedActionKey != null;

                    return _ActionOrb(
                      action: action,
                      size: clampedSize,
                      isSelected: isSelected,
                      hasSelection: hasSelection,
                      scaleValue: _scaleAnimation.value,
                      blurValue: _blurAnimation.value,
                      buttonValue: _buttonAnimation.value.clamp(0.0, 1.0),
                      onTap: () => _onActionTap(action.key),
                      onSelectConfirm: () => _onSelectConfirm(action.key),
                      nameColor: _actionNameColor,
                      nameSelectedColor: _actionNameSelectedColor,
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
                      _showAll ? 'Show Less' : 'More Actions',
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

// Data model
class ProviderActionItem {
  final String key;
  final String name;
  final String imagePath;
  final IconData icon;

  ProviderActionItem({
    required this.key,
    required this.name,
    required this.imagePath,
    required this.icon,
  });
}

// Individual Action Orb - Same style as ServiceSelectorWidget
class _ActionOrb extends StatefulWidget {
  final ProviderActionItem action;
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

  const _ActionOrb({
    required this.action,
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
  State<_ActionOrb> createState() => _ActionOrbState();
}

class _ActionOrbState extends State<_ActionOrb>
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
                    // Circular image - NO BOX
                    Stack(
                      alignment: Alignment.center,
                      clipBehavior: Clip.none,
                      children: [
                        // Glow effect
                        if (widget.isSelected)
                          Container(
                            width: widget.size + 12,
                            height: widget.size + 12,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              boxShadow: [
                                BoxShadow(
                                  color: _goldAccent.withOpacity(
                                      (0.5 * safeButtonOpacity).clamp(0.0, 1.0)),
                                  blurRadius: 20,
                                  spreadRadius: 2,
                                ),
                              ],
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
                                widget.action.imagePath,
                                fit: BoxFit.cover,
                                width: widget.size,
                                height: widget.size,
                                errorBuilder: (context, error, stackTrace) {
                                  // Fallback to gradient + icon
                                  return Container(
                                    decoration: BoxDecoration(
                                      gradient: LinearGradient(
                                        begin: Alignment.topLeft,
                                        end: Alignment.bottomRight,
                                        colors: [
                                          _goldAccent.withOpacity(0.3),
                                          _goldLight.withOpacity(0.1),
                                        ],
                                      ),
                                    ),
                                    child: Icon(
                                      widget.action.icon,
                                      size: widget.size * 0.4,
                                      color: _goldAccent,
                                    ),
                                  );
                                },
                              ),
                            ),
                          ),
                        ),

                        // GO button overlay
                        if (widget.isSelected && safeButtonOpacity > 0.01)
                          Opacity(
                            opacity: safeButtonOpacity,
                            child: Transform.scale(
                              scale: (0.5 + (0.5 * safeButtonOpacity))
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
                                        'GO',
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 14,
                                          fontWeight: FontWeight.bold,
                                          letterSpacing: 1.5,
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

                    // Action name
                    Text(
                      widget.action.name,
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
                          Shadow(color: Colors.white, blurRadius: 4),
                        ],
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