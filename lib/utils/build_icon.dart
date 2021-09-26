  import 'package:flutter/material.dart';

Row buildIcon(IconData icon, String text) {
    return Row(
      children: [
        Icon(icon),
        SizedBox(
          width: 3,
        ),
        Text(text),
      ],
    );
  }