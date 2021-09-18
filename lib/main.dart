import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:login_ui/food-shop/main_route.dart';

import 'food-shop/food/food_detail.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primaryIconTheme: IconThemeData(color: Colors.black),
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      // home: FoodDetail(foodName: "text", image: "assets/images/hamberger.jpg",price: "39",));
      home: MainRoute(),
    );
  }
}
