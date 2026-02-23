// lib/splash_screen.dart

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'dart:async';
import 'dart:math';

class SplashScreen extends StatefulWidget {
  final VoidCallback onComplete;

  const SplashScreen({
    super.key,
    required this.onComplete,
  });

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  // ── EXISTING controllers (kept from your original) ─────────────────
  late AnimationController _fadeController;
  late AnimationController _scaleController;
  late AnimationController _shimmerController;

  late Animation<double> _fadeAnimation;
  late Animation<double> _scaleAnimation;
  late Animation<double> _shimmerAnimation;

  // ── NEW controllers (for gold text shimmer + loader) ───────────────
  late AnimationController _textShimmerController;
  late AnimationController _loaderController;

  // ── Gold color palette ─────────────────────────────────────────────
  static const Color _goldDark = Color(0xFFB8860B);
  static const Color _goldBase = Color(0xFFD4AF37);
  static const Color _goldLight = Color(0xFFF5E6A3);
  static const Color _goldBright = Color(0xFFFFD700);

  @override
  void initState() {
    super.initState();

    // ── EXISTING animations (unchanged) ──────────────────────────────

    // Fade animation
    _fadeController = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );
    _fadeAnimation = CurvedAnimation(
      parent: _fadeController,
      curve: Curves.easeIn,
    );

    // Scale animation
    _scaleController = AnimationController(
      duration: const Duration(milliseconds: 1000),
      vsync: this,
    );
    _scaleAnimation = Tween<double>(begin: 0.8, end: 1.0).animate(
      CurvedAnimation(
        parent: _scaleController,
        curve: Curves.easeOutBack,
      ),
    );

    // Shimmer/glow animation (used for background glow effects)
    _shimmerController = AnimationController(
      duration: const Duration(milliseconds: 2000),
      vsync: this,
    );
    _shimmerAnimation = Tween<double>(begin: 0.3, end: 1.0).animate(
      CurvedAnimation(
        parent: _shimmerController,
        curve: Curves.easeInOut,
      ),
    );

    // ── NEW animations ───────────────────────────────────────────────

    // Gold shimmer sweep across text
    _textShimmerController = AnimationController(
      duration: const Duration(milliseconds: 2500),
      vsync: this,
    );

    // Spinning gold dashed loader
    _loaderController = AnimationController(
      duration: const Duration(milliseconds: 1500),
      vsync: this,
    );

    // ── Start all animations ─────────────────────────────────────────
    _fadeController.forward();
    _scaleController.forward();
    _shimmerController.repeat(reverse: true);
    _loaderController.repeat();

    // Start text shimmer slightly after text appears
    Future.delayed(const Duration(milliseconds: 800), () {
      if (mounted) {
        _textShimmerController.repeat();
      }
    });

    // Complete after 3 seconds (same as original)
    Timer(const Duration(milliseconds: 3000), () {
      if (mounted) {
        widget.onComplete();
      }
    });
  }

  @override
  void dispose() {
    _fadeController.dispose();
    _scaleController.dispose();
    _shimmerController.dispose();
    _textShimmerController.dispose();
    _loaderController.dispose();
    super.dispose();
  }

  // ════════════════════════════════════════════════════════════════════
  //  BUILD — Same structure, only logo + loader changed
  // ════════════════════════════════════════════════════════════════════
  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final screenWidth = screenSize.width;
    final screenHeight = screenSize.height;

    return Scaffold(
      backgroundColor: const Color(0xFF0B0F14),
      body: Container(
        width: screenWidth,
        height: screenHeight,
        decoration: const BoxDecoration(
          // ── KEPT: Original dark gradient background ─────────────────
          gradient: RadialGradient(
            center: Alignment.center,
            radius: 1.2,
            colors: [
              Color(0xFF1a1f2e),
              Color(0xFF0B0F14),
              Color(0xFF000000),
            ],
            stops: [0.0, 0.6, 1.0],
          ),
        ),
        child: AnimatedBuilder(
          animation: Listenable.merge([
            _fadeAnimation,
            _scaleAnimation,
            _shimmerAnimation,
            _textShimmerController,
            _loaderController,
          ]),
          builder: (context, child) {
            return Stack(
              children: [
                // ── KEPT: Original background glow effects ───────────
                Positioned.fill(
                  child: _buildGlowEffects(screenWidth, screenHeight),
                ),

                // ── CHANGED: Gold "STYLORIA" text instead of image ──
                Center(
                  child: Opacity(
                    opacity: _fadeAnimation.value,
                    child: Transform.scale(
                      scale: _scaleAnimation.value,
                      child: _buildBrandText(screenWidth),
                    ),
                  ),
                ),

                // ── CHANGED: Gold dashed loader instead of white spinner
                Positioned(
                  bottom: screenHeight * 0.1,
                  left: 0,
                  right: 0,
                  child: Opacity(
                    opacity: _fadeAnimation.value,
                    child: Center(
                      child: SizedBox(
                        width: 36,
                        height: 36,
                        child: CustomPaint(
                          painter: GoldDashedLoaderPainter(
                            progress: _loaderController.value,
                            color: _goldBase,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  // ════════════════════════════════════════════════════════════════════
  //  KEPT EXACTLY: Original background glow effects
  // ════════════════════════════════════════════════════════════════════
  Widget _buildGlowEffects(double screenWidth, double screenHeight) {
    return Stack(
      children: [
        // Top-left glow
        Positioned(
          top: -screenHeight * 0.1,
          left: -screenWidth * 0.3,
          child: Container(
            width: screenWidth * 0.8,
            height: screenWidth * 0.8,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: RadialGradient(
                colors: [
                  const Color(0xFF1a3a3a)
                      .withOpacity(0.6 * _shimmerAnimation.value),
                  Colors.transparent,
                ],
              ),
            ),
          ),
        ),

        // Top-right glow
        Positioned(
          top: screenHeight * 0.05,
          right: -screenWidth * 0.2,
          child: Container(
            width: screenWidth * 0.6,
            height: screenWidth * 0.6,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: RadialGradient(
                colors: [
                  const Color(0xFF1a3a3a)
                      .withOpacity(0.4 * _shimmerAnimation.value),
                  Colors.transparent,
                ],
              ),
            ),
          ),
        ),

        // Center glow behind logo
        Center(
          child: Container(
            width: screenWidth * 0.9,
            height: screenWidth * 0.9,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: Colors.green
                      .withOpacity(0.15 * _shimmerAnimation.value),
                  blurRadius: 100,
                  spreadRadius: 50,
                ),
                BoxShadow(
                  color: Colors.pink
                      .withOpacity(0.1 * _shimmerAnimation.value),
                  blurRadius: 80,
                  spreadRadius: 30,
                ),
              ],
            ),
          ),
        ),

        // Small decorative circles
        Positioned(
          top: screenHeight * 0.15,
          right: screenWidth * 0.15,
          child: _buildSmallCircle(12, Colors.white.withOpacity(0.8)),
        ),
        Positioned(
          top: screenHeight * 0.18,
          right: screenWidth * 0.08,
          child: _buildSmallCircle(20, Colors.white.withOpacity(0.6)),
        ),
        Positioned(
          top: screenHeight * 0.22,
          right: screenWidth * 0.12,
          child: _buildSmallCircle(8, Colors.white.withOpacity(0.4)),
        ),
        Positioned(
          bottom: screenHeight * 0.25,
          left: screenWidth * 0.08,
          child: _buildSmallCircle(16, Colors.white.withOpacity(0.5)),
        ),
        Positioned(
          bottom: screenHeight * 0.28,
          left: screenWidth * 0.15,
          child: _buildSmallCircle(6, Colors.white.withOpacity(0.3)),
        ),
      ],
    );
  }

  // ── KEPT: Original small circle builder ────────────────────────────
  Widget _buildSmallCircle(double size, Color color) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: color,
      ),
    );
  }

  // ════════════════════════════════════════════════════════════════════
  //  NEW: Gold "STYLORIA" brand text with shimmer animation
  // ════════════════════════════════════════════════════════════════════
  Widget _buildBrandText(double screenWidth) {
    return Padding(
      // 8% horizontal padding so text never touches screen edges
      padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.08),
      child: FittedBox(
        // FittedBox scales text DOWN on small screens so it always fits
        fit: BoxFit.scaleDown,
        child: ShaderMask(
          // Gold shimmer sweep: a moving gradient painted over the text
          shaderCallback: (Rect bounds) {
            final double pos = _textShimmerController.value;
            return LinearGradient(
              begin: Alignment(-1.5 + 4.0 * pos, 0.0),
              end: Alignment(-0.5 + 4.0 * pos, 0.0),
              colors: [
                _goldDark,
                _goldBase,
                _goldLight,
                _goldBright,
                _goldLight,
                _goldBase,
                _goldDark,
              ],
              stops: const [
                0.0,
                0.15,
                0.35,
                0.5,
                0.65,
                0.85,
                1.0,
              ],
            ).createShader(bounds);
          },
          blendMode: BlendMode.srcIn,
          child: Text(
            'STYLORIA',
            style: GoogleFonts.cinzel(
              fontSize: 52,
              fontWeight: FontWeight.w900,
              letterSpacing: 10,
              height: 1.0,
              // Color must be non-transparent for ShaderMask to paint over
              color: Colors.white,
            ),
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }
}

// ══════════════════════════════════════════════════════════════════════
//  CUSTOM PAINTER: Gold Dashed Circular Loader
// ══════════════════════════════════════════════════════════════════════
class GoldDashedLoaderPainter extends CustomPainter {
  final double progress; // 0.0 → 1.0 rotation
  final Color color;
  final int dashCount;

  GoldDashedLoaderPainter({
    required this.progress,
    required this.color,
    this.dashCount = 12,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final Offset center = Offset(size.width / 2, size.height / 2);
    final double radius = min(size.width, size.height) / 2 - 2;
    final double dashAngle = (2 * pi) / dashCount;
    final double sweepAngle = dashAngle * 0.5;

    for (int i = 0; i < dashCount; i++) {
      // Rotate the entire ring based on animation progress
      final double startAngle =
          (i * dashAngle) + (progress * 2 * pi) - (pi / 2);

      // Trailing fade: leading dashes bright, trailing dashes dim
      final double trailPosition = ((dashCount - i) / dashCount);
      final double opacity = (trailPosition * 0.85) + 0.15;

      final Paint dashPaint = Paint()
        ..color = color.withOpacity(opacity)
        ..style = PaintingStyle.stroke
        ..strokeWidth = 2.5
        ..strokeCap = StrokeCap.round;

      canvas.drawArc(
        Rect.fromCircle(center: center, radius: radius),
        startAngle,
        sweepAngle,
        false,
        dashPaint,
      );
    }
  }

  @override
  bool shouldRepaint(GoldDashedLoaderPainter oldDelegate) {
    return oldDelegate.progress != progress;
  }
}