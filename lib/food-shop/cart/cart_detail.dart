import 'package:flutter/material.dart';
import 'package:login_ui/food-shop/models/food_order.dart';
import 'package:login_ui/food-shop/state/cart.dart';
import 'package:provider/provider.dart';

class CartDetail extends StatefulWidget {
  const CartDetail({Key? key}) : super(key: key);

  @override
  _CartDetailState createState() => _CartDetailState();
}

class _CartDetailState extends State<CartDetail> {
  @override
  Widget build(BuildContext context) {
    return Consumer<Cart>(
      builder: (context, cart, child) => Scaffold(
        body: Container(
          width: double.infinity,
          height: double.infinity,
          child: ListView.builder(
            itemCount: cart.cart.length,
            scrollDirection: Axis.vertical,
            itemBuilder: (context, index) {
              FoodOrder foodOrdered = cart.cart[index];
              return ListTile(
                leading: Image(
                  image: AssetImage(foodOrdered.image),
                ),
                title: Text(foodOrdered.name),
                subtitle: Text(foodOrdered.price),
                trailing: Text(foodOrdered.amount.toString()),
              );
            },
          ),
        ),
      ),
    );
  }
}
