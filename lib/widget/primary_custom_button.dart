import 'package:flutter/material.dart';

class CustomPrimaryButton extends StatelessWidget {
  final VoidCallback function;
  final bool isLoading;
  final String buttonTitle;
  final double? horizontalPadding;

  const CustomPrimaryButton({
    Key? key,
    required this.function,
    required this.isLoading,
    required this.buttonTitle,
    this.horizontalPadding
  }): super(key: key);

  @override
  Widget build(BuildContext context) {
    return FilledButton.tonal(
        onPressed: function,
        style: ButtonStyle(
          backgroundColor: WidgetStateProperty.all<Color>(
              const Color(0xFF2F9296)
          ),
          padding: WidgetStateProperty.all<EdgeInsetsGeometry>(
            EdgeInsets.symmetric(horizontal: horizontalPadding ?? 28)
          ),
        ),
        child: isLoading ? const CircularProgressIndicator(
          color: Color(0xFFF6F1F1),
        ) : Text(
          buttonTitle,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 14.0,
            fontWeight: FontWeight.w600,
          ),
        ),
    );
  }
}
