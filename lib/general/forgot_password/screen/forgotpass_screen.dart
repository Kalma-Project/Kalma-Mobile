import 'package:flutter/material.dart';
import 'dart:developer';

class ForgotPassScreen extends StatefulWidget {
  const ForgotPassScreen({super.key});

  @override
  State<ForgotPassScreen> createState() => _ForgotPassScreenState();
}

class _ForgotPassScreenState extends State<ForgotPassScreen> {
  TextEditingController emailunameController = TextEditingController();
  bool emailunameError = false;

  void onInputChange(String value) {
    if (value.isNotEmpty){
      setState(() {
        emailunameError = false;
      });
    }
  }

  void forgotPassSubmit() async{
    if (emailunameController.text.isNotEmpty) {
      var forgotPassword = {
        "email_or_username":emailunameController.text
      };
      log('email_or_username: $forgotPassword');
    } else {
      setState(() {
        emailunameError = true;
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
                              width: MediaQuery.of(context).size.width * 0.8, // Adjust the width as needed
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
                      FilledButton.tonal(
                        onPressed: ()=>{
                          forgotPassSubmit()
                        },
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all<Color>(
                              const Color(0xFF2F9296)),
                        ),
                        child: const Text(
                          'Lanjutkan',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 14.0,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
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
