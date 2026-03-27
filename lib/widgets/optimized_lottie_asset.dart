import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class OptimizedLottieAsset extends StatelessWidget {
  const OptimizedLottieAsset({
    super.key,
    required this.assetPath,
    required this.width,
    required this.height,
  });

  final String assetPath;
  final double width;
  final double height;

  @override
  Widget build(BuildContext context) {
    return RepaintBoundary(
      child: SizedBox(
        width: width,
        height: height,
        child: Lottie.asset(
          assetPath,
          fit: BoxFit.contain,
        ),
      ),
    );
  }
}
