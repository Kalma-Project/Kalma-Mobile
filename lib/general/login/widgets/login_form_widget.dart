import 'package:flutter/material.dart';

class InputLogin extends StatefulWidget {
  const InputLogin({super.key});

  @override
  State<InputLogin> createState() => _InputLoginState();
}

class _InputLoginState extends State<InputLogin> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 14.0),
        child: Column(
          children: <Widget>[
            TextFormField(
              decoration: const InputDecoration(
                border: UnderlineInputBorder(),
                labelText: 'Email atau Username'
              ),
            ),
            TextFormField(
              decoration: const InputDecoration(
                  border: UnderlineInputBorder(),
                  labelText: 'Password'
              ),
            ),
            FilledButton.tonal(
              onPressed: () {},
              child: const Text(
                  'Login',
                style: TextStyle(
                  color: Color(0xFF2F9296),
                  fontSize: 14.0,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        ),
      )
    );
  }
}
