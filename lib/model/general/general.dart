
class ArticleData{
  String title;
  String imageUrl;
  String author;
  String? description;

  ArticleData({
    required this.title,
    required this.imageUrl,
    required this.author,
    this.description,
  });
}