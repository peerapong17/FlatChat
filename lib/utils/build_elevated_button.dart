import 'package:flutter/material.dart';

Widget buildElevatedButton(
    {required String label,
    required Color color,
    required double height,
    required double fontSize,
    required Function() func}) {
  return Expanded(
    child: Container(
      height: height,
      child: ElevatedButton(
        child: Text(
          label,
          style: TextStyle(fontSize: fontSize),
        ),
        style: ElevatedButton.styleFrom(
          primary: color,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(23),
          ),
        ),
        onPressed: func,
      ),
    ),
  );
}
