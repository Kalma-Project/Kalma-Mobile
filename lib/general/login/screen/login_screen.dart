import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_ta/config/requests/general/service.dart';
import 'package:flutter_ta/general/dashboard/screen/dashboard_screen.dart';
import 'package:flutter_ta/general/email_verification.dart';
import 'package:flutter_ta/general/forgot_password/screen/forgotpass_screen.dart';
import 'package:flutter_ta/widget/action_alert.dart';
import 'dart:developer';

import 'package:flutter_ta/widget/primary_custom_button.dart';

import '../../../model/general/general.dart';
import '../../../widget/failure_alert.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final AuthService _authService = AuthService();
  TextEditingController emailunameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool isChecked = false;
  bool passwordVisible = false;
  bool emailError = false;
  bool passwordError = false;
  bool isLoading = false;


  @override
  void initState(){
    super.initState();
    passwordVisible=true;
  }

  void loginUser() async{
    setState(() {
      isLoading = true;
    });
    if (emailunameController.text.isNotEmpty && passwordController.text.isNotEmpty) {
      AuthUser? user = await _authService.login(emailunameController.text, passwordController.text);

     if (user != null){
       if (user.token != null && user.is_success == true) {
         Navigator.pushAndRemoveUntil(
             context,
             MaterialPageRoute(builder: (context) => const DashboardScreen()),
                 (route) => false,
         );
         setState(() {
           isLoading = false;
         });
       } else if (user.is_success == true && user.is_email_verified == false) {
         Navigator.pushReplacement(
             context, 
             MaterialPageRoute(builder: (context) => const EmailVerification())
         );
       } else {
         showDialog(
           context: context,
           builder: (BuildContext context) {
             return FailureAlert(
               title: 'Login Gagal',
               message: user.message ?? 'Login anda gagal dikarenakan beberapa sebab',
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
       log('Login failed: user is null');
       setState(() {
         isLoading = false;
       });
     }
    } else {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return FailureAlert(
            title: 'Data Tidak Sesuai',
            message: 'Mohon untuk melengkapi semua input teks yang tersedia!',
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

  void onInputChange(String value, String field) {
    if (field == 'email') {
      if (value.isNotEmpty) {
        setState(() {
          emailError = false;
        });
      }
    } else if (field == 'password') {
      if (value.isNotEmpty) {
        setState(() {
          passwordError = false;
        });
      }
    }
  }

  Future<bool> _onWillPop() async {
    return (await showDialog(
      context: context,
      builder: (context) => ActionAlert(
          title: 'Keluar Aplikasi',
          message: 'Apakah anda yakin akan keluar dari aplikasi?',
          action1: () => Navigator.of(context).pop(false),
          action2: () {
            Navigator.of(context).pop(true);
            SystemNavigator.pop();
          },
      ),
    )) ??
        false;
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: 'JakartaSans'
      ),
      home: WillPopScope(
        onWillPop: _onWillPop,
        child: Scaffold(
          backgroundColor: const Color(0xFFF6F1F1),
          body: SafeArea(
              child: SingleChildScrollView(
                padding: const EdgeInsets.only(top: 100.0),
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
                                  'Login',
                                  style: TextStyle(
                                      fontSize: 32.0,
                                      fontWeight: FontWeight.w700
                                  ),
                                ),
                                Text(
                                  'Selamat Datang Kembali',
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
                            controller: emailunameController,
                            keyboardType: TextInputType.text,
                            onChanged: (value) => onInputChange(value, 'email'),
                            decoration: InputDecoration(
                                border: const UnderlineInputBorder(),
                                labelText: 'Email atau Username',
                                errorText: emailError ? "Isi form dengan benar" : null
                            ),
                          ),
                          TextFormField(
                            obscureText: passwordVisible,
                            controller: passwordController,
                            keyboardType: TextInputType.text,
                            onChanged: (value) => onInputChange(value, 'password'),
                            decoration: InputDecoration(
                                border: const UnderlineInputBorder(),
                                labelText: 'Password',
                                errorText: passwordError ? "Password tidak sesuai" : null,
                                suffixIcon: IconButton(
                                  icon: Icon(passwordVisible
                                      ? Icons.visibility
                                      : Icons.visibility_off),
                                  onPressed: () {
                                    setState(
                                          () {
                                        passwordVisible = !passwordVisible;
                                      },
                                    );
                                  },
                                ),
                              ),
                          ),
                          const SizedBox(
                            height: 18.0,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Row(
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
                                  const Text('Ingatkan Saya')
                                ],
                              ),
                              GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(builder: (context) => const ForgotPassScreen()),
                                  );
                                },
                                child: const Text('Lupa Kata Sandi'),
                              )
                            ],
                          ),
                          const SizedBox(
                            height: 18.0,
                          ),
                          CustomPrimaryButton(function: loginUser, isLoading: isLoading, buttonTitle: 'Login',),
                        ],
                      ),
                      Container(
                        margin: const EdgeInsets.only(top: 18.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text(
                                'Belum Punya Akun? ',
                                style: TextStyle(
                                  fontSize: 12.0,
                                  fontWeight: FontWeight.w500
                                ),
                              ),
                            GestureDetector(
                              onTap: () {
                                Navigator.pushNamed(context, '/register');
                              },
                              child: const Text(
                                'Daftar Akun',
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
                  ),
                ),
              )
          ),
        ),
      ),
    );
  }
}

