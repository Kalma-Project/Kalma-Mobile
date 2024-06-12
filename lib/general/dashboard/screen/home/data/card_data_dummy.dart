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
      paragraph: [
        ArticleParagraph(paragraph: "lorem ipsum lorem ipsum lorem ipsum lorem ipsum"),
        ArticleParagraph(paragraph: "lorem ipsum lorem ipsum lorem ipsum lorem ipsum"),
        ArticleParagraph(paragraph: "lorem ipsum lorem ipsum lorem ipsum lorem ipsum")
      ]
  ),
  ArticleData(
      title: "Pentingnya Mental Health",
      imageUrl: "images/mental_image.png",
      author: "John Doe",
      paragraph: [
        ArticleParagraph(paragraph: "lorem ipsum lorem ipsum lorem ipsum lorem ipsum"),
        ArticleParagraph(paragraph: "lorem ipsum lorem ipsum lorem ipsum lorem ipsum"),
        ArticleParagraph(paragraph: "lorem ipsum lorem ipsum lorem ipsum lorem ipsum")
      ]
  ),
  ArticleData(
      title: "Pentingnya Mental Health",
      imageUrl: "images/mental_image.png",
      author: "John Doe",
      paragraph: [
        ArticleParagraph(paragraph: "lorem ipsum lorem ipsum lorem ipsum lorem ipsum"),
        ArticleParagraph(paragraph: "lorem ipsum lorem ipsum lorem ipsum lorem ipsum"),
        ArticleParagraph(paragraph: "lorem ipsum lorem ipsum lorem ipsum lorem ipsum")
      ]
  ),
  ArticleData(
      title: "Pentingnya Mental Health",
      imageUrl: "images/mental_image.png",
      author: "John Doe",
      paragraph: [
        ArticleParagraph(paragraph: "lorem ipsum lorem ipsum lorem ipsum lorem ipsum"),
        ArticleParagraph(paragraph: "lorem ipsum lorem ipsum lorem ipsum lorem ipsum"),
        ArticleParagraph(paragraph: "lorem ipsum lorem ipsum lorem ipsum lorem ipsum")
      ]
  ),
];
