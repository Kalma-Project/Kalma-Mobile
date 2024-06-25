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
      text: '"To fall in love with yourself is the secret to happiness"'
  ),
  CardContent(
      text: '"Life is too short to spend another day at war with yourself"'
  ),
  CardContent(
      text: '"Stop comparing yourself, flowers are pretty and so are sunsets"'
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
