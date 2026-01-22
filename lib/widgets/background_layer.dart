// lib/widgets/background_layer.dart



import 'package:flutter/material.dart';


class BackgroundLayer extends StatelessWidget {
  final String imageAsset;
  final Widget child;

  /// Overlay color and intensity (helps readability).
  final Color overlayColor;
  final double overlayOpacity;

  final BoxFit fit;

  const BackgroundLayer({
    super.key,
    required this.imageAsset,
    required this.child,
    this.overlayColor = Colors.black,
    this.overlayOpacity = 0.5,
    this.fit = BoxFit.cover,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: [
        Image.asset(imageAsset, fit: fit),
        Container(color: overlayColor.withOpacity(overlayOpacity)),
        child,
      ],
    );
  }
}