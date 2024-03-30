import 'package:flutter/material.dart';
import 'dart:developer';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController emailunameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool isChecked = false;

  bool isNotValidated = false;

  void loginUser() async{
    if (emailunameController.text.isNotEmpty && passwordController.text.isNotEmpty) {

      var login = {
        "email_or_username":emailunameController.text,
        "password":passwordController.text
      };

      log('credentials: $login');
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: SafeArea(
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
                                  fontWeight: FontWeight.w600
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
                        decoration: InputDecoration(
                            border: const UnderlineInputBorder(),
                            labelText: 'Email atau Username',
                            errorText: isNotValidated ? "Isi form dengan benar" : null
                        ),
                      ),
                      TextFormField(
                        controller: passwordController,
                        keyboardType: TextInputType.text,
                        decoration: InputDecoration(
                            border: UnderlineInputBorder(),
                            labelText: 'Password',
                            errorText: isNotValidated ? "Password tidak sesuai" : null
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
                          const Text('Lupa Kata Sandi')
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
                ],
              ),
            )
        ),
      ),
    );
  }
}

