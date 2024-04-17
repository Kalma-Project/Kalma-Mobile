import 'package:flutter/material.dart';
import 'package:flutter_ta/general/login/screen/login_screen.dart';
import 'dart:developer';

import 'package:flutter_ta/general/register/screen/success_register_screen.dart';

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

  bool isChecked = false;

  void registerUser() async{
    List<TextEditingController> controllers = [
      fullnameController,
      usernameController,
      emailController,
      ageController,
      passwordController,
    ];

    if(controllers.every((element) => element.text.isNotEmpty)){
      var register = {
        "email":emailController.text,
        "password":passwordController.text,
        "username":usernameController.text,
        "full_name":fullnameController.text,
        "age":ageController.text
      };

      log('register: $register');

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const SuccessRegisterScreen()),
      );
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
                        keyboardType: TextInputType.text,
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
                      FilledButton.tonal(
                        onPressed: ()=>{
                          registerUser()
                        },
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all<Color>(
                              const Color(0xFF2F9296)),
                        ),
                        child: const Text(
                          'Daftar',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 14.0,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
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
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (context) => const LoginScreen()),
                                );
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
