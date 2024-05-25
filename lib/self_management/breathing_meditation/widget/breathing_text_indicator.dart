import 'package:flutter/material.dart';

class BreathingTextIndicator extends StatefulWidget {
  final bool isInhale;
  final bool isHold;
  final bool isExhale;

  const BreathingTextIndicator({
    Key? key,
    required this.isInhale,
    required this.isHold,
    required this.isExhale
  }): super(key: key);

  @override
  State<BreathingTextIndicator> createState() => _BreathingTextIndicatorState();
}

class _BreathingTextIndicatorState extends State<BreathingTextIndicator> {

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Text(
          'Inhale',
          style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.w400,
              color: widget.isInhale ? const Color(0xFF2F9296) : const Color(0xFF143D3F)
          ),
        ),
        const SizedBox(
          width: 40,
        ),
        Text(
          'Hold',
          style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.w400,
              color: widget.isHold ? const Color(0xFF2F9296) : const Color(0xFF143D3F)
          ),
        ),
        const SizedBox(
          width: 40,
        ),
        Text(
          'Exhale',
          style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.w400,
              color: widget.isExhale ? const Color(0xFF2F9296) : const Color(0xFF143D3F)
          ),
        )
      ],
    );
  }
}
