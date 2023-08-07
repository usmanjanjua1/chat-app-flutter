import 'package:flutter/material.dart';

import '../views/utils/strings.dart';

Widget welcomTextBar(String txt) {
  return Text(
    txt,
    style: const TextStyle(
        fontSize: 28, color: Colors.black, fontWeight: FontWeight.w600),
  );
}
