import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_ta/widget/back_button.dart';

class JournalingDetail extends StatefulWidget {
  final String title;
  final String emotion;
  final String? description;

   const JournalingDetail({
    Key? key,
    required this.title,
    required this.emotion,
    this.description
  }): super(key: key);

  @override
  State<JournalingDetail> createState() => _JournalingDetailState();
}

class _JournalingDetailState extends State<JournalingDetail> {
  late String emotionImageUrl;
  late Widget svgEmotionIcons;
  late String emotionText;

  Color getBoxColor(String emotionText) {
    switch (emotionText) {
      case 'Senang':
        return Color(0xFFA0E7D2);
      case 'Sedih':
        return Color(0xFFA9C9FF);
      case 'Marah':
        return Color(0xFFCDEDE1);
      case 'Bahagia':
        return Color(0xFFFEF0CD);
      default:
        return Colors.black; 
    }
  }


  @override
  void initState(){
    super.initState();

    if (widget.emotion == 'glad') {
      emotionImageUrl = 'images/happy_face_icon_svg.svg';
      emotionText = 'Senang';
    } else if (widget.emotion == 'sad') {
      emotionImageUrl = 'images/sad_icon_svg.svg';
      emotionText = 'Sedih';
    } else if (widget.emotion == 'angry') {
      emotionImageUrl = 'images/angry_icon_svg.svg';
      emotionText = 'Marah';
    } else if (widget.emotion == 'elated') {
      emotionImageUrl = 'images/excited_icon_svg.svg';
      emotionText = 'Bahagia';
    } else {
      emotionImageUrl = 'images/default_icon_svg.svg'; // Default image if none matches
    }

    svgEmotionIcons = SvgPicture.asset(
      emotionImageUrl,
      semanticsLabel: 'Emotion Icons',
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: 'JakartaSans'
      ),
      home: Scaffold(
        body: SingleChildScrollView(
          child: SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 14),
              child: Column(
                children: <Widget>[
                  CustomBackButton(text: widget.title,  onPressed: () => Navigator.pop(context),),
                  const SizedBox(
                    height: 20,
                  ),
                  Card(
                    elevation: 0,
                    color: getBoxColor(emotionText),
                    child: ListTile(
                      title: Text(
                        emotionText,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: Colors.black
                        ),
                      ),
                      leading: svgEmotionIcons,
                    ),
                  ),
                  const SizedBox(
                    height: 12,
                  ),
                  const Divider(
                    height: 34,
                    color: Color(0xFFDAD2D2),
                    thickness: 2,
                  ),
                  Text(
                    widget.description ?? 'Belum cerita ya hari ini?',
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                      color: Color(0xFF3D3D3D)
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
