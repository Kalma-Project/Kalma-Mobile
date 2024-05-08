class ScreeningResponse{
  String question;
  List<ScreeningAnswer> answer;

  ScreeningResponse({
    required this.question,
    required this.answer
  });
}

class ScreeningAnswer{
  String answer_1;
  String answer_2;
  String answer_3;
  String answer_4;

  ScreeningAnswer({
    required this.answer_1,
    required this.answer_2,
    required this.answer_3,
    required this.answer_4
  });
}