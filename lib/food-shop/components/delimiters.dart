import 'package:flutter/material.dart';

Widget delimiters({required int index, required int currentPage}) {
  return Padding(
    padding: const EdgeInsets.only(right: 10, left: 10),
    child: Container(
      height: 12,
      width: 12,
      decoration: BoxDecoration(
          color: currentPage == index ? Colors.black : Colors.grey[300],
          borderRadius: BorderRadius.circular(50)),
    ),
  );
}
