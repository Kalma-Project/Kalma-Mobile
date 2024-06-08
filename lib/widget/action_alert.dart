import 'package:flutter/material.dart';

class ActionAlert extends StatelessWidget {
  final String title;
  final String message;
  final String? action1Message;
  final String? action2Message;
  final Function? action1;
  final Function? action2;

  const ActionAlert({
    Key? key,
    required this.title,
    required this.message,
    this.action1Message,
    this.action2Message,
    this.action1,
    this.action2
  }): super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      icon: const Icon(Icons.phonelink_setup),
      iconColor: const Color(0xFF7D7D7D),
      title: Text(title),
      content: Text(message),
      actions: <Widget>[
        TextButton(
            onPressed: () => action1 ?? Navigator.pop(context, 'Cancel'),
            child: Text(action1Message ?? 'Cancel')
        ),
        TextButton(
            onPressed: () => action2 ?? Navigator.pop(context, 'OK'),
            child: Text(action2Message ?? 'OK')
        )
      ],
    );
  }
}
