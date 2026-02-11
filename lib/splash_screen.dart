// lib/splash_screen.dart - FULL SCREEN VERSION

import 'package:flutter/material.dart';
import 'dart:async';

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
  late AnimationController _fadeController;
  late AnimationController _scaleController;
  late AnimationController _shimmerController;

  late Animation<double> _fadeAnimation;
  late Animation<double> _scaleAnimation;
  late Animation<double> _shimmerAnimation;

  @override
  void initState() {
    super.initState();

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

    // Shimmer/glow animation
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

    // Start animations
    _fadeController.forward();
    _scaleController.forward();
    _shimmerController.repeat(reverse: true);

    // Complete after 3 seconds
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
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Get screen dimensions for responsive sizing
    final screenSize = MediaQuery.of(context).size;
    final screenWidth = screenSize.width;
    final screenHeight = screenSize.height;
    
    // Logo should be about 70-80% of screen width, maintaining aspect ratio
    final logoSize = screenWidth * 0.75;

    return Scaffold(
      backgroundColor: const Color(0xFF0B0F14),
      body: Container(
        width: screenWidth,
        height: screenHeight,
        decoration: const BoxDecoration(
          // Dark gradient background matching your design
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
          ]),
          builder: (context, child) {
            return Stack(
              children: [
                // Animated glow effects in background
                Positioned.fill(
                  child: _buildGlowEffects(screenWidth, screenHeight),
                ),

                // Centered logo
                Center(
                  child: Opacity(
                    opacity: _fadeAnimation.value,
                    child: Transform.scale(
                      scale: _scaleAnimation.value,
                      child: _buildLogo(logoSize),
                    ),
                  ),
                ),

                // Optional: Loading indicator at bottom
                Positioned(
                  bottom: screenHeight * 0.1,
                  left: 0,
                  right: 0,
                  child: Opacity(
                    opacity: _fadeAnimation.value,
                    child: Column(
                      children: [
                        SizedBox(
                          width: 24,
                          height: 24,
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                            valueColor: AlwaysStoppedAnimation<Color>(
                              Colors.white.withOpacity(0.5),
                            ),
                          ),
                        ),
                        const SizedBox(height: 16),
                        Text(
                          'Loading...',
                          style: TextStyle(
                            color: Colors.white.withOpacity(0.5),
                            fontSize: 12,
                            letterSpacing: 2,
                          ),
                        ),
                      ],
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

  Widget _buildGlowEffects(double screenWidth, double screenHeight) {
    return Stack(
      children: [
        // Top-left glow (teal/dark circle like in your image)
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
                  const Color(0xFF1a3a3a).withOpacity(0.6 * _shimmerAnimation.value),
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
                  const Color(0xFF1a3a3a).withOpacity(0.4 * _shimmerAnimation.value),
                  Colors.transparent,
                ],
              ),
            ),
          ),
        ),

        // Center glow behind logo (green tint)
        Center(
          child: Container(
            width: screenWidth * 0.9,
            height: screenWidth * 0.9,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: Colors.green.withOpacity(0.15 * _shimmerAnimation.value),
                  blurRadius: 100,
                  spreadRadius: 50,
                ),
                BoxShadow(
                  color: Colors.pink.withOpacity(0.1 * _shimmerAnimation.value),
                  blurRadius: 80,
                  spreadRadius: 30,
                ),
              ],
            ),
          ),
        ),

        // Small decorative circles (like in your image)
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

  Widget _buildLogo(double size) {
    return Container(
      width: size,
      height: size,
      padding: const EdgeInsets.all(20),
      child: Image.asset(
        'assets/images/splash_logo.png',
        fit: BoxFit.contain,
        errorBuilder: (context, error, stackTrace) {
          debugPrint('Splash image error: $error');
          // Fallback text logo if image fails
          return _buildTextLogo();
        },
      ),
    );
  }

  Widget _buildTextLogo() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        // "S" in green + "tyloria" in pink/magenta
        RichText(
          text: TextSpan(
            children: [
              TextSpan(
                text: 'S',
                style: TextStyle(
                  fontSize: 72,
                  fontWeight: FontWeight.bold,
                  color: const Color(0xFF00D26A), // Green
                  shadows: [
                    Shadow(
                      color: Colors.green.withOpacity(0.5),
                      blurRadius: 30,
                    ),
                  ],
                ),
              ),
              TextSpan(
                text: 'tyloria',
                style: TextStyle(
                  fontSize: 48,
                  fontWeight: FontWeight.bold,
                  color: const Color(0xFFD63384), // Pink/Magenta
                  shadows: [
                    Shadow(
                      color: Colors.pink.withOpacity(0.5),
                      blurRadius: 20,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 12),
        // Tagline
        Text(
          'BEAUTY ON-DEMAND',
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w500,
            letterSpacing: 4,
            color: const Color(0xFFD4AF37), // Gold/Yellow
            shadows: [
              Shadow(
                color: Colors.amber.withOpacity(0.3),
                blurRadius: 10,
              ),
            ],
          ),
        ),
        const SizedBox(height: 8),
        // Decorative line
        Container(
          width: 150,
          height: 2,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Colors.transparent,
                Colors.white.withOpacity(0.5),
                Colors.transparent,
              ],
            ),
            borderRadius: BorderRadius.circular(1),
          ),
        ),
      ],
    );
  }
}