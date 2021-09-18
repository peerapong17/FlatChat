import 'package:login_ui/food-shop/models/food_order.dart';

class Cart {
  List<FoodOrder> _cart = [];

  List<FoodOrder> get cart => _cart;

  set cart(List<FoodOrder> cart) {
    _cart = cart;
  }
}
