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
  int total = 0;

  @override
  Widget build(BuildContext context) {
    return Consumer<Cart>(
      builder: (context, cart, child) {
        total = 0;
        for (var i = 0; i < cart.cart.length; i++) {
          total += cart.cart[i].amount * int.parse(cart.cart[i].price);
        }
        return Scaffold(
          body: Container(
            width: double.infinity,
            height: double.infinity,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Container(
                  height: MediaQuery.of(context).size.height * 0.6,
                  child: ListView(
                    scrollDirection: Axis.vertical,
                    children: [
                      ...cart.cart.map(
                        (order) {
                          return ListTile(
                            onTap: () {},
                            leading: Image(
                              image: AssetImage(order.image),
                            ),
                            title: Text(order.name),
                            subtitle: Text(order.price),
                            trailing: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                IconButton(
                                  onPressed: () {
                                    for (var i = 0; i < cart.cart.length; i++) {
                                      if (order.id == cart.cart[i].id) {
                                        cart.cart[i].amount++;
                                      }
                                    }
                                    setState(() {});
                                  },
                                  icon: Icon(Icons.add),
                                ),
                                Text(
                                  order.amount.toString(),
                                  style: TextStyle(fontSize: 27),
                                ),
                                IconButton(
                                  onPressed: () {
                                    for (var i = 0; i < cart.cart.length; i++) {
                                      if (order.id == cart.cart[i].id) {
                                        if (cart.cart[i].amount > 0) {
                                          cart.cart[i].amount--;
                                        } else {
                                          cart.cart[i].amount = 0;
                                        }
                                      }
                                    }
                                    setState(() {});
                                  },
                                  icon: Icon(Icons.remove),
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Container(
                    child: Text(
                      "Total: $total",
                      style: TextStyle(fontSize: 40),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: Row(
                    children: [
                      Expanded(
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              primary: Colors.green.shade400),
                          onPressed: () {
                            cart.cart = [];
                            total = 0;
                            setState(() {});
                          },
                          child: Text("Order"),
                        ),
                      ),
                      Expanded(
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              primary: Colors.red.shade400),
                          onPressed: () {
                            cart.cart = [];
                            total = 0;
                            setState(() {});
                          },
                          child: Text("Clear"),
                        ),
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
