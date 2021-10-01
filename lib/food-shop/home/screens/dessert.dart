import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:login_ui/food-shop/data/dessert_menu.dart';
import 'package:login_ui/food-shop/models/food_menu.dart';
import 'package:login_ui/utils/show_alert_dialog.dart';

import 'food_detail.dart';

class Dessert extends StatelessWidget {
  final List<String> hotDessertList = [
    'assets/images/desserts/dessert.jpg',
    'assets/images/desserts/dessert3.jpg',
    'assets/images/desserts/dessert6.jpg'
  ];

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        var res = await showAlertDialog(context: context);
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
                items: hotDessertList.map(
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
                  itemCount: listDessertMenu.length,
                  scrollDirection: Axis.vertical,
                  itemBuilder: (ctx, index) {
                    FoodMenu dessertMenu = listDessertMenu[index];
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 3),
                      child: ListTile(
                        leading: ClipRRect(
                          borderRadius: BorderRadius.circular(7),
                          child: Image(
                            image: AssetImage(dessertMenu.image),
                            fit: BoxFit.cover,
                          ),
                        ),
                        title: Text(dessertMenu.name),
                        subtitle: Text(dessertMenu.price),
                        trailing: Icon(Icons.arrow_forward_ios_outlined),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => FoodDetail(
                                id: dessertMenu.id,
                                foodName: dessertMenu.name,
                                image: dessertMenu.image,
                                price: dessertMenu.price,
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
