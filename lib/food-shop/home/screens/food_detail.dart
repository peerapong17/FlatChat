import 'package:flutter/material.dart';
import 'package:login_ui/food-shop/data/food_menu_list.dart';
import 'package:login_ui/food-shop/models/food_menu.dart';
import 'package:login_ui/food-shop/models/food_order.dart';
import 'package:login_ui/food-shop/state/cart_provider.dart';
import 'package:login_ui/utils/build_elevated_button.dart';
import 'package:login_ui/utils/build_icon.dart';
import 'package:login_ui/utils/build_icon_button.dart';
import 'package:provider/provider.dart';

class FoodDetail extends StatelessWidget {
  final String id;
  final String foodName;
  final String image;
  final String price;

  FoodDetail({
    required this.id,
    required this.foodName,
    required this.image,
    required this.price,
  });

  int amount = 1;

  void dispose() {}

  @override
  Widget build(BuildContext context) {
    print("refresh");
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
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
                      image,
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
                      foodName,
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
                      "\$$price",
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
            Container(
              margin: EdgeInsets.symmetric(horizontal: 23),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Detail",
                    style: Theme.of(context).textTheme.headline5,
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Text(
                      "dlsapoldaspdlsadpasldapsd,sapdlaspdlsaodwq,dpwqdwq[d,.qp.wq[pd.[pqfolewpfewifjewufewhfw"),
                  SizedBox(
                    height: 15,
                  ),
                  Text(
                    "ทานคู่กับ",
                    style: Theme.of(context).textTheme.headline5,
                  ),
                  Container(
                    width: double.infinity,
                    height: 150,
                    child: ListView.builder(
                      itemCount: listFoodMenu.length,
                      scrollDirection: Axis.vertical,
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
                  Container(
                    width: double.infinity,
                    height: 70,
                    decoration: BoxDecoration(
                        border: Border(
                            top: BorderSide(color: Colors.grey, width: 1))),
                    child:
                        Consumer<CartProvider>(builder: (context, cartProvider, child) {
                      return Row(
                        children: [
                          Container(
                            child: Text(
                              "\$${int.parse(price) * cartProvider.amount}",
                              style: Theme.of(context).textTheme.headline5,
                            ),
                          ),
                          Expanded(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                buildIconButton(
                                  Icons.add,
                                  () {
                                    cartProvider.amount += 1;
                                  },
                                ),
                                SizedBox(
                                  width: 7,
                                ),
                                Text(
                                  cartProvider.amount.toString(),
                                  style: Theme.of(context).textTheme.headline5,
                                ),
                                SizedBox(
                                  width: 7,
                                ),
                                buildIconButton(
                                  Icons.remove,
                                  () {
                                    if (cartProvider.amount > 1) {
                                      cartProvider.amount -= 1;
                                    } else {
                                      cartProvider.amount = 1;
                                    }
                                  },
                                ),
                              ],
                            ),
                          ),
                          buildElevatedButton(
                            "Add To Card",
                            Colors.green.shade500,
                            40,
                            19,
                            () async {
                              bool orderExist = cartProvider.cart
                                  .any((element) => element.name == foodName);
                              if (orderExist) {
                                for (int i = 0;
                                    i < cartProvider.cart.length;
                                    i++) {
                                  if (cartProvider.cart[i].name == foodName) {
                                    cartProvider.cart[i].amount += cartProvider.amount;
                                  }
                                }
                              } else {
                                cartProvider.cart.add(
                                  FoodOrder(
                                      id: id,
                                      image: image,
                                      name: foodName,
                                      price: price,
                                      amount: cartProvider.amount),
                                );
                              }
                            },
                          ),
                        ],
                      );
                    }),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
