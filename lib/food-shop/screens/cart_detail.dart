import 'package:flutter/material.dart';
import 'package:login_ui/food-shop/state/cart.dart';
import 'package:login_ui/utils/build_elevated_button.dart';
import 'package:login_ui/utils/build_icon_button.dart';
import 'package:login_ui/utils/show_toast.dart';
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
                          children: cart.cart.map(
                            (order) {
                              var index = cart.cart.indexOf(order);
                              return Dismissible(
                                key: UniqueKey(),
                                onDismissed: (direction) {
                                  setState(() {
                                    cart.cart.removeAt(index);
                                  });
                                },
                                background: Container(
                                  padding: EdgeInsets.only(left: 20),
                                  alignment: Alignment.centerLeft,
                                  child: Icon(Icons.delete),
                                  color: Colors.red,
                                ),
                                child: ListTile(
                                  onTap: () {},
                                  leading: Image(
                                    image: AssetImage(order.image),
                                  ),
                                  title: Text(order.name),
                                  subtitle: Text(order.price),
                                  trailing: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      buildIconButton(
                                        Icons.add,
                                        () {
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
                                      SizedBox(
                                        width: 7,
                                      ),
                                      Text(
                                        order.amount.toString(),
                                        style: Theme.of(context)
                                            .textTheme
                                            .headline5,
                                      ),
                                      SizedBox(
                                        width: 7,
                                      ),
                                      buildIconButton(
                                        Icons.remove,
                                        () {
                                          for (var i = 0;
                                              i < cart.cart.length;
                                              i++) {
                                            if (order.id == cart.cart[i].id) {
                                              if (cart.cart[i].amount > 0) {
                                                cart.cart[i].amount--;
                                              } else {
                                                cart.cart.removeAt(index);
                                              }
                                            }
                                          }
                                          setState(() {});
                                        },
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            },
                          ).toList(),
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
                        child: buildElevatedButton(
                          "CheckOut",
                          Colors.green.shade500,
                          () {
                            cart.cart = [];
                            total = 0;
                            setState(() {});
                            showToast("Order success", Colors.green);
                          },
                        ),
                      ),
                    ],
                  ),
          ),
        );
      },
    );
  }
}
