import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_ta/config/requests/general/service.dart';
import 'package:flutter_ta/model/general/general.dart';
import 'package:flutter_ta/widget/failure_alert.dart';
import 'dart:developer';

import 'package:flutter_ta/widget/primary_custom_button.dart';

import '../../../main.dart';
import '../../../widget/success_alert.dart';

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
  final AuthService registerService = AuthService();
  final dio = Dio();

  bool isChecked = false;
  bool isLoading = false;

  String? usernameError;
  String? fullnameError;
  String? ageError;
  String? emailError;
  String? passwordError;

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

    if (controllers.every((element) => element.text.isNotEmpty) && isChecked) {
        RegisterUserResponse? registerUserResponse = await registerService.registerUserRequest(
          emailController.text,
          passwordController.text,
          usernameController.text,
          fullnameController.text,
          ageController.text,
        );

        setState(() {
          isLoading = false;
        });

        if (registerUserResponse != null) {
          if (registerUserResponse.is_success) {
            navigatorKey.currentState?.pushReplacementNamed('/success_register');
          } else {
            if (registerUserResponse.error_details != null) {
              setState(() {
                usernameError = registerUserResponse.error_details?.username;
                fullnameError = registerUserResponse.error_details?.full_name;
                emailError = registerUserResponse.error_details?.email;
                ageError = registerUserResponse.error_details?.age;
                passwordError = registerUserResponse.error_details?.password;
              });

              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return FailureAlert(
                    title: 'Registrasi Gagal',
                    message: registerUserResponse.message,
                  );
                },
              );
            }

            showDialog(
              context: context,
              builder: (BuildContext context) {
                return FailureAlert(
                  title: 'Registrasi Gagal',
                  message: registerUserResponse.message,
                );
              },
            );
          }
        }
    } else {
      log('Please fill all the fields');
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return FailureAlert(
            title: 'Data Tidak Lengkap',
            message: 'Mohon untuk melengkapi semua input teks dan persetujuan syarat ketentuan!.',
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
                        decoration: InputDecoration(
                          border: const UnderlineInputBorder(),
                          labelText: 'Nama Lengkap',
                          errorText: fullnameError ?? null,
                        ),
                      ),
                      TextFormField(
                        controller: usernameController,
                        keyboardType: TextInputType.text,
                        decoration: InputDecoration(
                          border: const UnderlineInputBorder(),
                          labelText: 'Username',
                          errorText: usernameError ?? null,
                        ),
                      ),
                      TextFormField(
                        controller: emailController,
                        keyboardType: TextInputType.text,
                        decoration: InputDecoration(
                          border: const UnderlineInputBorder(),
                          labelText: 'Alamat Email',
                          errorText: emailError ?? null
                        ),
                      ),
                      TextFormField(
                        controller: ageController,
                        keyboardType: TextInputType.number,
                        inputFormatters: <TextInputFormatter>[
                          FilteringTextInputFormatter.digitsOnly,
                        ],
                        decoration: InputDecoration(
                          border: const UnderlineInputBorder(),
                          labelText: 'Umur',
                          errorText: ageError ?? null
                        ),
                      ),
                      TextFormField(
                        controller: passwordController,
                        keyboardType: TextInputType.text,
                        decoration: InputDecoration(
                          border: const UnderlineInputBorder(),
                          labelText: 'Kata Sandi',
                          errorText: passwordError ?? null
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
