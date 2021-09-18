import 'package:flutter/material.dart';

class DrawerModel {
  IconData icon;
  String title;
  Widget page;
  bool? isLoggedIn;

  DrawerModel(
      {required this.icon,
      required this.title,
      required this.page,
      this.isLoggedIn});
}
