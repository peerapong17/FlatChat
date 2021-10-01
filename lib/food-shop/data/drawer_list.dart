import 'package:flutter/material.dart';
import 'package:login_ui/auth/login/login_screen.dart';
import 'package:login_ui/food-shop/map/shop_map.dart';
import 'package:login_ui/food-shop/history/history.dart';
import 'package:login_ui/food-shop/settings/user_setting.dart';
import 'package:login_ui/food-shop/home/home.dart';
import 'package:login_ui/food-shop/models/drawer.dart';

List<DrawerModel> drawerList = [
  DrawerModel(
      icon: Icons.home,
      title: "Home",
      page: Home()),
  DrawerModel(icon: Icons.history, title: "History", page: History()),
  DrawerModel(icon: Icons.map_outlined, title: "Map", page: ShopMap()),
  DrawerModel(icon: Icons.settings, title: "Setting", page: UserSetting()),
  DrawerModel(
      icon: Icons.logout,
      title: "Sign out",
      page: SignInScreen(),
      isLoggedIn: true),
];
