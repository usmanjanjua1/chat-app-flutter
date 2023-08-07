import 'package:flutter/material.dart';

import '../constants/controllers.dart';
import '../constants/strings.dart';

Widget emailTextField() {
  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: TextFormField(
      controller: Controllers.emailController,
      keyboardType: TextInputType.emailAddress,
      decoration: const InputDecoration(
          labelText: 'Email',
          enabledBorder: UnderlineInputBorder(
            borderSide: BorderSide(
                color: Colors.black, style: BorderStyle.solid, width: 2),
          ),
          fillColor: Colors.black),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter your email';
        }
        if (!RegExp(MyStrings.emailRegex).hasMatch(value)) {
          return 'Please enter a valid email address';
        }
        return null;
      },
    ),
  );
}
