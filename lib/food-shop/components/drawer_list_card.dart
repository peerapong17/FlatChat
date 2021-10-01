import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:login_ui/auth/login/login_screen.dart';
import 'package:login_ui/utils/show_alert_dialog.dart';

// ignore: must_be_immutable
class DrawerList extends StatelessWidget {
  String title;
  IconData icon;
  Widget page;
  bool? isLoggedOut;

  DrawerList(
      {required this.icon,
      required this.title,
      required this.page,
      this.isLoggedOut});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: isLoggedOut != null
          ? () async {
              await showAlertDialog(context: context);
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(
                  builder: (context) => SignInScreen(),
                ),
                (route) => false,
              );
            }
          : () {
              Navigator.pushReplacement(
                context,
                CupertinoPageRoute(builder: (context) => page),
              );
            },
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 10),
        child: Container(
          height: 70,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Icon(icon),
                  SizedBox(
                    width: 10,
                  ),
                  Text(title)
                ],
              ),
              Icon(Icons.arrow_forward_ios_outlined)
            ],
          ),
        ),
      ),
    );
  }
}
