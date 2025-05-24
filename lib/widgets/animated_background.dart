import 'package:flutter/material.dart';
import 'dart:math' as math;

class AnimatedBackground extends StatefulWidget {
  const AnimatedBackground({super.key});

  @override
  State<AnimatedBackground> createState() => _AnimatedBackgroundState();
}

class _AnimatedBackgroundState extends State<AnimatedBackground>
    with TickerProviderStateMixin {
  late AnimationController _controller;
  late AnimationController _secondaryController;
  final List<PathInfo> _paths = [];
  final List<PathInfo> _secondaryPaths = [];

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 40),
    )..repeat();

    _secondaryController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 35),
    )..repeat();

    // Generate primary paths
    for (int i = 0; i < 25; i++) {
      _paths.add(
        PathInfo(
          offset: i * 0.02,
          opacity: 0.2 + (i * 0.02),
          width: 1.5 + (i * 0.2),
          speed: 0.3 + (math.Random().nextDouble() * 0.2),
        ),
      );
    }

    // Generate secondary paths for layered effect
    for (int i = 0; i < 20; i++) {
      _secondaryPaths.add(
        PathInfo(
          offset: i * 0.03,
          opacity: 0.15 + (i * 0.015),
          width: 1.0 + (i * 0.15),
          speed: 0.4 + (math.Random().nextDouble() * 0.3),
        ),
      );
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    _secondaryController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        AnimatedBuilder(
          animation: _controller,
          builder: (context, child) {
            return CustomPaint(
              painter: BackgroundPainter(
                animation: _controller,
                paths: _paths,
                isDarkMode: Theme.of(context).brightness == Brightness.dark,
                isSecondary: false,
              ),
              child: Container(),
            );
          },
        ),
        AnimatedBuilder(
          animation: _secondaryController,
          builder: (context, child) {
            return CustomPaint(
              painter: BackgroundPainter(
                animation: _secondaryController,
                paths: _secondaryPaths,
                isDarkMode: Theme.of(context).brightness == Brightness.dark,
                isSecondary: true,
              ),
              child: Container(),
            );
          },
        ),
      ],
    );
  }
}

class PathInfo {
  final double offset;
  final double opacity;
  final double width;
  final double speed;

  PathInfo({
    required this.offset,
    required this.opacity,
    required this.width,
    required this.speed,
  });
}

class BackgroundPainter extends CustomPainter {
  final Animation<double> animation;
  final List<PathInfo> paths;
  final bool isDarkMode;
  final bool isSecondary;

  BackgroundPainter({
    required this.animation,
    required this.paths,
    required this.isDarkMode,
    required this.isSecondary,
  });

  @override
  void paint(Canvas canvas, Size size) {
    for (var pathInfo in paths) {
      final path = Path();

      // Different path patterns for primary and secondary layers
      if (!isSecondary) {
        // Primary layer - more horizontal movement
        final startX = -size.width * 0.1 + (pathInfo.offset * size.width * 0.2);
        final startY =
            size.height * 0.3 + (pathInfo.offset * size.height * 0.1);

        path.moveTo(startX, startY);

        final controlPoint1X =
            size.width * 0.3 + (pathInfo.offset * size.width * 0.1);
        final controlPoint1Y =
            size.height * 0.4 + (pathInfo.offset * size.height * 0.1);

        final controlPoint2X =
            size.width * 0.7 + (pathInfo.offset * size.width * 0.1);
        final controlPoint2Y =
            size.height * 0.6 + (pathInfo.offset * size.height * 0.1);

        final endX = size.width * 1.1;
        final endY = size.height * 0.7 - (pathInfo.offset * size.height * 0.2);

        path.cubicTo(controlPoint1X, controlPoint1Y, controlPoint2X,
            controlPoint2Y, endX, endY);
      } else {
        // Secondary layer - more vertical movement
        final startX = size.width * 0.2 + (pathInfo.offset * size.width * 0.1);
        final startY = -size.height * 0.1;

        path.moveTo(startX, startY);

        final controlPoint1X =
            size.width * 0.4 + (pathInfo.offset * size.width * 0.2);
        final controlPoint1Y = size.height * 0.3;

        final controlPoint2X =
            size.width * 0.6 + (pathInfo.offset * size.width * 0.2);
        final controlPoint2Y = size.height * 0.7;

        final endX = size.width * 0.8 + (pathInfo.offset * size.width * 0.1);
        final endY = size.height * 1.1;

        path.cubicTo(controlPoint1X, controlPoint1Y, controlPoint2X,
            controlPoint2Y, endX, endY);
      }

      final paint = Paint()
        ..color = (isDarkMode ? Colors.white : Colors.black)
            .withOpacity(pathInfo.opacity)
        ..style = PaintingStyle.stroke
        ..strokeWidth = pathInfo.width
        ..strokeCap = StrokeCap.round;

      final pathAnimation = (animation.value * pathInfo.speed) % 1.0;
      final pathMetrics = path.computeMetrics().first;

      // Draw multiple segments for continuous motion
      final segmentCount = 3;
      for (int i = 0; i < segmentCount; i++) {
        final segmentStart = (pathAnimation + (i / segmentCount)) % 1.0;
        final segmentEnd = (segmentStart + 0.4) % 1.0;

        final extractPath = pathMetrics.extractPath(
          pathMetrics.length * segmentStart,
          pathMetrics.length * segmentEnd,
        );

        canvas.drawPath(extractPath, paint);
      }
    }
  }

  @override
  bool shouldRepaint(covariant BackgroundPainter oldDelegate) {
    return oldDelegate.animation.value != animation.value;
  }
}
