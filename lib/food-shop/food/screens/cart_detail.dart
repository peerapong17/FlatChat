import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:login_ui/utils/build_detail.dart';
import 'package:provider/provider.dart';
import 'package:login_ui/utils/show_toast.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:login_ui/utils/build_icon_button.dart';
import 'package:login_ui/food-shop/state/bill_provider.dart';
import 'package:login_ui/food-shop/state/cart_provider.dart';
import 'package:login_ui/utils/build_elevated_button.dart';

class CartDetail extends StatefulWidget {
  const CartDetail({Key? key}) : super(key: key);

  @override
  _CartDetailState createState() => _CartDetailState();
}

class _CartDetailState extends State<CartDetail> {
  CollectionReference billCollection =
      FirebaseFirestore.instance.collection("Bills");
  FirebaseAuth auth = FirebaseAuth.instance;

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
                                  subtitle: Text("${order.price} \$"),
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
                      buildDetail("Total:", "${cart.calcTotal()}", 35),
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
                                  () async {
                                    // Bill newBill = new Bill(
                                    //     id: UniqueKey(),
                                    //     total: cart.calcTotal().toString(),
                                    //     foodOrder: cart.cart,
                                    //     createdAt: formattedDate);
                                    // billProvider.bill.add(newBill);
                                    List<Map<String, String>> userCart = [];
                                    for (var item in cart.cart) {
                                      userCart.add({
                                        "id": item.id,
                                        "name": item.name,
                                        "image": item.image,
                                        "price": item.price,
                                        "amount": item.amount.toString(),
                                        "subTotal": (int.parse(item.price) *
                                                item.amount)
                                            .toString()
                                      });
                                    }
                                    await billCollection.add({
                                      "userID": auth.currentUser!.uid,
                                      "total": cart.calcTotal().toString(),
                                      "orders": userCart,
                                      "createdAt": DateTime.now()
                                    });
                                    userCart = [];
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
