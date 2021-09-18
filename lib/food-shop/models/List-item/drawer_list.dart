import 'package:flutter/material.dart';
import 'package:login_ui/auth/login/login_screen.dart';
import 'package:login_ui/food-shop/drawer/drawer-list/shop_map.dart';
import 'package:login_ui/food-shop/drawer/drawer-list/user_history.dart';
import 'package:login_ui/food-shop/drawer/drawer-list/user_profile.dart';
import 'package:login_ui/food-shop/drawer/drawer-list/user_setting.dart';
import '../drawer.dart';
import 'package:login_ui/food-shop/models/drawer.dart';

List<DrawerModel> drawerList = [
  DrawerModel(
      icon: Icons.account_circle_outlined,
      title: "Profile",
      page: UserProfile()),
  DrawerModel(icon: Icons.history, title: "History", page: UserHistory()),
  DrawerModel(icon: Icons.map_outlined, title: "Map", page: ShopMap()),
  DrawerModel(icon: Icons.settings, title: "Setting", page: UserSetting()),
  DrawerModel(
      icon: Icons.logout,
      title: "Sign out",
      page: SignInScreen(),
      isLoggedIn: true),
];
