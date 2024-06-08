
class JournalingData{
  String emotion;
  String icons;
  String? emotionBgColor;

  JournalingData({
    required this.emotion,
    required this.icons,
    this.emotionBgColor
  });
}
class JournalingPayload{
  String title;
  String emotion;
  String content;

  JournalingPayload({
    required this.title,
    required this.emotion,
    required this.content
  });
}