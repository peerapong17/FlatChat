import 'package:flutter/material.dart';
import 'package:login_ui/food-shop/state/cart.dart';
import 'package:login_ui/utils/show_toast.dart';
import 'package:provider/provider.dart';
import 'package:fluttertoast/fluttertoast.dart';

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
            child: cart.cart.length == 0
                ? Center(
                    child: Text(
                      "No order yet, Let's add some!",
                      style: Theme.of(context).textTheme.headline5,
                    ),
                  )
                : Column(
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
                                      Container(
                                        padding: EdgeInsets.all(8),
                                        color: Colors.white70,
                                        child: IconButton(
                                          icon: Icon(Icons.add),
                                          onPressed: () {
                                            for (var i = 0;
                                                i < cart.cart.length;
                                                i++) {
                                              if (order.id == cart.cart[i].id) {
                                                cart.cart[i].amount++;
                                              }
                                            }
                                            setState(() {});
                                          },
                                        ),
                                      ),
                                      Text(
                                        order.amount.toString(),
                                        style: TextStyle(fontSize: 27),
                                      ),
                                      Container(
                                        padding: EdgeInsets.all(8),
                                        color: Colors.white70,
                                        child: IconButton(
                                          icon: Icon(Icons.remove),
                                          onPressed: () {
                                            for (var i = 0;
                                                i < cart.cart.length;
                                                i++) {
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
                                        ),
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
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Total:",
                                style: TextStyle(
                                    fontSize: 35, fontWeight: FontWeight.w700),
                              ),
                              Text(
                                "$total",
                                style: TextStyle(
                                    fontSize: 35, fontWeight: FontWeight.w700),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Container(
                        height: 50,
                        margin: EdgeInsets.all(10),
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            primary: Colors.green.shade500,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(23),
                            ),
                          ),
                          onPressed: () {
                            cart.cart = [];
                            total = 0;
                            setState(() {});
                            showToast("Order success", Colors.green);
                          },
                          child: Text(
                            "Checkout",
                            style: TextStyle(fontSize: 23),
                          ),
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
