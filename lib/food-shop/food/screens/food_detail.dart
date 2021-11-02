import 'package:flutter/material.dart';
import 'package:login_ui/food-shop/data/food_menu_list.dart';
import 'package:login_ui/food-shop/models/food_menu.dart';
import 'package:login_ui/food-shop/state/cart.dart';
import 'package:login_ui/utils/build_elevated_button.dart';
import 'package:login_ui/utils/build_icon.dart';
import 'package:login_ui/utils/build_icon_button.dart';
import 'package:provider/provider.dart';

class FoodDetail extends StatelessWidget {
  final FoodMenu foodMenu;

  FoodDetail(this.foodMenu);

  @override
  Widget build(BuildContext context) {
    print("refresh");
    return Scaffold(
      body: Column(
        children: [
          Stack(
            children: [
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(17),
                    bottomRight: Radius.circular(17),
                  ),
                ),
                height: 285,
                width: double.infinity,
                child: ClipRRect(
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(17),
                    bottomRight: Radius.circular(17),
                  ),
                  child: Image.asset(
                    foodMenu.image,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Positioned(
                top: 23,
                left: 12,
                child: InkWell(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  splashColor: Colors.black45,
                  child: Container(
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                        shape: BoxShape.circle, color: Colors.black12),
                    child: Icon(
                      Icons.arrow_back_ios_new_outlined,
                      size: 25,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              Positioned(
                bottom: 13,
                left: 13,
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  decoration: BoxDecoration(
                    color: Colors.black45,
                    borderRadius: BorderRadius.circular(7),
                  ),
                  child: Text(
                    foodMenu.name,
                    style: TextStyle(fontSize: 30, color: Colors.white),
                  ),
                ),
              ),
              Positioned(
                bottom: 13,
                right: 13,
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  decoration: BoxDecoration(
                    color: Colors.black45,
                    borderRadius: BorderRadius.circular(7),
                  ),
                  child: Text(
                    "\$${foodMenu.price}",
                    style: TextStyle(fontSize: 30, color: Colors.white),
                  ),
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(15),
            child: IntrinsicHeight(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  buildIcon(Icons.star, "3.9"),
                  VerticalDivider(
                    thickness: 2,
                  ),
                  buildIcon(Icons.fire_hydrant, "350 Cal"),
                  VerticalDivider(
                    thickness: 2,
                  ),
                  buildIcon(Icons.lock_clock, "30-45 min"),
                ],
              ),
            ),
          ),
          Expanded(
            child: ListView(
              padding: EdgeInsets.symmetric(horizontal: 13),
              scrollDirection: Axis.vertical,
              children: [
                Text(
                  "Detail",
                  style: Theme.of(context).textTheme.headline5,
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                    "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type"),
                SizedBox(
                  height: 10,
                ),
                Text(
                  "ทานคู่กับ",
                  style: Theme.of(context).textTheme.headline5,
                ),
                SizedBox(
                  height: 10,
                ),
                Container(
                  height: 200,
                  margin: EdgeInsets.symmetric(horizontal: 10),
                  child: ListView.builder(
                    itemCount: listFoodMenu.length,
                    scrollDirection: Axis.vertical,
                    padding: EdgeInsets.symmetric(vertical: 10),
                    itemBuilder: (ctx, index) {
                      FoodMenu foodMenu = listFoodMenu[index];
                      return ListTile(
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
                        onTap: () {},
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: Container(
        height: 50,
        width: double.infinity,
        padding: EdgeInsets.symmetric(horizontal: 17),
        margin: EdgeInsets.only(bottom: 13),
        child: Consumer<Cart>(
          builder: (context, cartSt, child) {
            return Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  child: Text(
                    "\$${int.parse(foodMenu.price) * cartSt.amount}",
                    style: Theme.of(context).textTheme.headline5,
                  ),
                ),
                Expanded(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      buildIconButton(Icons.add, () => cartSt.increaseAmount()),
                      SizedBox(
                        width: 7,
                      ),
                      Text(
                        cartSt.amount.toString(),
                        style: Theme.of(context).textTheme.headline5,
                      ),
                      SizedBox(
                        width: 7,
                      ),
                      buildIconButton(
                        Icons.remove,
                        () => cartSt.decreaseAmount(),
                      ),
                    ],
                  ),
                ),
                buildElevatedButton(
                  label: "Add To Card",
                  color: Colors.green.shade500,
                  height: 40,
                  fontSize: 19,
                  func: () => cartSt.addToCart(foodMenu),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
