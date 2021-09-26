import 'package:flutter/material.dart';

Widget buildElevatedButton(String label, Color color, Function() func) {
  return Expanded(
    child: ElevatedButton(
        child: Text(label),
        style: ElevatedButton.styleFrom(
          primary: color,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(23),
          ),
        ),
        onPressed: func),
  );
}
