import 'package:flutter/material.dart';

class BreathingAttempIndicator extends StatefulWidget {
  final Duration breathingDuration;
  final bool isLineAppeared;

  const BreathingAttempIndicator({
    Key? key,
    required this.breathingDuration,
    required this.isLineAppeared,
  }): super(key: key);

  @override
  State<BreathingAttempIndicator> createState() => _BreathingAttempIndicatorState();
}

class _BreathingAttempIndicatorState extends State<BreathingAttempIndicator> with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
        vsync: this,
        duration: widget.breathingDuration
    );

    _controller.forward();
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
        return Row(
          children: <Widget>[
            CustomPaint(
              size: const Size(48, 3),
              painter: LinePainter(_controller.value),
            ),
          ]
        );
      },
    );
  }
}

class LinePainter extends CustomPainter {
  final double animationValue;

  LinePainter(this.animationValue);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = const Color(0xFF2B8589)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 5.0;

    const double startX = 0;
    const double endX = 48;
    final double y = size.height / 2;

    final double currentX = startX + (endX - startX) * animationValue;

    canvas.drawLine(Offset(startX, y), Offset(currentX, y), paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
