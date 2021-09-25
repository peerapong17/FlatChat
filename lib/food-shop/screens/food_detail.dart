import 'package:flutter/material.dart';
import 'package:login_ui/food-shop/data/food_menu_list.dart';
import 'package:login_ui/food-shop/models/food_menu.dart';
import 'package:login_ui/food-shop/models/food_order.dart';
import 'package:login_ui/food-shop/state/cart.dart';

class FoodDetail extends StatefulWidget {
  final String id;
  final String foodName;
  final String image;
  final String price;
  final Cart cart;

  FoodDetail(
      {required this.id,
      required this.foodName,
      required this.image,
      required this.price,
      required this.cart});

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
    List<FoodOrder> cart = widget.cart.cart;
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
                              GestureDetector(
                                onTap: () {
                                  amount += 1;
                                  setState(() {});
                                },
                                child: Container(
                                  padding: EdgeInsets.all(3),
                                  decoration: BoxDecoration(
                                    color: Colors.black54,
                                    borderRadius: BorderRadius.circular(13),
                                  ),
                                  child: Icon(
                                    Icons.add,
                                    size: 30,
                                    color: Colors.white,
                                  ),
                                ),
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
                              GestureDetector(
                                onTap: () {
                                  if (amount > 1) {
                                    amount -= 1;
                                  } else {
                                    amount = 1;
                                  }
                                  setState(() {});
                                },
                                child: Container(
                                  padding: EdgeInsets.all(3),
                                  decoration: BoxDecoration(
                                    color: Colors.black54,
                                    borderRadius: BorderRadius.circular(13),
                                  ),
                                  child: Icon(
                                    Icons.remove,
                                    size: 30,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Expanded(
                          child: ElevatedButton(
                            child: Text("Add To Card"),
                            style: ElevatedButton.styleFrom(
                              primary: Colors.green.shade500,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(23),
                              ),
                            ),
                            onPressed: () async {
                              bool foundMenu = cart.any(
                                  (element) => element.name == widget.foodName);
                              if (foundMenu) {
                                for (int i = 0; i < cart.length; i++) {
                                  if (cart[i].name == widget.foodName) {
                                    cart[i].amount += amount;
                                  }
                                }
                              } else {
                                cart.add(
                                  FoodOrder(
                                      id: widget.id,
                                      image: widget.image,
                                      name: widget.foodName,
                                      price: widget.price,
                                      amount: amount),
                                );
                              }
                            },
                          ),
                        )
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

  Row buildIcon(IconData icon, String text) {
    return Row(
      children: [
        Icon(icon),
        SizedBox(
          width: 3,
        ),
        Text(text),
      ],
    );
  }
}
