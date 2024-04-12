import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomTextField extends StatefulWidget {
  final String labelText;
  final String placeHolder;

  const CustomTextField({
    Key? key,
    required this.labelText,
    required this.placeHolder,
  }) : super(key: key);

  @override
  _CustomTextFieldState createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  TextEditingController controller = TextEditingController();
  FocusNode focusNode = FocusNode();
  bool isFocused = false;

  @override
  void initState() {
    super.initState();
    controller.text = widget.placeHolder;
    focusNode.addListener(() {
      setState(() {
        isFocused = focusNode.hasFocus;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: TextField(
        cursorColor: const Color(0xff2F9296),
        controller: controller,
        focusNode: focusNode,
        style: GoogleFonts.plusJakartaSans(
          color: const Color(0xff3D3D3D),
          fontWeight: FontWeight.w700,
          fontSize: 14,
        ),
        decoration: InputDecoration(
          labelText: widget.labelText,
          labelStyle: const TextStyle(
            color: Color(0xff3D3D3D),
          ),
          floatingLabelBehavior: FloatingLabelBehavior.always,
          suffixIcon: isFocused
              ? IconButton(
            onPressed: () {
              controller.clear();
            },
            icon: Image.asset(
              'images/clear_icon.png',
              width: 20,
              height: 20,
            ),
          )
              : null,
          enabledBorder: UnderlineInputBorder(
            borderSide: BorderSide(
              color: isFocused ? const Color(0xff2F9296) : const Color(0xffE0DBDB),
            ),
          ),
          focusedBorder: const UnderlineInputBorder(
            borderSide: BorderSide(
              color: Color(0xff2F9296),
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    controller.dispose();
    focusNode.dispose();
    super.dispose();
  }
}
