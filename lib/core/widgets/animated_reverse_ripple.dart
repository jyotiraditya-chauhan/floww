import 'dart:math' as math;
import 'package:flutter/material.dart';

class AnimatedReverseRipple extends StatefulWidget {
  final Widget child;
  final Color rippleColor;
  final int ringCount;
  final double minRadius;
  final double maxRadius;
  final Duration duration;
  final double strokeWidth;
  final bool isInward;

  const AnimatedReverseRipple({
    super.key,
    required this.child,
    this.rippleColor = const Color(0xFFC3FF3D), // Default to Floww primary
    this.ringCount = 6, // Increased for a more 'infinite' continuous look
    this.minRadius = 40.0,
    this.maxRadius = 150.0,
    this.duration = const Duration(seconds: 4), // Slowed down
    this.strokeWidth = 1.0,
    this.isInward = true, // true = max to min, false = min to max
  });

  @override
  State<AnimatedReverseRipple> createState() => _AnimatedReverseRippleState();
}

class _AnimatedReverseRippleState extends State<AnimatedReverseRipple>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: widget.duration)
      ..repeat();
  }

  @override
  void didUpdateWidget(covariant AnimatedReverseRipple oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.duration != widget.duration) {
      _controller.duration = widget.duration;
      _controller.repeat();
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return CustomPaint(
          painter: _ReverseRipplePainter(
            progress: _controller.value,
            color: widget.rippleColor,
            ringCount: widget.ringCount,
            minRadius: widget.minRadius,
            maxRadius: widget.maxRadius,
            strokeWidth: widget.strokeWidth,
            isInward: widget.isInward,
          ),
          child: child,
        );
      },
      child: Center(child: widget.child),
    );
  }
}

class _ReverseRipplePainter extends CustomPainter {
  final double progress;
  final Color color;
  final int ringCount;
  final double minRadius;
  final double maxRadius;
  final double strokeWidth;
  final bool isInward;

  _ReverseRipplePainter({
    required this.progress,
    required this.color,
    required this.ringCount,
    required this.minRadius,
    required this.maxRadius,
    required this.strokeWidth,
    required this.isInward,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);

    final paint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth;

    for (int i = 0; i < ringCount; i++) {
      // Calculate normalized progress for each ring, offset by i
      double ringProgress = (progress + (i / ringCount)) % 1.0;

      // Determine radius based on direction
      double currentRadius = isInward
          ? minRadius + (maxRadius - minRadius) * (1 - ringProgress)
          : minRadius + (maxRadius - minRadius) * ringProgress;

      // Opacity fades in at maxRadius and fades out at minRadius
      double opacity = math.sin(ringProgress * math.pi);

      paint.color = color.withValues(alpha: opacity * 0.5);
      canvas.drawCircle(center, currentRadius, paint);
    }
  }

  @override
  bool shouldRepaint(covariant _ReverseRipplePainter oldDelegate) =>
      oldDelegate.progress != progress ||
      oldDelegate.color != color ||
      oldDelegate.maxRadius != maxRadius ||
      oldDelegate.minRadius != minRadius ||
      oldDelegate.isInward != isInward ||
      oldDelegate.ringCount != ringCount ||
      oldDelegate.strokeWidth != strokeWidth;
}
