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
  bool isInhale = false;
  bool isHold = false;
  bool isExhale = false;
  bool isFirstLine = false;
  bool isSecondLine = false;
  bool isThirdLine = false;
  int countdown = 3;
  int breathingTime = 0;
  Timer? _timer;
  Timer? _breathingTimer;
  Duration breathingDuration = const Duration(seconds: 19);

  void _startCountdown() {
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
        });
      }
    });
  }

  void _startBreathingCount() {
    _breathingTimer?.cancel();
    _breathingTimer = Timer.periodic(const Duration(seconds: 57), (timer) {
      if (breathingTime <= 0) {
        setState(() {
          breathingTime++;
        });
        if (breathingTime >= 0 && breathingTime < 19) {
          setState(() {
            isFirstLine = true;
          });
        } else if (breathingTime > 19 && breathingTime < 38) {
          setState(() {
            isSecondLine = true;
          });
        } else if (breathingTime > 38 && breathingTime <= 57) {
          setState(() {
            isThirdLine = true;
          });
        }
      }
      log('$isFirstLine $isSecondLine $isThirdLine');
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
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: 'JakartaSans'
      ),
      home: Scaffold(
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
                visible: isStarted,
                child: Image.asset(
                  'images/circle_breathing_start.png',
                  fit: BoxFit.cover,
                ),
              ),
              GestureDetector(
                onTap: () {
                  setState(() {
                    isStarted = !isStarted;
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
                        breathingDuration: breathingDuration,
                        isFirstLine: isFirstLine,
                        isSecondLine: isSecondLine,
                        isThirdLine: isThirdLine,
                    ),
                  )
              )
            ],
          ),
        ),
      ),
    );
  }
}
