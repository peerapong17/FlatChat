import 'package:flutter/material.dart';

// ignore: must_be_immutable
class NavBarList extends StatelessWidget {
  String text;
  IconData icon;
  IconData iconRight;
  Function onTap;

  NavBarList(this.icon, this.text, this.onTap, this.iconRight);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
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
                  Text(text)
                ],
              ),
              Icon(iconRight)
            ],
          ),
        ),
      ),
    );
  }
}
