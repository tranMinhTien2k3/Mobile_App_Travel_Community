import 'package:flutter/material.dart';

Widget getTextField(TextEditingController controller, FormFieldValidator<String>? validator) {
  return TextFormField(
    controller: controller,
    keyboardType: TextInputType.emailAddress,
    style: TextStyle(color: Colors.white),
    decoration: InputDecoration(
      labelStyle: TextStyle(color: Colors.white),
      suffixIcon: const Icon(
        Icons.email_rounded,
        size: 30,
        color: Colors.white,
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(20.0),
        borderSide: BorderSide(color: Colors.white)
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(20.0),
        borderSide: BorderSide(color: Colors.white)
      ),
      labelText: 'Email',
    ), 
    validator: validator,
  );
}

