import 'package:flutter/material.dart';

GestureDetector buildIconButton(IconData icon, Function() func) {
  return GestureDetector(
    onTap: func,
    child: Container(
      padding: EdgeInsets.all(3),
      decoration: BoxDecoration(
        color: Colors.black54,
        borderRadius: BorderRadius.circular(13),
      ),
      child: Icon(
        icon,
        size: 30,
        color: Colors.white,
      ),
    ),
  );
}
