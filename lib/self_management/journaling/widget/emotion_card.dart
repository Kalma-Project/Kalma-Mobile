import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class EmotionCardWidget extends StatefulWidget {
  final String emotion;
  final String icons;
  final Color? emotionBgColor;
  final Color? borderColor;
  final String selectedEmotion;
  final Function(String emotion) onEmotionSelected;

  const EmotionCardWidget(
      {Key? key,
      required this.icons,
      required this.emotion,
      this.emotionBgColor,
      this.borderColor,
      required this.selectedEmotion,
      required this.onEmotionSelected})
      : super(key: key);

  @override
  State<EmotionCardWidget> createState() => _EmotionCardWidgetState();
}

class _EmotionCardWidgetState extends State<EmotionCardWidget> {
  late Widget svgEmotionIcons;
  late String emotionData;
  bool isTapped = false;

  @override
  void initState() {
    super.initState();
    svgEmotionIcons = SvgPicture.asset(
      widget.icons,
      semanticsLabel: 'Emotion Icons',
    );
    emotionData = '';
  }

  void toggleCard() {
    setState(() {
      isTapped = !isTapped;
      if (widget.selectedEmotion == widget.emotion) {
        widget.onEmotionSelected('');
      } else {
        widget.onEmotionSelected(widget.emotion);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(fontFamily: 'JakartaSans'),
      home: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: isTapped ? widget.borderColor! : Colors.transparent,
            width: isTapped ? 2 : 0,
          ),
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: Scaffold(
              backgroundColor: widget.emotionBgColor,
              body: GestureDetector(
                onTap: toggleCard,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        svgEmotionIcons,
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          widget.emotion,
                          style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: Color(0xFF2B2B2B)),
                          textAlign: TextAlign.center,
                        )
                      ],
                    )
                  ],
                ),
              )),
        ),
      ),
    );
  }
}
