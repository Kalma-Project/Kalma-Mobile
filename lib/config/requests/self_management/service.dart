import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter_ta/main.dart';

import '../../api_service.dart';
import '../../endpoints.dart';

class SelfManagementService {
  ApiService apiService = ApiService();

  Future<void> postNewJournal(
      String title,
      String emotion,
      String content,
      ) async {
    try {
      Response response = await apiService.dio.post(
        post_journaling,
        data: {
          'title': title,
          'emotion': emotion,
          'content': content,
        },
      );
      if (response.statusCode == 200) {
        navigatorKey.currentState?.pushNamed('/dashboard');
      }
      log('New Journal Post Status: ${response.data.toString()}');
    } catch (e) {
      log('Error Add New Journal: $e');
      if (e is DioException) {
        log('DioException Add New Journal: ${e.response?.data}');
      }
    }
  }
}