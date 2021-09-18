import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

DrawerHeader drawerHeader() {
  return DrawerHeader(
    child: Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Text(
            'Mr.Peerapong',
            textAlign: TextAlign.center,
          ),
          Container(
            height: 100,
            width: 100,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.pink,
            ),
            child: Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                image: DecorationImage(
                  image: AssetImage('assets/images/messi.jpg'),
                  fit: BoxFit.fill,
                ),
              ),
            ),
          )
        ],
      ),
    ),
  );
}
