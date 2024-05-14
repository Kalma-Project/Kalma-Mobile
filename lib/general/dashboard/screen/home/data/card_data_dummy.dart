import 'package:flutter_ta/model/general/general.dart';

class CardContent {
  String text;

  CardContent({required this.text});
}

List<CardContent> contents = [
  CardContent(
    text: '"It is better to conquer yourself than to win a thousand battles"'
  ),
  CardContent(
      text: '"It is better to conquer yourself than to win a thousand battles"'
  ),
  CardContent(
      text: '"It is better to conquer yourself than to win a thousand battles"'
  ),
  CardContent(
      text: '"It is better to conquer yourself than to win a thousand battles"'
  ),
];

final List<ArticleData> articleData = [
  ArticleData(
      title: "Mengapa Mental Health Remaja?",
      imageUrl: "images/mental_image.png",
      author: "John Doe",
      description: "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nam ligula orci, lacinia vitae varius nec, lacinia et quam. Aenean et convallis urna. Proin efficitur luctus ultrices. Pellentesque ultrices dignissim mattis. Suspendisse blandit nunc erat, a fringilla diam posuere commodo. Ut erat tortor, viverra et lacinia et, mattis nec arcu. Mauris hendrerit vehicula pharetra."
  ),
  ArticleData(
      title: "Pentingnya Mental Health",
      imageUrl: "images/mental_image.png",
      author: "John Doe",
      description: ""
  ),
  ArticleData(
      title: "Pentingnya Mental Health",
      imageUrl: "images/mental_image.png",
      author: "John Doe",
      description: ""
  ),
  ArticleData(
      title: "Pentingnya Mental Health",
      imageUrl: "images/mental_image.png",
      author: "John Doe",
      description: ""
  ),
];
