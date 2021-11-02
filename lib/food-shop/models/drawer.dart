import 'package:flutter/material.dart';

class Drawer {
  IconData icon;
  String title;
  Widget page;
  bool isLoggedIn;

  Drawer(
      {required this.icon,
      required this.title,
      required this.page,
      required this.isLoggedIn});
}
