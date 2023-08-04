import 'package:flutter/material.dart';

Widget customTile(double screenHeight1, String uEmail) {
  return Container(
      height: screenHeight1 * 0.24,
      width: double.maxFinite,
      decoration: BoxDecoration(
          color: Colors.white10, borderRadius: BorderRadius.circular(30)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 7),
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: const [
                    CircleAvatar(
                      child: Icon(Icons.person_2_rounded),
                    ),
                  ])),
          Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Text(uEmail,
                  style: TextStyle(
                    fontSize: screenHeight1 * 0.022,
                  ))),
        ],
      ));
}
