import 'package:flutter/material.dart';

Padding buildDetail(String lable, String detail, double fontSize) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 5),
    child: Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            lable,
            style: TextStyle(fontSize: fontSize, fontWeight: FontWeight.w700),
          ),
          Text(
            detail,
            style: TextStyle(fontSize: fontSize, fontWeight: FontWeight.w700),
          ),
        ],
      ),
    ),
  );
}
