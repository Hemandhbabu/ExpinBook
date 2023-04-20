import 'dart:math' as math;

import 'package:flutter/material.dart';

const deg_90 = math.pi / 2;
const deg_360 = math.pi * 2;

class CustomLinearProgress extends StatelessWidget {
  final double minHeight;
  final double value;
  final String? labelValue;
  final Color? color;
  CustomLinearProgress({
    Key? key,
    this.minHeight = 4.0,
    required double value,
    this.color,
  })  : labelValue = null,
        value = value.clamp(0, 1),
        assert(minHeight >= 4.0),
        super(key: key);

  CustomLinearProgress.withLabel({
    Key? key,
    this.minHeight = 30.0,
    required double value,
    required String label,
    this.color,
  })  : labelValue = label,
        value = value.clamp(0, 1),
        assert(minHeight >= 30.0),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    final TextDirection textDirection = Directionality.of(context);
    return Container(
      constraints: BoxConstraints.tightFor(height: minHeight),
      child: Stack(
        children: [
          Positioned.fill(
            child: CustomPaint(
              painter: _LinearPainter(
                color: color ?? ProgressColor.getColor(value),
                value: value,
                textDirection: textDirection,
              ),
            ),
          ),
          if (labelValue != null)
            Positioned.fill(
              child: Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(10, 5, 10, 5),
                  child: Text(
                    labelValue!,
                    style: const TextStyle(
                      fontSize: 14.5,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}

class _LinearPainter extends CustomPainter {
  final double value;
  final Color color;
  final TextDirection textDirection;
  _LinearPainter({
    required this.value,
    required this.textDirection,
    required this.color,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final Paint paint = Paint()
      ..color = color.withOpacity(0.1)
      ..style = PaintingStyle.fill;
    const radius = Radius.circular(100);
    canvas.drawRRect(
        RRect.fromRectAndRadius(Offset.zero & size, radius), paint);

    paint.color = color;
    final width = value.clamp(0.0, 1.0) * size.width;

    if (width <= 0.0) return;

    final double left;
    switch (textDirection) {
      case TextDirection.rtl:
        left = size.width - width - 0;
        break;
      case TextDirection.ltr:
        left = 0;
        break;
    }
    canvas.drawRRect(
        RRect.fromRectAndRadius(
          Offset(left, 0.0) & Size(width, size.height),
          radius,
        ),
        paint);
  }

  @override
  bool shouldRepaint(_LinearPainter oldPainter) =>
      oldPainter.color != color ||
      oldPainter.value != value ||
      oldPainter.textDirection != textDirection;
}

class ProgressColor {
  const ProgressColor._();

  static Color getColor(double value) => value >= 1
      ? Colors.red
      : value > 0.75
          ? Colors.deepOrange
          : value > 0.5
              ? Colors.orange
              : value > 0.25
                  ? Colors.blue
                  : Colors.green;
}
