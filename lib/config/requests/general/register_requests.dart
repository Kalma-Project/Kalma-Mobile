import 'package:dio/dio.dart';
import 'package:flutter_ta/config/api_service.dart';
import 'package:flutter_ta/config/endpoints.dart';
import 'dart:developer';

Future<void> registerUserRequest(
    String email,
    String password,
    String username,
    String full_name,
    String age
    ) async {
  try {
    ApiService apiService = ApiService();
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