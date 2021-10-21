import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:login_ui/food-shop/components/drawer_list_card.dart';
import 'package:login_ui/food-shop/data/drawer_list.dart';
import 'package:login_ui/food-shop/drawer/drawer-header/drawer_header.dart';
import 'package:login_ui/food-shop/models/food_order.dart';
import 'package:login_ui/food-shop/state/cart_provider.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'food/screens/cart_detail.dart';
import 'food/screens/dessert.dart';
import 'food/screens/drink.dart';
import 'food/screens/food.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> with WidgetsBindingObserver {
  int _currentIndex = 0;
  List<Widget> pageScreens = [Food(), Drink(), Dessert(), CartDetail()];

  Future<void> _storeUserCart() async {
    List<String> cartEncoded = [];
    CartProvider cartProvider =
        Provider.of<CartProvider>(context, listen: false);
    for (var item in cartProvider.userCart) {
      Map<String, dynamic> cartItem = FoodOrder(
              id: item.id,
              image: item.image,
              name: item.name,
              price: item.price,
              amount: item.amount)
          .toJson();

      String encodedData = jsonEncode(cartItem);

      cartEncoded.add(encodedData);
    }
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setStringList('user_cart', cartEncoded);
  }

  Future<void> _loadUserCart() async {
    List<FoodOrder> userCart = [];
    CartProvider cartProvider =
        Provider.of<CartProvider>(context, listen: false);
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> userCartFromPref = prefs.getStringList('user_cart')!;

    if (userCartFromPref.length != 0) {
      for (var item in userCartFromPref) {
        Map<String, dynamic> decodedData = json.decode(item);

        userCart.add(FoodOrder.fromJson(decodedData));
      }
      cartProvider.userCart = userCart;
    }
  }

  @override
  void initState() {
    super.initState();
    _loadUserCart();
    WidgetsBinding.instance!.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance!.removeObserver(this);
    super.dispose();
  }

  @override
  Future<void> didChangeAppLifecycleState(AppLifecycleState state) async {
    switch (state) {
      case AppLifecycleState.paused:
        print('paused');
        break;
      case AppLifecycleState.inactive:
        _storeUserCart();
        print('inactive');
        break;
      case AppLifecycleState.resumed:
        print('resumed');
        break;
      case AppLifecycleState.detached:
        print('detached');
        break;
    }
  }

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
      body: pageScreens[_currentIndex],
      drawer: Container(
        width: 250,
        child: Drawer(
          child: ListView(
            children: <Widget>[
              drawerHeader(),
              ...drawerList.map(
                (e) {
                  return DrawerList(
                    icon: e.icon,
                    title: e.title,
                    page: e.page,
                    isLoggedIn: e.isLoggedIn,
                  );
                },
              ),
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
