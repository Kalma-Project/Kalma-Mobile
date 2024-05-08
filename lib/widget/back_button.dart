import 'package:flutter/material.dart';

class CustomBackButton extends StatefulWidget {
  final String text;

  const CustomBackButton({
    Key? key,
    required this.text
  }): super(key: key);

  @override
  State<CustomBackButton> createState() => _CustomBackButtonState();
}

class _CustomBackButtonState extends State<CustomBackButton> {
  @override
  Widget build(BuildContext context) {
    return Container(
        margin: const EdgeInsets.only(top: 16.0),
        height: 48.0,
        child: Row(
          children: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Row(
                children: [
                  const Icon(Icons.arrow_back, color: Color(0xff3D3D3D)),
                  const SizedBox(width: 12,),
                  Text(
                    widget.text,
                    style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w500,
                        color: Color(0xff3D3D3D)
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      );
  }
}
