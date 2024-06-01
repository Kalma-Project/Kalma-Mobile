import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../../../model/general/general.dart';
import '../../api_service.dart';
import '../../endpoints.dart';
import '../../token/constants.dart';

class AuthService {
  ApiService apiService = ApiService();
  final FlutterSecureStorage _secureStorage = const FlutterSecureStorage();

  Future<AuthUser?> login(String email, String password) async {
    final data = {
      "email_or_username": email,
      "password": password
    };
    try {
      Response response = await apiService.dio.post(login_user, data: data);
      if (response.statusCode == 200) {
        final body = response.data;
        await _secureStorage.write(key: accessToken, value: body['access_token']);
        apiService.storeCookies(response);
        log('Login successful. Access token and refresh token stored.');
        return AuthUser(token: body['access_token'], message: body['message']);
      } else {
        final body = response.data;
        log('Login failed: ${response.data}');
        return AuthUser(message: body['message']);
      }
    } catch (e) {
      log('Login failed: $e');
      return AuthUser(message: 'An error occurred during login.');
    }
  }

  Future<void> registerUserRequest(
      String email,
      String password,
      String username,
      String full_name,
      String age
      ) async {
    try {
      Response response = await apiService.dio.post(
        register_user,
        data: {
          'email': email,
          'password': password,
          'username': username,
          'full_name': full_name,
          'age': age
        },
      );
      log('Response: ${response.data.toString()}');
    } catch (e) {
      log('Error: $e');
      if (e is DioException) {
        log('DioException: ${e.response?.data}');
      }
    }
  }

  Future<UserProperty?> getUserProperty() async {
    try {
      Response response = await apiService.dio.get(get_user_property);
      if (response.statusCode == 200) {
        final data = response.data;
        return UserProperty.fromJson(data);
      }
      log('User property fetched');
    } catch (e) {
      log('User property failed: server error $e');
    }
    return null;
  }

}