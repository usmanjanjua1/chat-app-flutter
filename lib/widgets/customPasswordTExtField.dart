import 'package:flutter/material.dart';

import '../constants/controllers.dart';
import '../constants/strings.dart';

Widget passwordTExtField() {
  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: TextFormField(
      controller: Controllers.passwordController,
      obscureText: true,
      decoration: const InputDecoration(
          labelText: 'Password',
          enabledBorder: UnderlineInputBorder(
            borderSide: BorderSide(
                color: Colors.black, style: BorderStyle.solid, width: 2),
          ),
          fillColor: Colors.black),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter your password';
        }
        if (!RegExp(MyStrings.passwordRegex).hasMatch(value)) {
          return 'Password must be at least 6 characters long';
        }
        return null;
      },
    ),
  );
}
