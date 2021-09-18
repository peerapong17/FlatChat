import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:login_ui/food-shop/components/delimiters.dart';
import 'package:login_ui/food-shop/components/food_menu_card.dart';
import 'package:login_ui/food-shop/models/List-item/hot_food_list.dart';
import 'package:login_ui/food-shop/models/List-item/food_menu_list.dart';
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

  @override
  Widget build(BuildContext context) {
    return Consumer<Cart>(
      builder: (context, cart, child) =>  Container(
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
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(60),
              ),
              height: 200,
              width: double.infinity,
              child: PageView.builder(
                onPageChanged: (index) {
                  setState(() {
                    currentPage = index;
                  });
                },
                itemCount: hotFoodList.length,
                itemBuilder: (context, index) {
                  return Image.asset(
                    hotFoodList[index]['image']!,
                    fit: BoxFit.contain,
                  );
                },
              ),
            ),
            Container(
              width: double.infinity,
              margin: EdgeInsets.only(top: 7),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(
                  hotFoodList.length,
                  (index) {
                    return delimiters(index: index, currentPage: currentPage);
                  },
                ),
              ),
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
                      leading: Image(
                        image: AssetImage(foodMenu.image),
                      ),
                      title: Text(foodMenu.name),
                      subtitle: Text(foodMenu.price),
                      trailing: Icon(Icons.arrow_forward_ios_outlined),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => FoodDetail(
                              foodName: foodMenu.name,
                              image: foodMenu.image,
                              price: foodMenu.price,
                              cart: cart
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
    );
  }
}
