import 'package:flutter/material.dart';
import 'package:flutter_ta/self_management/journaling/screen/input_journaling_screen.dart';
import 'package:flutter_ta/self_management/journaling/widget/emotion_card.dart';
import 'package:flutter_ta/widget/back_button.dart';
import 'dart:developer';

class JournalingPage extends StatefulWidget {
  const JournalingPage({super.key});

  @override
  State<JournalingPage> createState() => _JournalingPageState();
}

class _JournalingPageState extends State<JournalingPage> {
  bool isTapped = false;
  String selectedEmotion = '';

  void toggleCardBorder(String emotion) {
    setState(() {
      selectedEmotion = emotion;
    });
    log('selected emotion $selectedEmotion');
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: 'JakartaSans'
      ),
      home: Scaffold(
        backgroundColor: const Color(0xFFF6F1F1),
        body: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              const CustomBackButton(text: 'Journaling'),
              const SizedBox(
                height: 60.0,
              ),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 54.0),
                child: Text(
                  'Bagaimana perasaanmu hari ini?',
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 24.0,
                    color: Color(0xFF383838)
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              const SizedBox(
                height: 40,
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 14.0),
                width: MediaQuery.of(context).size.width * 1,
                height: MediaQuery.of(context).size.height * 0.495,
                child: GridView.count(
                  primary: false,
                  padding: const EdgeInsets.all(14.0),
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                  crossAxisCount: 2,
                  children: <Widget>[
                    EmotionCardWidget(
                      emotion: 'happy',
                      icons: 'images/sad_icon_svg.svg',
                      emotionBgColor: const Color(0xFFA0E7D2),
                      borderColor: const Color(0xFF12936C),
                      selectedEmotion: selectedEmotion,
                      onEmotionSelected: toggleCardBorder,
                    ),
                    EmotionCardWidget(
                      emotion: 'sad',
                      icons: 'images/sad_icon_svg.svg',
                      emotionBgColor: const Color(0xFFA9C9FF),
                      borderColor: const Color(0xFF2E579E),
                      selectedEmotion: selectedEmotion,
                      onEmotionSelected: toggleCardBorder,
                    ),
                    EmotionCardWidget(
                      emotion: 'grateful',
                      icons: 'images/sad_icon_svg.svg',
                      emotionBgColor: const Color(0xFFCDEDE1),
                      borderColor: const Color(0xFF59B08F),
                      selectedEmotion: selectedEmotion,
                      onEmotionSelected: toggleCardBorder,
                    ),
                    EmotionCardWidget(
                      emotion: 'anxious',
                      icons: 'images/sad_icon_svg.svg',
                      emotionBgColor: const Color(0xFFFEF0CD),
                      borderColor: const Color(0xFFC39B33),
                      selectedEmotion: selectedEmotion,
                      onEmotionSelected: toggleCardBorder,
                    ),
                  ],
                ),
              ),
              FilledButton.tonal(
                onPressed: ()=>{
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => InputJournal(emotion: selectedEmotion,)),
                  )
                },
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all<Color>(
                      const Color(0xFF2F9296)),
                ),
                child: const Text(
                  'Selanjutnya',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 14.0,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}