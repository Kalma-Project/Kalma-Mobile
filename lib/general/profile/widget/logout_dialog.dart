import 'package:flutter/material.dart';
import 'package:flutter_ta/config/requests/self_management/service.dart';
import 'package:flutter_ta/general/login/screen/login_screen.dart';
import 'package:flutter_ta/config/api_service.dart';
import 'package:flutter_ta/self_management/music/provider/playlist_provider.dart';

void showLogoutConfirmationDialog(BuildContext context) {
  SelfManagementService selfManagementService = SelfManagementService();

  showDialog(
    context: context,
    builder: (BuildContext context) {
      ApiService apiService = ApiService();
      return AlertDialog(
        title: Text("Konfirmasi Logout"),
        content: Text("Apakah Anda yakin ingin logout?"),
        actions: <Widget>[
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: Text("Tidak"),
          ),
          TextButton(
            onPressed:() async {
              await selfManagementService.stopMusicWhenLogout(context);
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (context) => const LoginScreen()),
                    (route) => false,
              );
            },
            child: Text("Ya"),
          ),
        ],
      );
    },
  );
}