import 'package:flutter/material.dart';

Widget buildBottomNavigationBar() {
  return BottomNavigationBar(
    type: BottomNavigationBarType.fixed,
    currentIndex: 0,
    onTap: (value) {},
    items: const [
      BottomNavigationBarItem(icon: Icon(Icons.messenger), label: "Chats"),
      BottomNavigationBarItem(icon: Icon(Icons.people), label: "People"),
      BottomNavigationBarItem(icon: Icon(Icons.call), label: "Calls"),
      BottomNavigationBarItem(
        icon: CircleAvatar(
          radius: 14,
          child: Icon(Icons.person_2_rounded),
        ),
        label: "Profile",
      ),
    ],
  );
}
