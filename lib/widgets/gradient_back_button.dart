import 'package:flutter/material.dart';

class GradientBackButton extends StatelessWidget {
  const GradientBackButton({
    super.key,
    required this.onPressed,
    this.size = _defaultIconSize,
    this.gradient = _defaultGradient,
  });

  final VoidCallback onPressed;
  final double size;
  final Gradient gradient;

  static const double _defaultIconSize = 36;
  static const LinearGradient _defaultGradient = LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [
      Color(0xFF3182CE),
      Color(0xFF48BB78),
    ],
  );

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: onPressed,
      padding: EdgeInsets.zero,
      constraints: const BoxConstraints(minHeight: 48, minWidth: 48),
      splashRadius: size * 0.75,
      iconSize: size,
      icon: ShaderMask(
        shaderCallback: (rect) => gradient.createShader(rect),
        blendMode: BlendMode.srcIn,
        child: Icon(
          Icons.arrow_back,
          color: Colors.white,
          size: size,
        ),
      ),
    );
  }
}
