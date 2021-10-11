import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:login_ui/utils/show_snackbar.dart';

class BillService {
  CollectionReference billCollection =
      FirebaseFirestore.instance.collection("Bills");
  FirebaseAuth auth = FirebaseAuth.instance;

  Future<void> addBill(BuildContext context, Map<String, dynamic> bill) async {
    try {
      await billCollection.add(bill);
    } on FirebaseException catch (error) {
      showSnack(error.message!, context);
    }
  }

  // Future<QuerySnapshot<Object?>> getBill() async {
  //   return await billCollection
  //       .where("userID", isEqualTo: auth.currentUser!.uid)
  //       .get();
  // }
}
