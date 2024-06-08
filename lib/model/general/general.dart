
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

class AuthUser{
  String? token;
  String? message;
  bool? is_email_verified;

  AuthUser({
    this.token,
    this.message,
    this.is_email_verified
  });
}

class RefreshToken{
  bool is_success;
  String access_token;
  String message;
  bool is_email_verified;

  RefreshToken({
    required this.is_success,
    required this.access_token,
    required this.message,
    required this.is_email_verified
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

class UserProperty {
  bool isSuccess;
  String message;
  UserPropertyData data;

  UserProperty({
    required this.isSuccess,
    required this.message,
    required this.data,
  });

  factory UserProperty.fromJson(Map<String, dynamic> json) {
    return UserProperty(
      isSuccess: json['is_success'],
      message: json['message'],
      data: UserPropertyData.fromJson(json['data']),
    );
  }
}

class UserPropertyData {
  String username;
  String fullName;
  String email;
  int age;
  String? avatarLink;
  bool allowJournal;
  String lastLoggedIn;

  UserPropertyData({
    required this.username,
    required this.fullName,
    required this.email,
    required this.age,
    this.avatarLink,
    required this.allowJournal,
    required this.lastLoggedIn,
  });

  factory UserPropertyData.fromJson(Map<String, dynamic> json) {
    return UserPropertyData(
      username: json['username'],
      fullName: json['full_name'],
      email: json['email'],
      age: json['age'],
      avatarLink: json['avatar_link'],
      allowJournal: json['allow_journal'],
      lastLoggedIn: json['last_logged_in'],
    );
  }
}

class ForgotPasswordPayload {
  String email_or_username;

  ForgotPasswordPayload({
    required this.email_or_username
  });

  factory ForgotPasswordPayload.fromJson(Map<String, dynamic> json) {
    return ForgotPasswordPayload(email_or_username: json['email_or_username']);
  }
}