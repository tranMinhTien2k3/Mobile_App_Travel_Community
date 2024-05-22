import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CustomPasswordFormField extends ConsumerStatefulWidget {
  final TextEditingController controller;
  final String labelText;
  final String? Function(String?)? validator;
  final FocusNode? focusNode;

  const CustomPasswordFormField({
    Key? key,
    required this.controller,
    required this.labelText,
    this.validator,
    this.focusNode,
  }) : super(key: key);

  @override
  _CustomPasswordFormFieldState createState() => _CustomPasswordFormFieldState();
}

class _CustomPasswordFormFieldState extends ConsumerState<CustomPasswordFormField> {
  bool obscureText = true;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      focusNode: widget.focusNode,
      style: TextStyle(color: Colors.white),
      cursorColor: Colors.white,
      decoration: InputDecoration(
        labelStyle: TextStyle(color: Colors.white),
        suffixIcon: IconButton(
          icon: Icon(
            obscureText ? Icons.visibility : Icons.visibility_off,
            color: Colors.white, // Màu mặc định cho biểu tượng
          ),
          onPressed: () {
            setState(() {
              obscureText = !obscureText;
            });
          },
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20.0),
          borderSide: BorderSide(color: Colors.white),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20.0),
          borderSide: BorderSide(color: Colors.white),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20.0),
          borderSide: BorderSide(color: Colors.red),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20.0),
          borderSide: BorderSide(color: Colors.red),
        ),
        labelText: widget.labelText,
      ),
      obscureText: obscureText,
      validator: widget.validator ?? (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter your ${widget.labelText.toLowerCase()}';
        }
        return null;
      },
    );
  }
}
