import 'package:flutter/material.dart';
import 'package:login_ui/auth/screens/sign_in_screen.dart';
import 'package:login_ui/food-shop/map/shop_map.dart';
import 'package:login_ui/food-shop/history/history.dart';
import 'package:login_ui/food-shop/settings/user_setting.dart';
import 'package:login_ui/food-shop/home.dart';
import 'package:login_ui/food-shop/models/drawer.dart';

List<DrawerModel> drawerList = [
  DrawerModel(icon: Icons.home, title: "Home", page: Home(), isLoggedIn: false),
  DrawerModel(
      icon: Icons.history,
      title: "History",
      page: History(),
      isLoggedIn: false),
  DrawerModel(
      icon: Icons.map_outlined,
      title: "Map",
      page: ShopMap(),
      isLoggedIn: false),
  DrawerModel(
      icon: Icons.settings,
      title: "Setting",
      page: UserSetting(),
      isLoggedIn: false),
  DrawerModel(
      icon: Icons.logout,
      title: "Sign out",
      page: SignInScreen(),
      isLoggedIn: true),
];
