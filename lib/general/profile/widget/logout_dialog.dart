import 'package:flutter/material.dart';
import 'package:flutter_ta/general/login/screen/login_screen.dart';

void showLogoutConfirmationDialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
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
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context)=> const LoginScreen()));
              // Kalo dah jadi sama API logout
              print("User logged out");
            },
            child: Text("Ya"),
          ),
        ],
      );
    },
  );
}