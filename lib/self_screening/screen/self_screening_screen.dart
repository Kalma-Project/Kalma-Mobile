import 'package:flutter/material.dart';
import 'package:flutter_ta/config/requests/self_screening/service.dart';
import 'package:flutter_ta/self_screening/data/answers.dart';
import 'package:flutter_ta/self_screening/screen/self_screening_result.dart';
import 'package:flutter_ta/widget/back_button.dart';
import 'dart:developer';

class SelfScreening extends StatefulWidget {
  const SelfScreening({super.key});

  @override
  State<SelfScreening> createState() => _SelfScreeningState();
}

class _SelfScreeningState extends State<SelfScreening> {
  final PageController _pageController = PageController();
  SelfScreeningService selfScreeningService = SelfScreeningService();

  Map<String, List<int>> categoryScores = {
    'depression': List.filled(questions.where((q) => q['category'] == 'depression').length, 0),
    'anxiety': List.filled(questions.where((q) => q['category'] == 'anxiety').length, 0),
    'stress': List.filled(questions.where((q) => q['category'] == 'stress').length, 0),
  };

  Map<int, int> questionAnswers = {};

  int _currentPage = 0;

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(left: 14.0, right: 14.0, top: 28.0),
          child: Column(
            children: [
              CustomBackButton(
                text: 'Self Screening',
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
              const SizedBox(
                height: 24.0,
              ),
              Container(
                height: MediaQuery.of(context).size.height * 0.68,
                child: PageView.builder(
                  controller: _pageController,
                  itemCount: questions.length,
                  physics: const NeverScrollableScrollPhysics(),
                  onPageChanged: (int page) {
                    setState(() {
                      _currentPage = page;
                    });
                  },
                  itemBuilder: (context, index) {
                    return buildQuestionPage(index);
                  },
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  FilledButton.tonal(
                    onPressed: () {
                      if (_currentPage > 0) {
                        _pageController.previousPage(
                          duration: const Duration(milliseconds: 500),
                          curve: Curves.ease,
                        );
                      }
                    },
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all<Color>(
                          const Color(0xFFF0E7E7)),
                    ),
                    child: const Text(
                      'Kembali',
                      style: TextStyle(
                        color: Color(0xFF2F9296),
                        fontSize: 14.0,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                  FilledButton.tonal(
                    onPressed: questionAnswers.containsKey(_currentPage) ? () {
                      if (_currentPage < questions.length - 1) {
                        _pageController.nextPage(
                          duration: const Duration(milliseconds: 500),
                          curve: Curves.ease,
                        );
                      } else {
                        showScore();
                      }
                    } : null,
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all<Color>(
                          const Color(0xFF2F9296)),
                    ),
                    child: Text(
                      _currentPage == questions.length - 1
                          ? 'Kumpulkan'
                          : 'Selanjutnya',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 14.0,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget buildQuestionPage(int index) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: Column(
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
              Container(
                height: MediaQuery.of(context).size.height * 0.265,
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 14.0),
                    child: Text(
                      questions[index]['question'],
                      style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w600,
                          color: Color(0xFFf0e7e7)),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              )
            ],
          ),
          const SizedBox(
            height: 12.0,
          ),
          Column(
            children: List.generate(questions[index]['answer'].length,
                    (answerIndex) => Card(
                  color: const Color(0xFFF5EFEF),
                  elevation: 0,
                  child: Container(
                    decoration: BoxDecoration(
                      border: questionAnswers[index] == answerIndex
                          ? Border.all(color: const Color(0xFF2f9296), width: 1.0)
                          : null,
                      borderRadius: const BorderRadius.all(Radius.circular(20)),
                      color: questionAnswers[index] == answerIndex
                          ? Colors.blue.withOpacity(0.3)
                          : null,
                    ),
                    child: ListTile(
                      title: Text(questions[index]['answer'][answerIndex]),
                      onTap: () {
                        setState(() {
                          questionAnswers[index] = answerIndex;
                          String category = questions[index]['category'];
                          int categoryIndex = questions
                              .where((q) => q['category'] == category)
                              .toList()
                              .indexOf(questions[index]);

                          categoryScores[category]![categoryIndex] = answerIndex;
                        });
                      },
                    ),
                  ),
                )),
          ),
        ],
      ),
    );
  }

  void showScore() async {
    int totalDepressionScore = 0;
    int totalAnxietyScore = 0;
    int totalStressScore = 0;

    totalDepressionScore = categoryScores['depression']!.reduce((a, b) => a + b);
    totalAnxietyScore = categoryScores['anxiety']!.reduce((a, b) => a + b);
    totalStressScore = categoryScores['stress']!.reduce((a, b) => a + b);

    try {
      await selfScreeningService.postSelfScreening(totalDepressionScore, totalAnxietyScore, totalStressScore);

      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => SelfScreeningResult(
                depressionScore: totalDepressionScore.toString(),
                anxietyScore: totalAnxietyScore.toString(),
                stressScore: totalStressScore.toString(),
                depressionStatus: selfScreeningService.depressionStatus,
                anxietyStatus: selfScreeningService.anxietyStatus,
                stressStatus: selfScreeningService.stressStatus,
                message: selfScreeningService.postMessage,
              )));

      log('Test Succeed!');
    } catch (e) {
      log('Error submitting test: $e');
    }
  }
}
