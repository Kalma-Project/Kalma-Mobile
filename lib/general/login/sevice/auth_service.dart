import 'package:dio/dio.dart';
import '../data/authUser.dart';

class AuthService{

  Future<AuthUser?> login(String email, String password) async{
    const api = 'https://kalma-backend-production.up.railway.app/api/user/authenticate';
    final data = {
      "email_or_username" : email,
      "password" : password
    };
    final dio = Dio();
    Response response;
    response = await dio.post(api, data: data);
    final body = response.data;
    if (response.statusCode == 200){
      return AuthUser(token: body['access_token'], message: body['message']);
    }else{
      return AuthUser(message: body['message']);
    }
  }
}