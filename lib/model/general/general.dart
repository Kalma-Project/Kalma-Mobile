
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

class RegisterPayload{
  String email;
  String password;
  String username;
  String full_name;
  String age;

  RegisterPayload({
    required this.email,
    required this.password,
    required this.username,
    required this.full_name,
    required this.age
  });

  Map<String, dynamic> toJson() {
    return {
      'email': email,
      'password': password,
      'username': username,
      'full_name': full_name,
      'age': age,
    };
  }
}