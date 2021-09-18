import 'package:flutter/material.dart';
import 'package:login_ui/food-shop/models/food_order.dart';
import 'package:login_ui/food-shop/state/cart.dart';

class FoodDetail extends StatefulWidget {
  final String foodName;
  final String image;
  final String price;
  final Cart cart;

  FoodDetail(
      {required this.foodName,
      required this.image,
      required this.price,
      required this.cart});

  @override
  State<FoodDetail> createState() => _FoodDetailState();
}

class _FoodDetailState extends State<FoodDetail> {
  @override
  Widget build(BuildContext context) {
    List<FoodOrder> cart = widget.cart.cart;
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        leading: IconButton(
            icon: Icon(Icons.arrow_back_ios_outlined),
            onPressed: () {
              Navigator.pop(context);
            }),
        title: Text(
          widget.foodName,
        ),
        actions: [
          IconButton(
            icon: Icon(
              Icons.add_circle_outline_outlined,
            ),
            onPressed: () {
              Iterable<FoodOrder> foundMenu =
                  cart.where((element) => element.name == widget.foodName);
              if (foundMenu.isNotEmpty) {
                for (int i = 0; i < cart.length; i++) {
                  if (cart[i].name == widget.foodName) {
                    cart[i].amount++;
                  }
                }
              } else {
                cart.add(
                  FoodOrder(
                      image: widget.image,
                      name: widget.foodName,
                      price: widget.price,
                      amount: 1),
                );
              }
            },
          ),
        ],
      ),
      body: Column(
        children: [
          Center(
            child: Container(
              margin: EdgeInsets.symmetric(vertical: 20),
              padding: EdgeInsets.all(5),
              height: 285,
              width: 285,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Color(0xffffa1cb),
              ),
              child: Container(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  image: DecorationImage(
                      image: AssetImage(widget.image), fit: BoxFit.fill),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
