import 'package:flutter/material.dart';
import 'package:flutter_ta/general/dashboard/screen/home/home_screen.dart';
import 'package:flutter_ta/model/self_screening/screening.dart';
import 'package:flutter_ta/self_screening/data/answers.dart';
import 'package:flutter_ta/widget/back_button.dart';

class SelfScreening extends StatefulWidget {
  const SelfScreening({super.key});

  @override
  State<SelfScreening> createState() => _SelfScreeningState();
}

class _SelfScreeningState extends State<SelfScreening> {
  final PageController _pageController = PageController();
  Map<String, List<int>> categoryScores = {
    'depression': [],
    'anxiety': [],
    'stress': [],
  };

  int _currentPage = 0;
  bool isRadioSelected = false;

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: 'JakartaSans'
      ),
      home: Scaffold(
        key: _scaffoldKey,
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 14.0),
            child: Column(
              children: [
                const CustomBackButton(text: 'Self Screening'),
                const SizedBox(
                  height: 24.0,
                ),
                Container(
                  height: MediaQuery.of(context).size.height * 0.68,
                  child: PageView.builder(
                      controller: _pageController,
                      itemCount: questions.length,
                      onPageChanged: (int page) {
                        setState(() {
                          _currentPage = page;
                        });
                      },
                      itemBuilder: (context, index) {
                        return buildQuestionPage(index);
                      }
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    FilledButton.tonal(
                      onPressed: () {
                        if (isRadioSelected == true) {
                          if (_currentPage < questions.length - 1) {
                            _pageController.nextPage(
                              duration: const Duration(milliseconds: 500),
                              curve: Curves.ease,
                            );
                            setState(() {
                              isRadioSelected = false;
                            });
                          } else {
                            showScoreDialog();
                          }
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text('Jawaban harap diisi')),
                          );
                        }
                      },
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all<Color>(
                            const Color(0xFF2F9296)),
                      ),
                      child: Text(
                        _currentPage == questions.length - 1 ? 'Kumpulkan' : 'Selanjutnya',
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 14.0,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                )
              ]
            ),
          ),
        ),
      ),
    );
  }

  Widget buildQuestionPage(int index){
    return Column(
      children: <Widget>[
        Column(
          children: <Widget>[
            Text('Pertanyaan ${questions[index]['key']}')
          ],
        ),
        const SizedBox(
          height: 8.0,
        ),
        Stack(
          children: <Widget>[
            ClipRRect(
              borderRadius: BorderRadius.circular(20.0),
              child: SizedBox(
                width: MediaQuery.of(context).size.width * 1,
                height: 200,
                child: Image.asset(
                  'images/self_screen_question_bg.png',
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Positioned(
                top: 60,
                left: 0,
                right: 0,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 14.0),
                  child: Text(
                    questions[index]['question'],
                    style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                        color: Color(0xFFf0e7e7)
                    ),
                    textAlign: TextAlign.center,
                  ),
                )
            )
          ],
        ),
        const SizedBox(
          height: 12.0,
        ),
        Column(
          children: List.generate(
            questions[index]['answer'].length,
              (answerIndex) => Card(
                color: const Color(0xFFF5EFEF),
                elevation: 0,
                child: ListTile(
                  title: Text(questions[index]['answer'][answerIndex]),
                  leading: Radio(
                    value: answerIndex,
                    groupValue: categoryScores[questions[index]['category']]!.length > index
                        ? categoryScores[questions[index]['category']]![index]
                        : null,
                    onChanged: (int? value) {
                      setState(() {
                        if (value != null) {
                          if (categoryScores[questions[index]['category']]!.length <= index) {
                            categoryScores[questions[index]['category']]!.add(value);
                          } else {
                            categoryScores[questions[index]['category']]![index] = value;
                          }
                        }
                        isRadioSelected = true;
                      });
                    },
                  ),
                ),
              )
          )
        ),
      ],
    );
  }

  void showScoreDialog() {
    int totalDepressionScore = categoryScores['depression']!.reduce((value, element) => value + element);
    int totalAnxietyScore = categoryScores['anxiety']!.reduce((value, element) => value + element);
    int totalStressScore = categoryScores['stress']!.reduce((value, element) => value + element);
    // Here, you can do whatever you want with the scores, like showing them in a dialog
    // or sending them to a server
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Quiz Completed'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Depression Score: $totalDepressionScore'),
              Text('Anxiety Score: $totalAnxietyScore'),
              Text('Stress Score: $totalStressScore'),
            ],
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const HomeScreen(),)
                );
              },
              child: Text('OK'),
            ),
          ],
        );
      },
    );
  }
}