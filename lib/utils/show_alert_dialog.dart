import 'package:flutter/material.dart';

Future showAlertDialog({required BuildContext context}) {
  return showDialog(
    context: context,
    builder: (_) => AlertDialog(
      title: Text('Are you sure want to leave?'),
      actions: [
        ElevatedButton(
          onPressed: () => Navigator.of(context).pop(true),
          child: Text('Yes'),
        ),
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: Text('No'),
        ),
      ],
    ),
  );
}
