import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomTextField extends StatefulWidget {
  final String labelText;
  final String placeHolder;
  final TextEditingController? controller;
  final FocusNode? focusNode;
  final TextInputType? inputType;
  final String? errorText;
  final Function(String)? onChanged;

  const CustomTextField({
    Key? key,
    required this.labelText,
    required this.placeHolder,
    this.controller,
    this.focusNode,
    this.inputType,
    this.errorText,
    this.onChanged
  }) : super(key: key);

  @override
  _CustomTextFieldState createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  late TextEditingController _controller;
  late FocusNode _focusNode;
  bool isFocused = false;

  @override
  void initState() {
    super.initState();
    _controller = widget.controller ?? TextEditingController();
    _controller.text = widget.placeHolder;
    _focusNode = widget.focusNode ?? FocusNode();
    _focusNode.addListener(() {
      setState(() {
        isFocused = _focusNode.hasFocus;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: TextField(
        onChanged: widget.onChanged,
        cursorColor: const Color(0xff2F9296),
        controller: _controller,
        keyboardType: widget.inputType,
        focusNode: _focusNode,
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
          errorText: widget.errorText ?? '',
          floatingLabelBehavior: FloatingLabelBehavior.always,
          suffixIcon: isFocused
              ? IconButton(
            onPressed: () {
              _controller.clear();
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
    _controller.dispose();
    _focusNode.dispose();
    super.dispose();
  }
}