import 'package:flutter/material.dart';
import 'package:flutter_ta/self_management/journaling/screen/input_journaling_screen.dart';
import 'package:flutter_ta/self_management/journaling/widget/emotion_card.dart';
import 'dart:developer';

import '../widget/journal_history_button.dart';

class JournalingPage extends StatefulWidget {
  const JournalingPage({super.key,});


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
  void showEmotionSelectionAlert() {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: const Text('Silakan pilih salah satu perasaan sebelum melanjutkan.'),
        duration: const Duration(seconds: 2),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        margin: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 80.0),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF6F1F1),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 30.0, vertical: 10),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Jurnal Harian',
                    style: TextStyle(
                      color: Color(0xff3D3D3D),
                      fontSize: 20,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  HistoryJournalButton(),
                ],
              ),
            ),
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
                    color: Color(0xFF383838)),
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
                    emotion: 'senang',
                    icons: 'images/happy_face_icon_svg.svg',
                    emotionBgColor: const Color(0xFFA0E7D2),
                    borderColor: const Color(0xFF12936C),
                    selectedEmotion: selectedEmotion,
                    onEmotionSelected: toggleCardBorder,
                  ),
                  EmotionCardWidget(
                    emotion: 'sedih',
                    icons: 'images/sad_icon_svg.svg',
                    emotionBgColor: const Color(0xFFA9C9FF),
                    borderColor: const Color(0xFF2E579E),
                    selectedEmotion: selectedEmotion,
                    onEmotionSelected: toggleCardBorder,
                  ),
                  EmotionCardWidget(
                    emotion: 'marah',
                    icons: 'images/angry_icon_svg.svg',
                    emotionBgColor: const Color(0xFFFED6CD),
                    borderColor: const Color(0xFFC39B33),
                    selectedEmotion: selectedEmotion,
                    onEmotionSelected: toggleCardBorder,
                  ),
                  EmotionCardWidget(
                    emotion: 'bahagia',
                    icons: 'images/excited_icon_svg.svg',
                    emotionBgColor: const Color(0xFFA0E7D2),
                    borderColor: const Color(0xFF12936C),
                    selectedEmotion: selectedEmotion,
                    onEmotionSelected: toggleCardBorder,
                  ),
                ],
              ),
            ),
            FilledButton.tonal(
              onPressed: () => {
                if (selectedEmotion != '') {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => InputJournal(
                          emotion: selectedEmotion,
                        )),
                  )
                }
                else {
                showEmotionSelectionAlert()
                }
              },
              style: ButtonStyle(
                backgroundColor:
                MaterialStateProperty.all<Color>(const Color(0xFF2F9296)),
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
    );
  }
}
