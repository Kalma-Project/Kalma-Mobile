import 'package:flutter/material.dart';

class SecondCustomButton extends StatelessWidget {
  final String labelText;
  final String placeHolder;
  final TextEditingController controller;
  final FocusNode? focusNode;

  const SecondCustomButton({
    Key? key,
    required this.labelText,
    required this.placeHolder,
    required this.controller,
    this.focusNode,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      focusNode: focusNode,
      decoration: InputDecoration(
        labelText: labelText,
        hintText: placeHolder,
      ),
    );
  }
}
