import 'package:flutter/material.dart';

Padding buildTableBody(String body) {
  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: Text(
      body,
      textAlign: TextAlign.center,
      style: TextStyle(fontSize: 17),
    ),
  );
}
