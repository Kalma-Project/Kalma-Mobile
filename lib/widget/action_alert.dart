import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ActionAlert extends StatelessWidget {
  final String title;
  final String message;
  final String? action1Message;
  final String? action2Message;
  final void Function()? action1;
  final void Function()? action2;

  const ActionAlert({
    Key? key,
    required this.title,
    required this.message,
    this.action1Message,
    this.action2Message,
    this.action1,
    this.action2,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      icon: const Icon(Icons.phonelink_setup),
      iconColor: const Color(0xFF7D7D7D),
      title: Text(title),
      content: Text(message),
      actions: <Widget>[
        if (action1 != null)
          TextButton(
            onPressed: action1,
            child: Text(
              action1Message ?? 'Cancel',
              style: GoogleFonts.plusJakartaSans(
                color: const Color(0xff3D3D3D),
              ),
            ),
          ),
        if (action2 != null)
          TextButton(
            onPressed: action2,
            child: Text(
              action2Message ?? 'OK',
              style: GoogleFonts.plusJakartaSans(
                color: const Color(0xff3D3D3D),
              ),
            ),
          ),
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
