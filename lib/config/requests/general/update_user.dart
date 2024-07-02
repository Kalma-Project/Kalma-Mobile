import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter_ta/model/general/general.dart';
import 'dart:typed_data';
import 'package:http_parser/http_parser.dart';

import '../../../main.dart';
import '../../api_service.dart';
import '../../endpoints.dart';


class UpdateUser {
  final ApiService _apiService = ApiService();

  Future<UpdateUserResponse?> updateProfile({
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
        final body = response.data;
        log('Profile updated successfully: $body');
        return UpdateUserResponse(
          is_success: body['is_success'],
          message: body['message'],
        );
      } else {
        final body = response.data;
        UpdateUserErrorDetails? errorDetails;
        if (body['error_details'] != null) {
          errorDetails = UpdateUserErrorDetails.fromMap(body['error_details']);
        }
        return UpdateUserResponse(
          is_success: body['is_success'],
          message: body['message'],
          error_details: errorDetails,
        );
      }
    } catch (e) {
      log('User property failed to update: server error $e');
    }
    return null;
  }

}
