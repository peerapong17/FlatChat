import 'package:flutter/foundation.dart';
import 'package:login_ui/food-shop/models/food_menu.dart';
import 'package:login_ui/food-shop/models/food_order.dart';

class Cart with ChangeNotifier {
  List<FoodOrder> _userCart = [];
  int _total = 0;
  int _amount = 1;

  List<FoodOrder> get userCart => _userCart;

  set userCart(List<FoodOrder> userCart) {
    _userCart = userCart;
  }

  int get total => _total;

  set total(int total) {
    _total = total;
  }

  int get amount => _amount;

  set amount(int amount) {
    _amount = amount;
  }

  int calcTotal() {
    total = 0;
    for (var i = 0; i < userCart.length; i++) {
      total += userCart[i].amount * int.parse(userCart[i].price);
    }
    return total;
  }

  increaseAmount() {
    amount += 1;
    notifyListeners();
  }

  decreaseAmount() {
    if (amount > 1) {
      amount -= 1;
    } else {
      amount = 1;
    }
    notifyListeners();
  }

  increaseMenuAmount(String id) {
    for (var i = 0; i < userCart.length; i++) {
      if (id == userCart[i].id) {
        userCart[i].amount++;
      }
    }
    notifyListeners();
  }

  decreaseMenuAmount(String id) {
    for (var i = 0; i < userCart.length; i++) {
      if (id == userCart[i].id) {
        if (userCart[i].amount > 1) {
          userCart[i].amount--;
        } else {
          userCart.removeAt(userCart.indexWhere((u) => u.id == id));
        }
      }
    }
    notifyListeners();
  }

  addToCart(FoodMenu food) {
    bool orderExist = userCart.any((element) => element.id == food.id);
    if (orderExist) {
      for (int i = 0; i < userCart.length; i++) {
        if (userCart[i].id == food.id) {
          userCart[i].amount += amount;
        }
      }

      // cause a problem
      // userCart[int.parse(food.id)].amount += amount;
    } else {
      userCart.add(
        FoodOrder(
          id: food.id,
          image: food.image,
          name: food.name,
          price: food.price,
          amount: amount,
        ),
      );
    }
    notifyListeners();
  }

  removeItem(int id) {
    userCart.removeAt(id);
  }
}
