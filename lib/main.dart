import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:login_ui/food-shop/home.dart';
import 'package:login_ui/food-shop/state/bill.dart';
import 'package:provider/provider.dart';
import 'food-shop/state/cart.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => Cart(),
        ),
        ChangeNotifierProvider(
          create: (_) => Bill(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          primaryIconTheme: IconThemeData(color: Colors.black),
          primarySwatch: Colors.pink,
          primaryColor: Colors.limeAccent.shade400,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: Home(),
      ),
    );
  }
}
