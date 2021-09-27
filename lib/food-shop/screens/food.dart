import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:login_ui/food-shop/data/food_menu_list.dart';
import 'package:login_ui/food-shop/models/food_menu.dart';
import 'package:login_ui/food-shop/state/cart.dart';
import 'package:provider/provider.dart';

import 'food_detail.dart';

class Food extends StatefulWidget {
  @override
  _FoodState createState() => _FoodState();
}

class _FoodState extends State<Food> {
  int currentPage = 0;
  List<String> hotFoodList = [
    'assets/images/ต้มยำกุ้ง.jpg',
    'assets/images/ข้าวผัด.jpg',
    'assets/images/ผัดไทย.jpg'
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text('Hot menu',
              style: TextStyle(
                fontFamily: 'Chewy',
                fontSize: 40,
                color: Colors.red,
              )),
          CarouselSlider(
            options: CarouselOptions(
                height: 200.0, autoPlay: true, aspectRatio: 16 / 9),
            items: hotFoodList.map(
              (i) {
                return Builder(
                  builder: (BuildContext context) {
                    return Image.asset(
                      i,
                      fit: BoxFit.cover,
                    );
                  },
                );
              },
            ).toList(),
          ),
          SizedBox(
            height: 17,
          ),
          Expanded(
            child: ListView.builder(
              itemCount: listFoodMenu.length,
              scrollDirection: Axis.vertical,
              itemBuilder: (ctx, index) {
                FoodMenu foodMenu = listFoodMenu[index];
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 3),
                  child: ListTile(
                    leading: ClipRRect(
                      borderRadius: BorderRadius.circular(7),
                      child: Image(
                        image: AssetImage(foodMenu.image),
                        fit: BoxFit.cover,
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
              },
            ),
          ),
        ],
      ),
    );
  }
}
