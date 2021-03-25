import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:login_ui/Page/drawer/drawer_list.dart';
import 'bottom_bar/Dessert.dart';
import 'bottom_bar/Drink.dart';

import 'navbar/map_bar.dart';
import 'login_screen.dart';
import 'navbar/history_bar.dart';
import 'navbar/profile_bar.dart';
import 'navbar/setting_bar.dart';
import 'Food.dart';

class SecondRoute extends StatefulWidget {
  @override
  _SecondRouteState createState() => _SecondRouteState();
}

class _SecondRouteState extends State<SecondRoute> {
  var _auth = FirebaseAuth.instance;
  int _currentIndex = 0;
  List<Widget> pageWidget = [
    Food(),
    Drink(),
    Dessert(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text(
          'Food Menu',
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Colors.black,
            fontSize: 25,
          ),
        ),
        actions: [
          IconButton(
              icon: Icon(Icons.add_circle_outline_outlined),
              color: Colors.black,
              onPressed: () {})
        ],
      ),
      body: pageWidget[_currentIndex],
      drawer: Container(
        width: 250,
        child: Drawer(
          child: ListView(
            children: <Widget>[
              DrawerHeader(
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
              ),
              NavBarList(Icons.account_circle_outlined, "Profile", () {
                Navigator.push(
                  context,
                  CupertinoPageRoute(builder: (context) => Profile()),
                );
              }, Icons.arrow_forward_ios_outlined),
              NavBarList(Icons.history, "History", () {
                Navigator.push(
                  context,
                  CupertinoPageRoute(builder: (context) => History()),
                );
              }, Icons.arrow_forward_ios_outlined),
              NavBarList(Icons.map_outlined, "Map", () {
                Navigator.push(
                  context,
                  CupertinoPageRoute(builder: (context) => Map()),
                );
              }, Icons.arrow_forward_ios_outlined),
              NavBarList(Icons.settings, "Setting", () {
                Navigator.push(
                  context,
                  CupertinoPageRoute(builder: (context) => Setting()),
                );
              }, Icons.arrow_forward_ios_outlined),
              NavBarList(Icons.logout, "Sign out", () {
                showDialog<void>(
                  context: context,
                  barrierDismissible: true, // user must tap button!
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: Text(
                        'Would you like to Sign out?',
                        style: TextStyle(fontSize: 23),
                      ),
                      content: Text(
                          'Thank you for using our service, please come back again.'),
                      actions: <Widget>[
                        TextButton(
                          child: Text('OK'),
                          onPressed: () {
                            _auth.signOut();
                            Navigator.push(
                              context,
                              CupertinoPageRoute(
                                builder: (context) => SignInScreen(),
                              ),
                            );
                          },
                        ),
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
              }, Icons.arrow_forward_ios_outlined),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        iconSize: 25,
        selectedFontSize: 15,
        unselectedItemColor: Colors.grey[500],
        selectedItemColor: Colors.black,
        type: BottomNavigationBarType.shifting,
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(
              Icons.food_bank_rounded,
            ),
            label: 'Food',
          ),
          BottomNavigationBarItem(
              icon: Icon(
                Icons.fastfood_outlined,
              ),
              label: 'Dessert'),
          BottomNavigationBarItem(
              icon: Icon(
                Icons.local_drink_outlined,
              ),
              label: 'Drink'),
        ],
      ),
    );
  }
}
