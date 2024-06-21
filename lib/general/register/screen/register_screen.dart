import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_ta/config/requests/general/service.dart';
import 'package:flutter_ta/widget/failure_alert.dart';
import 'dart:developer';

import 'package:flutter_ta/widget/primary_custom_button.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  TextEditingController fullnameController = TextEditingController();
  TextEditingController usernameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController ageController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  final AuthService _registerService = AuthService();
  final dio = Dio();

  bool isChecked = false;
  bool isLoading = false;

  void registerUser() async {
    setState(() {
      isLoading = true;
    });

    List<TextEditingController> controllers = [
      fullnameController,
      usernameController,
      emailController,
      ageController,
      passwordController,
    ];

    if (controllers.every((element) => element.text.isNotEmpty)) {
      try {
        await _registerService.registerUserRequest(
          emailController.text,
          passwordController.text,
          usernameController.text,
          fullnameController.text,
          ageController.text,
        );
      } catch (e) {
        log('Registration failed: $e');
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return FailureAlert(
                title: 'Register Failed',
                message: e.toString(),
                action: () {
                  Navigator.pop(context, 'OK');
                },
            );
          },
        );
      } finally {
        setState(() {
          isLoading = false;
        });
      }
    } else {
      log('Please fill all the fields');
      setState(() {
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
          child: SingleChildScrollView(
            padding: const EdgeInsets.only(top: 60.0),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 14.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Container(
                    margin: const EdgeInsets.only(bottom: 60.0),
                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Column(
                          children: <Widget>[
                            Text(
                              'Daftar',
                              style: TextStyle(
                                  fontSize: 32.0,
                                  fontWeight: FontWeight.w700
                              ),
                            ),
                            Text(
                              'Mulai perjalananmu dengan Kalma!',
                              style: TextStyle(
                                  fontSize: 16.0,
                                  fontWeight: FontWeight.w600,
                                  color: Color(0xFF585858)
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
                        controller: fullnameController,
                        keyboardType: TextInputType.text,
                        decoration: const InputDecoration(
                          border: UnderlineInputBorder(),
                          labelText: 'Nama Lengkap',
                          // errorText: isNotValidated ? "Isi form dengan benar" : null
                        ),
                      ),
                      TextFormField(
                        controller: usernameController,
                        keyboardType: TextInputType.text,
                        decoration: const InputDecoration(
                          border: UnderlineInputBorder(),
                          labelText: 'Username',
                          // errorText: isNotValidated ? "Isi form dengan benar" : null
                        ),
                      ),
                      TextFormField(
                        controller: emailController,
                        keyboardType: TextInputType.text,
                        decoration: const InputDecoration(
                          border: UnderlineInputBorder(),
                          labelText: 'Alamat Email',
                          // errorText: isNotValidated ? "Isi form dengan benar" : null
                        ),
                      ),
                      TextFormField(
                        controller: ageController,
                        keyboardType: TextInputType.number,
                        inputFormatters: <TextInputFormatter>[
                          FilteringTextInputFormatter.digitsOnly,
                        ],
                        decoration: const InputDecoration(
                          border: UnderlineInputBorder(),
                          labelText: 'Umur',
                          // errorText: isNotValidated ? "Isi form dengan benar" : null
                        ),
                      ),
                      TextFormField(
                        controller: passwordController,
                        keyboardType: TextInputType.text,
                        decoration: const InputDecoration(
                          border: UnderlineInputBorder(),
                          labelText: 'Kata Sandi',
                          // errorText: isNotValidated ? "Isi form dengan benar" : null
                        ),
                      ),
                      const SizedBox(
                        height: 18.0,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          Checkbox(
                            checkColor: Colors.white,
                            fillColor: MaterialStateProperty.resolveWith<Color>(
                                    (Set<MaterialState> states) {
                                  if (states.contains(MaterialState.selected)) {
                                    return const Color(0xFF2F9296);
                                  }
                                  return Colors.white;
                                }),
                            value: isChecked,
                            onChanged: (bool? value) {
                              setState(() {
                                isChecked = value!;
                              });
                            },
                          ),
                          const Text('Saya setuju dengan Syarat & Ketentuan'),
                        ],
                      ),
                      const SizedBox(
                        height: 18.0,
                      ),
                      CustomPrimaryButton(
                        function: registerUser,
                        isLoading: isLoading,
                        buttonTitle: 'Daftar',
                      ),
                      Container(
                        margin: const EdgeInsets.only(top: 18.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text(
                              'Sudah Memiliki Akun? ',
                              style: TextStyle(
                                  fontSize: 12.0,
                                  fontWeight: FontWeight.w500
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                Navigator.pushNamed(context, '/login');
                              },
                              child: const Text(
                                'Login',
                                style: TextStyle(
                                    fontSize: 12.0,
                                    fontWeight: FontWeight.w600,
                                    color: Color(0xFF2F9296)
                                ),
                              ),
                            )
                          ],
                        ),
                      )
                    ],
                  )
                ],
              ),
            ),
          )
        ),
      ),
    );
  }
}
