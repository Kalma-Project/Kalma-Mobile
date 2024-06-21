import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_ta/general/register/screen/success_register_screen.dart';

import '../../../main.dart';
import '../../../model/general/general.dart';
import '../../api_service.dart';
import '../../endpoints.dart';
import '../../token/constants.dart';

class AuthService {
  ApiService apiService = ApiService();
  final FlutterSecureStorage _secureStorage = const FlutterSecureStorage();

  String message = '';

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
        await _secureStorage.write(key: refresh_token, value: body['refresh_token']);
        log('Login successful. Access token and refresh token stored.');
        return AuthUser(token: body['access_token'], message: body['message'], is_email_verified: body['is_email_verified'], refresh_token: body['refresh_token']);
      } else {
        final body = response.data;
        log('Login failed: ${response.data}');
        return AuthUser(message: body['message'], is_email_verified: body['is_email_verified']);
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
      if (response.statusCode == 201) {
        navigatorKey.currentState?.pushReplacement(MaterialPageRoute(builder: (context) => const SuccessRegisterScreen()));
      } else {
        String message = response.data['message'].toString();
        throw Exception(message);
      }
      log('Response: ${response.data.toString()}');
    } catch (e) {
      log('Error: $e');
      if (e is DioException) {
        log('DioException: ${e.response?.data}');
        throw Exception(e.response?.data['message'].toString() ?? 'Failed to register');
      }
      rethrow;
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
      log(response.data);
    } catch (e) {
      log('User property failed: server error $e');
    }
    return null;
  }

  Future<ForgotPasswordPayload?> sendForgotPassword(String email_or_username) async {
    try {
      Response response = await apiService.dio.post(
        post_reset_password,
        data: {
          "email_or_username": email_or_username
        }
      );
      if (response.statusCode == 200) {
        final body = response.data;
        log(body['message']);
      }
    } catch (e) {
      log('Forgot password failed sended: server error $e');
    }
    return null;
  }

}