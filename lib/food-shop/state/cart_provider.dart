import 'package:flutter/foundation.dart';
import 'package:login_ui/food-shop/models/food_order.dart';

class CartProvider extends ChangeNotifier {
  List<FoodOrder> _userCart = [];
  int _total = 0;
  int _amount = 0;

  List<FoodOrder> get userCart => _userCart;

  set userCart(List<FoodOrder> cart) {
    _userCart = cart;
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
    for (var i = 0; i < userCart.length; i++) {
      total += userCart[i].amount * int.parse(userCart[i].price);
    }
    return total;
  }
}
