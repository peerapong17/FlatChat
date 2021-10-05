import 'package:flutter/material.dart';
import 'package:login_ui/food-shop/food/screens/food_detail.dart';
import 'package:login_ui/food-shop/models/food_menu.dart';

Padding menuCard(FoodMenu foodMenu, BuildContext context) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 3),
    child: ListTile(
      leading: ClipRRect(
        borderRadius: BorderRadius.circular(7),
        child: Image(
          image: AssetImage(foodMenu.image),
          fit: BoxFit.cover,
          width: 85,
        ),
      ),
      title: Text(foodMenu.name),
      subtitle: Text(foodMenu.price),
      trailing: Icon(Icons.arrow_forward_ios_outlined),
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => FoodDetail(
              id: foodMenu.id,
              foodName: foodMenu.name,
              image: foodMenu.image,
              price: foodMenu.price,
            ),
          ),
        );
      },
    ),
  );
}
