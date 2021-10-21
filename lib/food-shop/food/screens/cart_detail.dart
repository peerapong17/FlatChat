import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:login_ui/food-shop/check-out/check_out.dart';
import 'package:login_ui/food-shop/models/bill.dart';
import 'package:login_ui/food-shop/models/food_order.dart';
import 'package:login_ui/services/bill_service.dart';
import 'package:login_ui/utils/build_detail.dart';
import 'package:login_ui/utils/show_alert_dialog.dart';
import 'package:provider/provider.dart';
import 'package:login_ui/utils/show_toast.dart';
import 'package:login_ui/utils/build_icon_button.dart';
import 'package:login_ui/food-shop/state/bill_provider.dart';
import 'package:login_ui/food-shop/state/cart_provider.dart';
import 'package:login_ui/utils/build_elevated_button.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uuid/uuid.dart';

class CartDetail extends StatefulWidget {
  const CartDetail({Key? key}) : super(key: key);

  @override
  _CartDetailState createState() => _CartDetailState();
}

class _CartDetailState extends State<CartDetail> {
  BillService billService = new BillService();
  FirebaseAuth auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return Consumer<CartProvider>(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "No order yet, Let's add some!",
            style: Theme.of(context).textTheme.headline5,
          ),
        ],
      ),
      builder: (context, cart, child) {
        return WillPopScope(
          onWillPop: () async {
            var res = await showAlertDialog(context: context);
            return res;
          },
          child: Scaffold(
            body: Container(
              width: double.infinity,
              height: double.infinity,
              child: cart.userCart.length == 0
                  ? child
                  : Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Container(
                          height: MediaQuery.of(context).size.height * 0.6,
                          child: ListView(
                            scrollDirection: Axis.vertical,
                            children: cart.userCart.map(
                              (order) {
                                var index = cart.userCart.indexOf(order);
                                return Dismissible(
                                  key: UniqueKey(),
                                  onDismissed: (direction) {
                                    setState(() {
                                      cart.userCart.removeAt(index);

                                      //or
                                      // cart.userCart.remove(order);
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
                                    subtitle: Text("${order.price} \$"),
                                    trailing: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        buildIconButton(
                                          Icons.add,
                                          () {
                                            for (var i = 0;
                                                i < cart.userCart.length;
                                                i++) {
                                              if (order.id ==
                                                  cart.userCart[i].id) {
                                                cart.userCart[i].amount++;
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
                                                i < cart.userCart.length;
                                                i++) {
                                              if (order.id ==
                                                  cart.userCart[i].id) {
                                                if (cart.userCart[i].amount >
                                                    0) {
                                                  cart.userCart[i].amount--;
                                                } else {
                                                  cart.userCart.removeAt(index);
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
                        buildDetail("Total:", "${cart.calcTotal()}", 35),
                        IntrinsicHeight(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              children: [
                                buildElevatedButton(
                                  label: "CheckOut",
                                  color: Colors.green.shade500,
                                  height: 50,
                                  fontSize: 27,
                                  func: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => CheckOut(
                                          userCart: cart.userCart,
                                          total: cart.total,
                                        ),
                                      ),
                                    ).then((value) => cart.userCart = []);
                                  },
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
            ),
          ),
        );
      },
    );
  }
}
