import 'package:flutter/material.dart';

class ResetPassScreen extends StatefulWidget {
  const ResetPassScreen({super.key});

  @override
  State<ResetPassScreen> createState() => _ResetPassScreenState();
}

class _ResetPassScreenState extends State<ResetPassScreen> {
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmpasswordController = TextEditingController();
  bool passwordError = false;
  bool confirmpasswordError = false;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        fontFamily: 'JakartaSans'
      ),
      home: Scaffold(
        backgroundColor: const Color(0xFFF6F1F1),
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 14.0),
            child: Column(
              children: <Widget>[
                Container(
                  margin: const EdgeInsets.only(bottom: 60.0),
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Column(
                        children: <Widget>[
                          Text(
                            'Reset Kata Sandi',
                            style: TextStyle(
                                fontSize: 32.0,
                                fontWeight: FontWeight.w700
                            ),
                          ),
                          Text(
                            'Buat kata sandi baru',
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
                      controller: passwordController,
                      keyboardType: TextInputType.text,
                      decoration: InputDecoration(
                          border: const UnderlineInputBorder(),
                          labelText: 'Email atau Username',
                          errorText: passwordError ? "Isi form dengan benar" : null
                      ),
                    ),
                    TextFormField(
                      controller: confirmpasswordController,
                      keyboardType: TextInputType.text,
                      decoration: InputDecoration(
                          border: const UnderlineInputBorder(),
                          labelText: 'Email atau Username',
                          errorText: confirmpasswordError ? "Isi form dengan benar" : null
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
