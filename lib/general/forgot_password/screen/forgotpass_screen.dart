import 'dart:developer';

import 'package:flutter/material.dart';

import 'package:flutter_ta/config/requests/general/service.dart';
import 'package:flutter_ta/model/general/general.dart';
import 'package:flutter_ta/widget/primary_custom_button.dart';

import '../../../widget/failure_alert.dart';

class ForgotPassScreen extends StatefulWidget {
  const ForgotPassScreen({super.key});

  @override
  State<ForgotPassScreen> createState() => _ForgotPassScreenState();
}

class _ForgotPassScreenState extends State<ForgotPassScreen> {
  AuthService authService = AuthService();
  TextEditingController emailunameController = TextEditingController();
  bool emailunameError = false;
  bool isLoading = false;

  void onInputChange(String value) {
    if (value.isNotEmpty){
      setState(() {
        emailunameError = false;
      });
    }
  }

  void forgotPassSubmit() async{
    setState(() {
      isLoading = true;
    });
    if (emailunameController.text.isNotEmpty) {
      ForgotPasswordResponse? sendForgotPassword = await authService.sendForgotPassword(emailunameController.text);
      if (!mounted) return;
      if (sendForgotPassword != null) {
        if (sendForgotPassword.is_success == true) {
          setState(() {
            isLoading = false;
          });
        } else {
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return FailureAlert(
                title: 'Permintaan Gagal',
                message: sendForgotPassword.message,
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
      } else {
        setState(() {
          isLoading = false;
        });
      }
    } else {
      setState(() {
        emailunameError = true;
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: 'JakartaSans'
      ),
      home: Scaffold(
        backgroundColor: const Color(0xFFF6F1F1),
        body: SafeArea(
          child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 14.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Container(
                    margin: const EdgeInsets.only(bottom: 60.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Column(
                          children: <Widget>[
                            const Text(
                              'Lupa Kata Sandi',
                              style: TextStyle(
                                  fontSize: 32.0,
                                  fontWeight: FontWeight.w700
                              ),
                            ),
                            const SizedBox(height: 12,),
                            SizedBox(
                              width: MediaQuery.of(context).size.width * 0.8,
                              child: const Text(
                                'Masukkan Email dan akan kami kirimkan link untuk membuat kata sandi baru',
                                style: TextStyle(
                                  fontSize: 16.0,
                                  fontWeight: FontWeight.w600,
                                  color: Color(0xFF585858),
                                ),
                                textAlign: TextAlign.center,
                                softWrap: true,
                              ),
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
                      TextFormField(
                        controller: emailunameController,
                        keyboardType: TextInputType.text,
                        onChanged: (value) => onInputChange(value),
                        decoration: InputDecoration(
                            border: const UnderlineInputBorder(),
                            labelText: 'Email atau Username',
                            errorText: emailunameError ? "Isi form dengan benar" : null
                        ),
                      ),
                      const SizedBox(
                        height: 18.0,
                      ),
                      CustomPrimaryButton(
                          function: forgotPassSubmit,
                          isLoading: isLoading,
                          buttonTitle: 'Lanjutkan'
                      )
                    ],
                  )
                ],
              ),
          )
        ),
      ),
    );
  }
}
