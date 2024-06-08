import 'dart:async';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_ta/self_management/breathing_meditation/widget/breathing_attemp_indicator.dart';
import 'package:flutter_ta/self_management/breathing_meditation/widget/breathing_circle.dart';
import 'dart:developer';

import 'package:flutter_ta/self_management/breathing_meditation/widget/breathing_text_indicator.dart';

class BreathingMeditation extends StatefulWidget {
  const BreathingMeditation({super.key});

  @override
  State<BreathingMeditation> createState() => _BreathingMeditationState();
}

class _BreathingMeditationState extends State<BreathingMeditation> {
  bool isStarted = true;
  bool isAgain = false;
  bool isInhale = false;
  bool isHold = false;
  bool isExhale = false;
  bool isLineAppeared = false;
  int countdown = 3;
  int breathingTime = 0;
  Timer? _timer;
  Timer? _breathingTimer;
  Duration breathingDuration = const Duration(seconds: 19);
  Duration lineDuration = const Duration(seconds: 57);

  void _startCountdown() {
    breathingTime = 0;
    _timer?.cancel();
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (countdown > 1) {
        setState(() {
          countdown--;
        });
      } else {
        timer.cancel();
        setState(() {
          countdown = 0;
          _startBreathingCount();
        });
      }
    });
    log('is Started $isStarted');
  }

  void _startBreathingCount() {
    _breathingTimer?.cancel();
    _breathingTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        if (breathingTime < 57) {
          breathingTime++;
          isLineAppeared = true;
        } else {
          breathingTime = 57;
          timer.cancel();
        }
        log('Breathing time: $breathingTime'); // Log breathing time
      });
    });
  }

  void _updateInhale(bool value) {
    setState(() {
      isInhale = value;
    });
  }

  void _updateHold(bool value) {
    setState(() {
      isHold = value;
    });
  }

  void _updateExhale(bool value) {
    setState(() {
      isExhale = value;
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    _breathingTimer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFB5DCD9),
      body: SafeArea(
        child: Stack(
          alignment: Alignment.center,
          children: <Widget>[
            SizedBox(
              width: MediaQuery.of(context).size.width * 1,
              child: Image.asset(
                'images/breathing_bg.png',
                fit: BoxFit.cover,
              ),
            ),
            Visibility(
              visible: isStarted || breathingTime == 57,
              child: Image.asset(
                'images/circle_breathing_start.png',
                fit: BoxFit.cover,
              ),
            ),
            GestureDetector(
              onTap: () {
                setState(() {
                  isStarted = false;
                  countdown = 3;
                });
                _startCountdown();
                log('isStarted $isStarted');
              },
              child: Visibility(
                visible: isStarted,
                child: Container(
                  width: MediaQuery.of(context).size.width * 0.4,
                  height: MediaQuery.of(context).size.height * 0.19,
                  alignment: Alignment.center,
                  child: const Text(
                    'START',
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                        color: Colors.white
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ),
            GestureDetector(
              onTap: () {
                // later will added
              },
              child: Visibility(
                visible: !isStarted,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width * 0.5,
                      child: Visibility(
                        visible: countdown == 0 ? false : true,
                        child: const Text(
                          'TARIK NAPAS DENGAN TENANG MELALUI HIDUNGMU',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                            color: Colors.white,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    if (countdown > 0)
                      Text(
                        countdown.toString(),
                        style: const TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                  ],
                ),
              ),
            ),
            Positioned(
                top: 55,
                child: Visibility(
                    visible: countdown == 0 ? true : false,
                    child: BreathingTextIndicator(
                        isInhale: isInhale,
                        isHold: isHold,
                        isExhale: isExhale
                    )
                )
            ),
            Visibility(
                visible: countdown == 0 ? true : false,
                child: BreathingCircle(
                  breathingDuration: breathingDuration,
                  onInhale: _updateInhale,
                  onHold: _updateHold,
                  onExhale: _updateExhale,
                  repeatCountFunc: _startBreathingCount,
                )
            ),
            Visibility(
                visible: countdown == 0 ? true : false,
                child: Positioned(
                  bottom: 40,
                  child: BreathingAttempIndicator(
                    breathingDuration: lineDuration,
                    isLineAppeared: isLineAppeared,
                  ),
                )
            ),
            Visibility(
                visible: breathingTime == 57,
                child: Positioned(
                  bottom: 30,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      ClipRRect(
                        borderRadius: const BorderRadius.only(
                          bottomLeft: Radius.circular(30.0),
                          bottomRight: Radius.circular(30.0),
                        ),
                        child: Container(
                          width: 18,
                          height: 18,
                          color: const Color(0xFF51FFF4),
                          child: const Icon(
                            Icons.check,
                            size: 6,
                            color: Color(0xFF3D3D3D),
                          ),
                        ),
                      )
                    ],
                  ),
                )
            ),
            GestureDetector(
              onTap: () {
                setState(() {
                  isStarted = false;
                  countdown = 3;
                });
                _startCountdown();
                log('isStarted $isStarted');
              },
              child: Visibility(
                visible: breathingTime == 57,
                child: Container(
                  width: MediaQuery.of(context).size.width * 0.4,
                  height: MediaQuery.of(context).size.height * 0.19,
                  alignment: Alignment.center,
                  child: const Text(
                    'AGAIN',
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                        color: Colors.white
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
