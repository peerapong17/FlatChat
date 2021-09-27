import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:login_ui/food-shop/main_route.dart';
import 'package:login_ui/food-shop/state/cart.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Provider<Cart>(
      create: (context) => Cart(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          primaryIconTheme: IconThemeData(color: Colors.black),
          primarySwatch: Colors.pink,
          primaryColor: Colors.limeAccent.shade400,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: MainRoute(),
      ),
    );
  }
}
