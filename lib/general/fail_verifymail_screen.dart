import 'package:flutter/material.dart';
import 'package:flutter_ta/general/login/screen/login_screen.dart';

class FailVerifymailScreen extends StatelessWidget {
  const FailVerifymailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Expanded(
            child: Center(
              child: TextButton(
                onPressed: () {
                  Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) => const LoginScreen())
                  );
                },
                child: const Text('Gagal verif email, balik ke login'),
              ),
            )
        ),
      ),
    );
  }
}
