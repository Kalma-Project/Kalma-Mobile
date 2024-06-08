import 'package:flutter/material.dart';

class FailureAlert extends StatelessWidget {
  final String title;
  final String message;

  const FailureAlert({
    Key? key,
    required this.title,
    required this.message
  }): super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      icon: const Icon(Icons.error),
      iconColor: const Color(0xFF7D7D7D),
      title: Text(title),
      content: Text(message),
      actions: <Widget>[
        TextButton(
            onPressed: () => Navigator.pop(context, 'OK'),
            child: const Text('OK')
        )
      ],
    );
  }
}
