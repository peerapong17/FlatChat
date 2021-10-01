import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:login_ui/food-shop/components/drawer_list_card.dart';
import 'package:login_ui/food-shop/data/drawer_list.dart';
import 'package:login_ui/food-shop/drawer/drawer-header/drawer_header.dart';
import 'package:login_ui/food-shop/history/screens/bill_detail.dart';
import 'package:login_ui/food-shop/state/bill_provider.dart';
import 'package:provider/provider.dart';

class History extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("History"),
        centerTitle: true,
      ),
      body: Consumer<BillProvider>(
        builder: (context, billProvider, child) => ListView.builder(
          scrollDirection: Axis.vertical,
          itemCount: billProvider.bill.length,
          itemBuilder: (context, index) {
            if (billProvider.bill.length != 0) {
              var bill = billProvider.bill[index];
              return ListTile(
                title: Text("บิลที่ ${index + 1}"),
                subtitle: Text(bill.createdAt),
                trailing: Icon(Icons.arrow_forward_ios),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => BillDetail(
                        bill: bill,
                      ),
                    ),
                  );
                },
              );
            }
            return Text("No bill created yet, let's add some");
          },
        ),
      ),
      drawer: Container(
        width: 250,
        child: Drawer(
          child: ListView(
            children: <Widget>[
              drawerHeader(),
              ...drawerList.map((e) {
                if (e.isLoggedIn != null) {
                  return DrawerList(
                    icon: e.icon,
                    title: e.title,
                    page: e.page,
                    isLoggedOut: true,
                  );
                }
                return DrawerList(
                  icon: e.icon,
                  title: e.title,
                  page: e.page,
                );
              })
            ],
          ),
        ),
      ),
    );
  }
}
