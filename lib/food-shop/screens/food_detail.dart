import 'package:flutter/material.dart';
import 'package:login_ui/food-shop/data/food_menu_list.dart';
import 'package:login_ui/food-shop/models/food_menu.dart';
import 'package:login_ui/food-shop/models/food_order.dart';
import 'package:login_ui/food-shop/state/cart.dart';
import 'package:login_ui/utils/build_elevated_button.dart';
import 'package:login_ui/utils/build_icon.dart';
import 'package:login_ui/utils/build_icon_button.dart';
import 'package:provider/provider.dart';

class FoodDetail extends StatefulWidget {
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

  @override
  State<FoodDetail> createState() => _FoodDetailState();
}

class _FoodDetailState extends State<FoodDetail> {
  int price = 0;
  int amount = 1;

  @override
  void initState() {
    price = int.parse(widget.price);
  }

  @override
  Widget build(BuildContext context) {
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
                      widget.image,
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
                      widget.foodName,
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
                      "\$${widget.price}",
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
                    child: Row(
                      children: [
                        Container(
                          child: Text(
                            "\$${price * amount}",
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
                                  amount += 1;
                                  setState(() {});
                                },
                              ),
                              SizedBox(
                                width: 7,
                              ),
                              Text(
                                amount.toString(),
                                style: Theme.of(context).textTheme.headline5,
                              ),
                              SizedBox(
                                width: 7,
                              ),
                              buildIconButton(
                                Icons.remove,
                                () {
                                  if (amount > 1) {
                                    amount -= 1;
                                  } else {
                                    amount = 1;
                                  }
                                  setState(() {});
                                },
                              ),
                            ],
                          ),
                        ),
                        Consumer<Cart>(
                          builder: (context, cart, child) {
                            var shopingCart = cart.cart;
                            return buildElevatedButton(
                              "Add To Card",
                              Colors.green.shade500,
                              () async {
                                bool orderExist = shopingCart.any((element) =>
                                    element.name == widget.foodName);
                                if (orderExist) {
                                  for (int i = 0; i < shopingCart.length; i++) {
                                    if (shopingCart[i].name ==
                                        widget.foodName) {
                                      shopingCart[i].amount += amount;
                                    }
                                  }
                                } else {
                                  shopingCart.add(
                                    FoodOrder(
                                        id: widget.id,
                                        image: widget.image,
                                        name: widget.foodName,
                                        price: widget.price,
                                        amount: amount),
                                  );
                                }
                              },
                            );
                          },
                        ),
                      ],
                    ),
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
