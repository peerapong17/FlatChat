import 'package:flutter/foundation.dart';
import 'package:login_ui/food-shop/models/bill.dart' as M;

class Bill with ChangeNotifier {
  List<M.Bill> _bill = [];

  List<M.Bill> get bill => _bill;

  set bill(List<M.Bill> bill) {
    _bill = bill;
    notifyListeners();
  }
}
