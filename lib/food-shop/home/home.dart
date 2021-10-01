

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:login_ui/food-shop/components/drawer_list_card.dart';
import 'package:login_ui/food-shop/data/drawer_list.dart';
import 'package:login_ui/food-shop/drawer/drawer-header/drawer_header.dart';
import 'package:login_ui/food-shop/home/screens/cart_detail.dart';
import 'package:login_ui/food-shop/home/screens/dessert.dart';
import 'package:login_ui/food-shop/home/screens/drink.dart';
import 'package:login_ui/food-shop/home/screens/food.dart';


class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int _currentIndex = 0;
  List<Widget> pageWidget = [Food(), Drink(), Dessert(), CartDetail()];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        leading: Builder(
          builder: (BuildContext context) {
            return IconButton(
              icon: const Icon(
                Icons.menu,
              ),
              onPressed: () {
                Scaffold.of(context).openDrawer();
              },
              tooltip: MaterialLocalizations.of(context).openAppDrawerTooltip,
            );
          },
        ),
        title: Text(
          'Food Shop',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 25,
          ),
        ),
        centerTitle: true,
      ),
      body: pageWidget[_currentIndex],
      drawer: Container(
        width: 250,
        child: Drawer(
          child: ListView(
            children: <Widget>[
              drawerHeader(),
              ...drawerList.map((e) {
                if (e.isLoggedIn != null) {
                  return DrawerList(
                    icon: e.icon,
                    title: e.title,
                    page: e.page,
                    isLoggedOut: true,
                  );
                }
                return DrawerList(
                  icon: e.icon,
                  title: e.title,
                  page: e.page,
                );
              })
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
        items: [
          BottomNavigationBarItem(
              icon: Icon(Icons.food_bank_rounded), label: 'Food'),
          BottomNavigationBarItem(
              icon: Icon(Icons.fastfood_outlined), label: 'Dessert'),
          BottomNavigationBarItem(
              icon: Icon(Icons.local_drink_outlined), label: 'Drink'),
          BottomNavigationBarItem(
              icon: Icon(Icons.shopping_cart), label: 'Cart'),
        ],
      ),
    );
  }
}
