
class ArticleData{
  String title;
  String imageUrl;
  String author;
  List<ArticleParagraph> paragraph;

  ArticleData({
    required this.title,
    required this.imageUrl,
    required this.author,
    required this.paragraph
  });
}

class ArticleParagraph {
  String paragraph;

  ArticleParagraph({
    required this.paragraph
  });
}

class AuthUser{
  String? token;
  String? message;
  bool? is_email_verified;
  String? refresh_token;
  bool? is_success;

  AuthUser({
    this.token,
    this.message,
    this.is_email_verified,
    this.refresh_token,
    this.is_success
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

class RegisterUserResponse {
  bool is_success;
  String message;
  RegisterUserErrorDetails? error_details;
  String? type;

  RegisterUserResponse({
    required this.is_success,
    required this.message,
    this.error_details,
    this.type,
  });
}

class RegisterUserErrorDetails {
  String? email;
  String? username;
  String? full_name;
  String? age;
  String? password;

  RegisterUserErrorDetails({
    this.email,
    this.username,
    this.full_name,
    this.age,
    this.password
  });

  factory RegisterUserErrorDetails.fromMap(Map<String, dynamic> map) {
    return RegisterUserErrorDetails(
      email: map['email'] as String?,
      username: map['username'] as String?,
      full_name: map['full_name'] as String?,
      age: map['age'] as String?,
      password: map['password'] as String?,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'email': email,
      'username': username,
      'full_name': full_name,
      'age': age,
      'password': password
    };
  }
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
  String? type;

  UserProperty({
    required this.isSuccess,
    required this.message,
    required this.data,
    this.type
  });

  factory UserProperty.fromJson(Map<String, dynamic> json) {
    return UserProperty(
      isSuccess: json['is_success'],
      message: json['message'],
      data: UserPropertyData.fromJson(json['data']),
      type: json['type']
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

class ForgotPasswordResponse {
  bool is_success;
  String message;

  ForgotPasswordResponse({
    required this.is_success,
    required this.message
  });

  factory ForgotPasswordResponse.fromJson(Map<String, dynamic> json) {
    return ForgotPasswordResponse(is_success: json['is_success'], message: json['message']);
  }
}

class ResetPasswordPayload {
  String new_password;
  String new_password_confirmation;

  ResetPasswordPayload({
    required this.new_password,
    required this.new_password_confirmation
  });

  factory ResetPasswordPayload.fromJson(Map<String, dynamic> json) {
    return ResetPasswordPayload(
        new_password: json['new_password'],
        new_password_confirmation: json['new_password_confirmation']
    );
  }
}

class ResetPasswordResponse {
  String? access_token;
  String? refresh_token;
  bool is_success;
  String message;

  ResetPasswordResponse({
    this.access_token,
    this.refresh_token,
    required this.is_success,
    required this.message
  });

  factory ResetPasswordResponse.fromJson(Map<String, dynamic> json) {
    return ResetPasswordResponse(
        access_token: json['access_token'],
        refresh_token: json['refresh_token'],
        is_success: json['is_success'],
        message: json['message']
    );
  }
}

class UpdateUserResponse {
  bool is_success;
  String message;
  UpdateUserErrorDetails? error_details;

  UpdateUserResponse({
    required this.is_success,
    required this.message,
    this.error_details
  });
}

class UpdateUserErrorDetails {
  String? email;
  String? username;
  String? full_name;
  String? age;
  String? avatar;
  String? user_privacy;

  UpdateUserErrorDetails({
    this.username,
    this.email,
    this.full_name,
    this.age,
    this.avatar,
    this.user_privacy
  });

  factory UpdateUserErrorDetails.fromMap(Map<String, dynamic> map) {
    return UpdateUserErrorDetails(
      email: map['email'] as String?,
      username: map['username'] as String?,
      full_name: map['full_name'] as String?,
      age: map['age'] as String?,
      avatar: map['avatar'] as String?,
      user_privacy: map['user_privacy'] as String?,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'email': email,
      'username': username,
      'full_name': full_name,
      'age': age,
      'avatar': avatar,
      'user_privacy': user_privacy,
    };
  }
}


class JournalHistoryResponse {
  final int size;
  final int page;
  final int totalItems;
  final int totalPages;
  final List<JournalData> data;
  final bool isSuccess;
  final String message;

  JournalHistoryResponse({
    required this.size,
    required this.page,
    required this.totalItems,
    required this.totalPages,
    required this.data,
    required this.isSuccess,
    required this.message,
  });

  factory JournalHistoryResponse.fromJson(Map<String, dynamic> json) {
    return JournalHistoryResponse(
      size: json['size'],
      page: json['page'],
      totalItems: json['total_items'],
      totalPages: json['total_pages'],
      data: (json['data'] as List).map((i) => JournalData.fromJson(i)).toList(),
      isSuccess: json['is_success'],
      message: json['message'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'size': size,
      'page': page,
      'total_items': totalItems,
      'total_pages': totalPages,
      'data': data.map((i) => i.toJson()).toList(),
      'is_success': isSuccess,
      'message': message,
    };
  }
}

class JournalData {
  final String id;
  final String title;
  final String emotion;
  final String content;
  final String createdDate;

  JournalData({
    required this.id,
    required this.title,
    required this.emotion,
    required this.content,
    required this.createdDate,
  });

  factory JournalData.fromJson(Map<String, dynamic> json) {
    return JournalData(
      id: json['id'],
      title: json['title'],
      emotion: json['emotion'],
      content: json['content'],
      createdDate: json['created_date'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'emotion': emotion,
      'content': content,
      'created_date': createdDate,
    };
  }
}
//music
class MusicDataResponse {
  final int size;
  final int page;
  final int totalItems;
  final int totalPages;
  final List<MusicData> data;
  final bool isSuccess;
  final String message;

  MusicDataResponse({
    required this.size,
    required this.page,
    required this.totalItems,
    required this.totalPages,
    required this.data,
    required this.isSuccess,
    required this.message,
  });

  factory MusicDataResponse.fromJson(Map<String, dynamic> json) {
    var dataList = json['data'] as List;
    List<MusicData> data = dataList.map((item) => MusicData.fromJson(item)).toList();

    return MusicDataResponse(
      size: json['size'],
      page: json['page'],
      totalItems: json['total_items'],
      totalPages: json['total_pages'],
      data: data,
      isSuccess: json['is_success'],
      message: json['message'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'size': size,
      'page': page,
      'total_items': totalItems,
      'total_pages': totalPages,
      'data': data.map((item) => item.toJson()).toList(),
      'is_success': isSuccess,
      'message': message,
    };
  }
}

class MusicData {
  final String id;
  final String title;
  final String author;
  final String genre;
  final String musicLink;
  final String createdBy;
  final String createdDate;
  final String updatedBy;
  final String updatedDate;

  MusicData({
    required this.id,
    required this.title,
    required this.author,
    required this.genre,
    required this.musicLink,
    required this.createdBy,
    required this.createdDate,
    required this.updatedBy,
    required this.updatedDate,
  });

  factory MusicData.fromJson(Map<String, dynamic> json) {
    return MusicData(
      id: json['id'],
      title: json['title'],
      author: json['author'],
      genre: json['genre'],
      musicLink: json['music_link'],
      createdBy: json['created_by'],
      createdDate: json['created_date'],
      updatedBy: json['updated_by'],
      updatedDate: json['updated_date'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'author': author,
      'genre': genre,
      'music_link': musicLink,
      'created_by': createdBy,
      'created_date': createdDate,
      'updated_by': updatedBy,
      'updated_date': updatedDate,
    };
  }
}


