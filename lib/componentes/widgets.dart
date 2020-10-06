import 'package:flutter/material.dart';

class Widgets{
  Widget userInput(
      TextEditingController controller, String labelText, String labelError) {
    return TextFormField(
      validator: (value) {
        if (value.isEmpty) {
          return labelError;
        } else {
          return null;
        }
      },
      controller: controller,
      keyboardType: TextInputType.number,
      decoration: InputDecoration(
          labelText: labelText, labelStyle: TextStyle(color: Colors.green)),
      textAlign: TextAlign.center,
      style: TextStyle(color: Colors.green, fontSize: 25.0),
    );
  }
}
