import 'package:flutter/material.dart';

Widget textFormFieldLogin(
    String labelText, String textvalidator, TextEditingController controller) {
  return TextFormField(
      cursorColor: Colors.white,
      keyboardType: TextInputType.emailAddress,
      decoration: InputDecoration(
        labelText: labelText,
        labelStyle: TextStyle(color: Colors.white, fontSize: 20.0),
        enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.white),
        ),
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.white),
        ),
      ),
      textAlign: TextAlign.start,
      style: TextStyle(color: Colors.white, fontSize: 25.0),
      controller: controller,
      validator: (value) {
        if (value.trim().isEmpty) {
          return textvalidator;
        }
        return null;
      });
}

