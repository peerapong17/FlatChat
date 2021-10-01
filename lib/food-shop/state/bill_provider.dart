import 'package:flutter/foundation.dart';
import 'package:login_ui/food-shop/models/bill.dart';

class BillProvider extends ChangeNotifier {
  List<Bill> _bill = [];

  List<Bill> get bill => _bill;

  set bill(List<Bill> bill) {
    _bill = bill;
    notifyListeners();
  }
}
