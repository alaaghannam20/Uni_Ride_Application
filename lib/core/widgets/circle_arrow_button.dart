import 'package:flutter/material.dart';
import 'package:uni_ride_application/core/theme/app_colors.dart';
import 'dart:math';

class CircleArrowButton extends StatelessWidget {
  final double progress;
  final VoidCallback onPressed;
  final Widget child;

  const CircleArrowButton({
    super.key,
    required this.progress,
    required this.onPressed,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    const double size = 86;
    const double strokeWidth = 6;
    const double gap = 8;
    return RepaintBoundary(
      child: SizedBox(
        width: size,
        height: size,
        child: Stack(
          alignment: Alignment.center,
          children: [
            CustomPaint(
              size: const Size(86, 86),
              painter: _CircleProgressPainter(
                progress: progress,
                strokeWidth: strokeWidth,
              ),
            ),
            Material(
              shape: const CircleBorder(),
              color: AppColors.orangeprimary,
              child: InkWell(
                customBorder: const CircleBorder(),
                onTap: onPressed,
                child: SizedBox(
                  width: size - (gap * 2) - strokeWidth,
                  height: size - (gap * 2) - strokeWidth,
                  child: Center(child: child),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _CircleProgressPainter extends CustomPainter {
  final double progress;
  final double strokeWidth;

  _CircleProgressPainter({required this.progress, required this.strokeWidth});
  @override
  void paint(Canvas canvas, Size size) {
    final center = size.center(Offset.zero);
    final radius = (size.width / 2) - strokeWidth / 2;
    final backgroundPaint = Paint()
      ..color = const Color(0xFFFFDCA4)
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth;
    canvas.drawCircle(center, radius, backgroundPaint);
    final progressPaint = Paint()
      ..color = const Color(0xFFCF8307)
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth
      ..strokeCap = StrokeCap.round;
    final sweepAngle = 2 * pi * progress;

    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      -pi / 2,
      sweepAngle,
      false,
      progressPaint,
    );
  }

  @override
  bool shouldRepaint(covariant _CircleProgressPainter oldPainter) {
    return oldPainter.progress != progress ||
        oldPainter.strokeWidth != strokeWidth;
  }
}
