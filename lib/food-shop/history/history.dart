import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:login_ui/food-shop/components/drawer_list_card.dart';
import 'package:login_ui/food-shop/data/drawer_list.dart';
import 'package:login_ui/food-shop/drawer/drawer-header/drawer_header.dart';
import 'package:login_ui/food-shop/history/screens/bill_detail.dart';

class History extends StatelessWidget {
  CollectionReference billCollection =
      FirebaseFirestore.instance.collection("Bills");
  FirebaseAuth auth = FirebaseAuth.instance;

  Future<QuerySnapshot<Object?>> getUserBill() async {
    return await billCollection
        .where("userID", isEqualTo: auth.currentUser!.uid)
        .get();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("History"),
        centerTitle: true,
      ),
      body: FutureBuilder<QuerySnapshot<Object?>>(
        future: getUserBill(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          return ListView.builder(
            scrollDirection: Axis.vertical,
            itemCount: snapshot.data!.docs.length,
            itemBuilder: (context, index) {
              var bill = snapshot.data!.docs[index];
              return ListTile(
                title: Text("บิลที่ ${index + 1}"),
                subtitle:
                    Text(bill['createdAt'].toDate().toString().split(".")[0]),
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
            },
          );
        },
      ),
      drawer: Container(
        width: 250,
        child: Drawer(
          child: ListView(
            children: <Widget>[
              drawerHeader(),
              ...drawerList.map(
                (e) {
                  return DrawerList(
                    icon: e.icon,
                    title: e.title,
                    page: e.page,
                    isLoggedIn: e.isLoggedIn,
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
