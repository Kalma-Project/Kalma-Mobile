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

class SelfScreeningDetail{
  bool is_success;
  String message;
  SelfScreeningDetailData data;

  SelfScreeningDetail({
    required this.is_success,
    required this.message,
    required this.data
  });

  factory SelfScreeningDetail.fromJson(Map<String, dynamic> json) {
    return SelfScreeningDetail(
        is_success: json['is_success'],
        message: json['message'],
        data: SelfScreeningDetailData.fromJson(json['data'])
    );
  }
}

class SelfScreeningDetailData{
  String id;
  String created_date;
  ResultDetailData depression_result;
  ResultDetailData anxiety_result;
  ResultDetailData stress_result;

  SelfScreeningDetailData({
    required this.id,
    required this.created_date,
    required this.depression_result,
    required this.anxiety_result,
    required this.stress_result
  });

  factory SelfScreeningDetailData.fromJson(Map<String, dynamic> json) {
    return SelfScreeningDetailData(
      id: json['id'],
      created_date: json['created_date'],
      depression_result: ResultDetailData.fromJson(json['depression_result']),
      anxiety_result: ResultDetailData.fromJson(json['anxiety_result']),
      stress_result: ResultDetailData.fromJson(json['stress_result'])
    );
  }
}

class ResultDetailData {
  int score;
  String status;

  ResultDetailData({
    required this.score,
    required this.status
  });

  factory ResultDetailData.fromJson(Map<String, dynamic> json) {
    return ResultDetailData(
      score: json['score'],
      status: json['status']
    );
  }
}