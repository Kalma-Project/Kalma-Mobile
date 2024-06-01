import 'package:flutter/material.dart';
import 'package:flutter_ta/general/dashboard/screen/dashboard_screen.dart';
import 'package:flutter_ta/general/forgot_password/screen/forgotpass_screen.dart';
import 'package:flutter_ta/general/login/data/authUser.dart';
import 'package:flutter_ta/general/login/sevice/auth_service.dart';
import 'dart:developer';

import 'package:flutter_ta/general/register/screen/register_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final AuthService _loginService = AuthService();
  TextEditingController emailunameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool isChecked = false;
  bool passwordVisible = false;
  bool emailError = false;
  bool passwordError = false;


  @override
  void initState(){
    super.initState();
    passwordVisible=true;
  }

  void loginUser() async{
    if (emailunameController.text.isNotEmpty && passwordController.text.isNotEmpty) {
      AuthUser? user = await _loginService.login(emailunameController.text, passwordController.text);

      if (user != null && user.token != null) {
        final prefs = await SharedPreferences.getInstance();
        prefs.setString('token', user.token!); // Simpan token

        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => DashboardScreen()),
        );
     }else{
       log('Login failed: user is null');
       setState(() {
         emailError = true;
         passwordError = true;
       });
     }
    } else {
      setState(() {
        emailError = true;
        passwordError = true;
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
                        FilledButton.tonal(
                          onPressed: ()=>{
                            loginUser()
                          },
                          style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all<Color>(
                                const Color(0xFF2F9296)),
                          ),
                          child: const Text(
                            'Login',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 14.0,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
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
    );
  }
}

