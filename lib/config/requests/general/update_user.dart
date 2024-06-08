import 'dart:developer';

import 'package:dio/dio.dart';
import 'dart:typed_data';
import 'package:http_parser/http_parser.dart';

import '../../../main.dart';
import '../../api_service.dart';
import '../../endpoints.dart';


class UpdateUser {
  final ApiService _apiService = ApiService();

  Future<void> updateProfile({
    required String fullName,
    required String age,
    required String email,
    required String username,
    required bool userPrivacy,
    Uint8List? avatar,
  }) async {
    try {
      MultipartFile? avatarFile;
      if (avatar != null) {
        avatarFile = MultipartFile.fromBytes(
          avatar,
          filename: 'avatar.jpg',
          contentType: MediaType('image', 'jpeg'),
        );

      }

      FormData formData = FormData.fromMap({
        "full_name": fullName,
        "age": age,
        "email": email,
        "username": username,
        "allow_journal": userPrivacy.toString(),
        if (avatarFile != null) "avatar": avatarFile,
      });

      Response response = await _apiService.dio.put(
        update_user_property,
        data: formData,
      );

      if (response.statusCode == 200) {
        navigatorKey.currentState?.pushNamed('/dashboard');
        log('Profile updated successfully: ${response.data}');
      }
      log('Updated Profile Status: ${response.data.toString()}');

    } catch (e) {
      if (e is DioException) {
        if (e.response?.statusCode == 400) {
          final errorDetails = e.response?.data['error_details'];
          final errorMessage = e.response?.data['message'];
          log('Error updating profile: $errorMessage');
          if (errorDetails != null) {
            errorDetails.forEach((field, error) {
              log('Error in $field: $error');
            });
          }
        } else {
          final errorMessage = e.response?.data['message'];
          log('Unauthorized error: $errorMessage');
        }
      } else {
        log('Unexpected error: $e');
      }
    }
  }
}
