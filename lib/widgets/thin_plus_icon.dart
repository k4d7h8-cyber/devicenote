import 'package:flutter/widgets.dart';

class ThinPlusIcon extends StatelessWidget {
  const ThinPlusIcon({
    super.key,
    this.size = 36,
    this.color,
    this.strokeWidth,
  });

  final double size;
  final Color? color;
  // If null, a responsive thin stroke is computed from size.
  final double? strokeWidth;

  @override
  Widget build(BuildContext context) {
    final resolvedColor = color ?? const Color(0xFF000000);
    // Thin, size-aware stroke: ~2% of size, with sensible bounds.
    final resolvedStroke = strokeWidth ?? _defaultStrokeForSize(size);
    return SizedBox(
      width: size,
      height: size,
      child: CustomPaint(
        painter: _PlusPainter(color: resolvedColor, strokeWidth: resolvedStroke),
      ),
    );
  }

  double _defaultStrokeForSize(double s) {
    final v = s * 0.02; // 2% of icon size
    if (v < 1.0) return 1.0; // keep visible at small sizes
    if (v > 2.0) return 2.0; // avoid looking bold at large sizes
    return v;
  }
}

class _PlusPainter extends CustomPainter {
  _PlusPainter({required this.color, required this.strokeWidth});

  final Color color;
  final double strokeWidth;

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round
      ..isAntiAlias = true
      ..strokeWidth = strokeWidth;

    // Keep some padding so the rounded caps don't clip.
    final padding = size.shortestSide * 0.2;
    final cx = size.width / 2;
    final cy = size.height / 2;

    // Horizontal line
    canvas.drawLine(
      Offset(padding, cy),
      Offset(size.width - padding, cy),
      paint,
    );
    // Vertical line
    canvas.drawLine(
      Offset(cx, padding),
      Offset(cx, size.height - padding),
      paint,
    );
  }

  @override
  bool shouldRepaint(covariant _PlusPainter oldDelegate) {
    return oldDelegate.color != color ||
        oldDelegate.strokeWidth != strokeWidth;
  }
}
