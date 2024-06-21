import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class FailureAlert extends StatelessWidget {
  final String title;
  final String message;
  final void Function()? action;

  const FailureAlert({
    Key? key,
    required this.title,
    required this.message,
    this.action,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      icon: const Icon(Icons.error),
      iconColor: const Color(0xFF7D7D7D),
      title: Text(title),
      content: Text(message),
      actions: <Widget>[
        TextButton(
          onPressed: () {
            if (action != null) {
              action!();
            } else {
              Navigator.pop(context, 'OK');
            }
          },
          child: Text(
            'OK',
            style: GoogleFonts.plusJakartaSans(
              color: const Color(0xff3D3D3D),
            ),
          ),
        )
      ],
      titleTextStyle: GoogleFonts.plusJakartaSans(
        color: const Color(0xff3D3D3D),
        fontSize: 22,
      ),
      contentTextStyle: GoogleFonts.plusJakartaSans(
        color: const Color(0xff3D3D3D),
      ),
    );
  }
}
