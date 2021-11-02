import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:login_ui/food-shop/check-out/check_out.dart';
import 'package:login_ui/services/bill_service.dart';
import 'package:login_ui/utils/build_detail.dart';
import 'package:login_ui/utils/show_alert_dialog.dart';
import 'package:provider/provider.dart';
import 'package:login_ui/utils/build_icon_button.dart';
import 'package:login_ui/food-shop/state/cart.dart';
import 'package:login_ui/utils/build_elevated_button.dart';

class CartDetail extends StatelessWidget {
  final BillService billService = new BillService();
  final FirebaseAuth auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    print("refresh");
    return Consumer<Cart>(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "No order yet, Let's add some!",
            style: Theme.of(context).textTheme.headline5,
          ),
        ],
      ),
      builder: (context, cartSt, child) {
        print("inside consumer is refresh");
        return WillPopScope(
          onWillPop: () async {
            var res = await showAlertDialog(context: context);
            return res;
          },
          child: Scaffold(
            body: Container(
              width: double.infinity,
              height: double.infinity,
              child: cartSt.userCart.length == 0
                  ? child
                  : Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Container(
                          height: MediaQuery.of(context).size.height * 0.6,
                          child: ListView(
                            scrollDirection: Axis.vertical,
                            children: cartSt.userCart.map(
                              (order) {
                                var index = cartSt.userCart.indexOf(order);
                                return Dismissible(
                                  key: UniqueKey(),
                                  onDismissed: (direction) {
                                    cartSt.userCart.removeAt(index);

                                    //or
                                    // cart.userCart.remove(order);
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
                                          () => cartSt.increaseMenuAmount(order.id)
                                          // () {
                                          //   for (var i = 0;
                                          //       i < cartSt.userCart.length;
                                          //       i++) {
                                          //     if (order.id ==
                                          //         cartSt.userCart[i].id) {
                                          //       cartSt.userCart[i].amount++;
                                          //     }
                                          //   }
                                          // },
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
                                          () => cartSt.decreaseMenuAmount(order.id)
                                          // () {
                                          //   for (var i = 0;
                                          //       i < cartSt.userCart.length;
                                          //       i++) {
                                          //     if (order.id ==
                                          //         cartSt.userCart[i].id) {
                                          //       if (cartSt.userCart[i].amount >
                                          //           1) {
                                          //         cartSt.userCart[i].amount--;
                                          //       } else {
                                          //         cartSt.userCart
                                          //             .removeAt(index);
                                          //       }
                                          //     }
                                          //   }
                                          // },
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              },
                            ).toList(),
                          ),
                        ),
                        buildDetail("Total:", "${cartSt.calcTotal()}", 35),
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
                                          userCart: cartSt.userCart,
                                          total: cartSt.total,
                                        ),
                                      ),
                                    );
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
