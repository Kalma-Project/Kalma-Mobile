import 'dart:ffi';

import 'package:flutter/material.dart';

class BreathingCircle extends StatefulWidget {
  final Duration breathingDuration;
  final Function(bool) onInhale;
  final Function(bool) onHold;
  final Function(bool) onExhale;
  final void repeatCountFunc;

  const BreathingCircle({
    Key? key,
    required this.breathingDuration,
    required this.onInhale,
    required this.onHold,
    required this.onExhale,
    required this.repeatCountFunc
  }): super(key: key);

  @override
  State<BreathingCircle> createState() => _BreathingCircleState();
}

class _BreathingCircleState extends State<BreathingCircle> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _sizeAnimation;
  int _repeatCount = 0;
  final int _maxRepeats = 3;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: widget.breathingDuration,
    );

    _sizeAnimation = TweenSequence(
      [
        TweenSequenceItem(
          tween: Tween<double>(begin: 1, end: 360).chain(CurveTween(curve: Curves.easeInOut)),
          weight: 4,
        ),
        TweenSequenceItem(
          tween: ConstantTween<double>(360),
          weight: 7,
        ),
        TweenSequenceItem(
          tween: Tween<double>(begin: 360, end: 1).chain(CurveTween(curve: Curves.easeInOut)),
          weight: 8,
        ),
      ],
    ).animate(_controller);

    _controller.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        _repeatCount++;
        if (_repeatCount < _maxRepeats) {
          _controller.forward(from: 0.0);
        } else {
          _controller.stop();
        }
      }
    });

    _controller.addListener(() {
      final elapsedSeconds = _controller.value * widget.breathingDuration.inSeconds;
      if (elapsedSeconds <= 4) {
        widget.onInhale(true);
        widget.onHold(false);
        widget.onExhale(false);
      } else if (elapsedSeconds <= 11) {
        widget.onInhale(false);
        widget.onHold(true);
        widget.onExhale(false);
      } else if (elapsedSeconds < 19){
        widget.onInhale(false);
        widget.onHold(false);
        widget.onExhale(true);
      } else {
        widget.onInhale(false);
        widget.onHold(false);
        widget.onExhale(false);
      }
    });

    widget.repeatCountFunc;
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 360,
      height: 360,
      child: Center(
        child: AnimatedBuilder(
          animation: _sizeAnimation,
          builder: (context, child) {
            return Container(
              width: _sizeAnimation.value,
              height: _sizeAnimation.value,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: Color(0xFF51FFF4),
              ),
            );
          },
        ),
      ),
    );
  }
}
