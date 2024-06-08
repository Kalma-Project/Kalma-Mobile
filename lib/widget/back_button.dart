import 'package:flutter/material.dart';

class CustomBackButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;

  const CustomBackButton({
    Key? key,
    required this.text,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 16.0),
      height: 48.0,
      child: Row(
        children: [
          TextButton(
            onPressed: onPressed,
            child: Row(
              children: [
                const Icon(Icons.arrow_back, color: Color(0xff3D3D3D)),
                const SizedBox(width: 12,),
                Text(
                  text,
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
