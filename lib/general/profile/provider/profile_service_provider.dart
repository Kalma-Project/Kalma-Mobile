import 'dart:typed_data';

import 'package:flutter/material.dart';
import '../../../config/requests/general/update_user.dart';


class ProfileServiceProvider with ChangeNotifier {
  final UpdateUser _profileService = UpdateUser();

  Future<void> updateProfile({
    required String fullName,
    required String age,
    required String email,
    required String username,
    required bool userPrivacy,
    Uint8List? avatar,
  }) async {
    await _profileService.updateProfile(
      fullName: fullName,
      age: age,
      email: email,
      username: username,
      userPrivacy: userPrivacy,
      avatar: avatar,
    );
    notifyListeners();
  }
}
