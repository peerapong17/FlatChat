import 'package:flutter/material.dart';

GestureDetector buildIconButton(IconData icon, Function() func) {
  return GestureDetector(
    onTap: func,
    child: Container(
      padding: EdgeInsets.all(3),
      decoration: BoxDecoration(
        color: Colors.black54.withOpacity(0.5),
        borderRadius: BorderRadius.circular(13),
      ),
      child: Icon(
        icon,
        size: 30,
        color: Colors.white,
      ),
    ),
  );
  // return TextButton(
  //   style: TextButton.styleFrom(
  //     backgroundColor: Colors.black54,
  //     shape: RoundedRectangleBorder(
  //       borderRadius: BorderRadius.circular(13),
  //     ),
  //   ),
  //   onPressed: func,
  //   child: Icon(
  //     icon,
  //     size: 30,
  //     color: Colors.white,
  //   ),
  // );
}
