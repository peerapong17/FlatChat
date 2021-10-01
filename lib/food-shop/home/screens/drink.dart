import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:login_ui/food-shop/data/drink_menu.dart';
import 'package:login_ui/food-shop/models/food_menu.dart';
import 'package:login_ui/utils/show_alert_dialog.dart';

import 'food_detail.dart';

class Drink extends StatelessWidget {
  final List<String> hotDrinkList = [
    'assets/images/drinks/drink.jpg',
    'assets/images/drinks/drink3.jpg',
    'assets/images/drinks/drink6.jpg'
  ];

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        var res = await showAlertDialog(
            context: context);
        return res;
      },
      child: Scaffold(
        body: Container(
          width: double.infinity,
          height: double.infinity,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                'Hot menu',
                style: TextStyle(
                  fontFamily: 'Chewy',
                  fontSize: 40,
                  color: Colors.red,
                ),
              ),
              CarouselSlider(
                options: CarouselOptions(
                    height: 200.0, autoPlay: true, aspectRatio: 16 / 9),
                items: hotDrinkList.map(
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
                  itemCount: listDrinkMenu.length,
                  scrollDirection: Axis.vertical,
                  itemBuilder: (ctx, index) {
                    FoodMenu drinkMenu = listDrinkMenu[index];
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 3),
                      child: ListTile(
                        leading: ClipRRect(
                          borderRadius: BorderRadius.circular(7),
                          child: Image(
                            image: AssetImage(drinkMenu.image),
                            fit: BoxFit.cover,
                          ),
                        ),
                        title: Text(drinkMenu.name),
                        subtitle: Text(drinkMenu.price),
                        trailing: Icon(Icons.arrow_forward_ios_outlined),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => FoodDetail(
                                id: drinkMenu.id,
                                foodName: drinkMenu.name,
                                image: drinkMenu.image,
                                price: drinkMenu.price,
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
        ),
      ),
    );
  }
}
