import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:login_ui/food-shop/models/bill.dart';
import 'package:login_ui/food-shop/state/bill_provider.dart';
import 'package:login_ui/food-shop/state/cart_provider.dart';
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
  @override
  Widget build(BuildContext context) {
    DateTime now = DateTime.now();
    String formattedDate = DateFormat('yyyy-MM-dd – kk:mm').format(now);
    return Consumer<CartProvider>(
      builder: (context, cart, child) {
        return Scaffold(
          body: Container(
            width: double.infinity,
            height: double.infinity,
            child: cart.cart.length == 0
                ? Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "No order yet, Let's add some!",
                        style: Theme.of(context).textTheme.headline5,
                      ),
                    ],
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
                                "${cart.calcTotal()}",
                                style: TextStyle(
                                    fontSize: 35, fontWeight: FontWeight.w700),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Consumer<BillProvider>(
                        builder: (context, billProvider, child) =>
                            IntrinsicHeight(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              children: [
                                buildElevatedButton(
                                  "CheckOut",
                                  Colors.green.shade500,
                                  50,
                                  27,
                                  () {
                                    Bill newBill = new Bill(
                                        id: UniqueKey(),
                                        total: cart.calcTotal().toString(),
                                        foodOrder: cart.cart,
                                        createdAt: formattedDate);
                                    billProvider.bill.add(newBill);
                                    cart.cart = [];
                                    cart.total = 0;
                                    setState(() {});
                                    showToast("Order success", Colors.green);
                                  },
                                ),
                              ],
                            ),
                          ),
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
