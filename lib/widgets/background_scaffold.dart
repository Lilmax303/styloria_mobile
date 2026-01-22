// lib/widgets/background_scaffold.dart


import 'package:flutter/material.dart';

class BackgroundScaffold extends StatelessWidget {
  final String imageAsset;
  final Widget child;

  /// Dark overlay on top of image (helps text readability).
  final Color overlayColor;

  /// How strong the overlay is (0 = none, 1 = fully overlayColor)
  final double overlayOpacity;

  const BackgroundScaffold({
    super.key,
    required this.imageAsset,
    required this.child,
    this.overlayColor = Colors.black,
    this.overlayOpacity = 0.55,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          Image.asset(
            imageAsset,
            fit: BoxFit.cover,
          ),
          Container(
            color: overlayColor.withOpacity(overlayOpacity),
          ),
          SafeArea(child: child),
        ],
      ),
    );
  }
}