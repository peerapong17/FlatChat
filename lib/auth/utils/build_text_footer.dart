import 'package:flutter/material.dart';

Row buildTextFooter(
      BuildContext context, String text, String label, Widget screen) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(text),
        TextButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => screen,
              ),
            );
          },
          child: Text(label),
        ),
      ],
    );
  }