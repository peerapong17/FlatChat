import 'package:flutter/foundation.dart';
import 'package:login_ui/food-shop/models/food_order.dart';

class CartProvider extends ChangeNotifier {
  List<FoodOrder> _cart = [];
  int _total = 0;
  int _amount = 0;

  List<FoodOrder> get cart => _cart;

  set cart(List<FoodOrder> cart) {
    _cart = cart;
    notifyListeners();
  }

  int get total => _total;

  set total(int total) {
    _total = total;
  }

  int get amount => _amount;

  set amount(int amount) {
    _amount = amount;
    notifyListeners();
  }

  int calcTotal() {
    total = 0;
    for (var i = 0; i < cart.length; i++) {
      total += cart[i].amount * int.parse(cart[i].price);
    }
    return total;
  }
}
