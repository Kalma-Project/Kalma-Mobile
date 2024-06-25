import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_ta/config/requests/general/service.dart';
import 'package:flutter_ta/general/reset_password/screen/success_resetpassword_screen.dart';
import 'package:flutter_ta/model/general/general.dart';
import 'package:flutter_ta/widget/primary_custom_button.dart';

import '../../../widget/failure_alert.dart';

class ResetPassScreen extends StatefulWidget {
  final String? resetToken;

  const ResetPassScreen({
    Key? key,
    this.resetToken,
  }) : super(key: key);

  @override
  State<ResetPassScreen> createState() => _ResetPassScreenState();
}

class _ResetPassScreenState extends State<ResetPassScreen> {
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmpasswordController = TextEditingController();
  AuthService _authService = AuthService();
  bool isLoading = false;
  bool passwordError = false;
  bool confirmpasswordError = false;
  late String tokenReset;
  final dio = Dio();

  @override
  void initState() {
    super.initState();
    if (widget.resetToken != null) {
      tokenReset = widget.resetToken!;
    }
  }

  void resetPassword() async {
    setState(() {
      isLoading = true;
    });
    if (passwordController.text.isNotEmpty && confirmpasswordController.text.isNotEmpty) {
      ResetPasswordResponse? passwordResponse = await _authService.resetPassword(
          tokenReset,
          passwordController.text,
          confirmpasswordController.text
      );
      if (passwordResponse != null) {
        if (passwordResponse.is_success == true) {
          setState(() {
            isLoading = false;
          });
          Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => const SuccessResetPasswordScreen())
          );
        } else {
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return FailureAlert(
                title: 'Atur Ulang Password Gagal',
                message: passwordResponse.message,
                action: () {
                  Navigator.pop(context, 'OK');
                },
              );
            },
          );
          setState(() {
            isLoading = false;
          });
        }
      }
    } else {
      setState(() {
        passwordError = true;
        confirmpasswordError = true;
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        fontFamily: 'JakartaSans',
      ),
      home: Scaffold(
        backgroundColor: const Color(0xFFF6F1F1),
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 14.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Container(
                  margin: const EdgeInsets.only(bottom: 60.0),
                  child: const Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        'Reset Kata Sandi',
                        style: TextStyle(
                          fontSize: 32.0,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      Text(
                        'Buat kata sandi baru',
                        style: TextStyle(
                          fontSize: 16.0,
                          fontWeight: FontWeight.w600,
                          color: Color(0xFF585858),
                        ),
                      )
                    ],
                  ),
                ),
                TextFormField(
                  controller: passwordController,
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                    border: const UnderlineInputBorder(),
                    labelText: 'Kata Sandi Baru',
                    errorText: passwordError ? "Isi form dengan benar" : null,
                  ),
                ),
                TextFormField(
                  controller: confirmpasswordController,
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                    border: const UnderlineInputBorder(),
                    labelText: 'Konfirmasi Kata Sandi Baru',
                    errorText: confirmpasswordError ? "Isi form dengan benar" : null,
                  ),
                ),
                const SizedBox(
                  height: 24,
                ),
                CustomPrimaryButton(
                  function: resetPassword,
                  isLoading: isLoading,
                  buttonTitle: 'Atur Ulang Kata Sandi',
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
