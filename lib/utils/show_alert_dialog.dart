import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

Future<dynamic> showAlertDialog(
    {required BuildContext context,
    required String title,
    required String content,
    Function()? onTap}) {
  return showDialog(
    context: context,
    barrierDismissible: true, // user must tap button!
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text(
          title,
          style: TextStyle(fontSize: 23),
        ),
        content: Text(content),
        actions: <Widget>[
          TextButton(child: Text('OK'), onPressed: onTap),
          TextButton(
            child: Text('Cancel'),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      );
    },
  );
}
