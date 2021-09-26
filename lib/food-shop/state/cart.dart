import 'package:login_ui/food-shop/models/food_order.dart';

class Cart {
  List<FoodOrder> _cart = [];
  int _total = 0;

  List<FoodOrder> get cart => _cart;

  set cart(List<FoodOrder> cart) {
    _cart = cart;
  }

  int get total => _total;

  set total(int total) {
    _total = total;
  }

}
