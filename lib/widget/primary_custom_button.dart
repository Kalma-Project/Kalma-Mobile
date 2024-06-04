import 'package:flutter/material.dart';

class CustomPrimaryButton extends StatelessWidget {
  final VoidCallback function;
  final bool isLoading;

  const CustomPrimaryButton({
    Key? key,
    required this.function,
    required this.isLoading,
  }): super(key: key);

  @override
  Widget build(BuildContext context) {
    return FilledButton.tonal(
        onPressed: function,
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all<Color>(
              const Color(0xFF2F9296)),
        ),
        child: isLoading ? const CircularProgressIndicator(
          color: Color(0xFFF6F1F1),
        ) : const Text(
          'Login',
          style: TextStyle(
            color: Colors.white,
            fontSize: 14.0,
            fontWeight: FontWeight.w600,
          ),
        ),
    );
  }
}
