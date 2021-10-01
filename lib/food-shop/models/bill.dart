
import 'package:flutter/material.dart';
import 'food_order.dart';

class Bill {
  UniqueKey id;
  String total;
  String createdAt;
  List<FoodOrder> foodOrder;

  Bill({
    required this.id,
    required this.total,
    required this.foodOrder,
    required this.createdAt,
  });
}
