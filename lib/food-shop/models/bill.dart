import 'package:cloud_firestore/cloud_firestore.dart';
import 'food_order.dart';

class Bill {
  String? id;
  String userId;
  String total;
  Timestamp createdAt;
  List<FoodOrder> foodOrder;

  Bill({
    this.id,
    required this.userId,
    required this.total,
    required this.foodOrder,
    required this.createdAt,
  });

  factory Bill.fromJson(Map<String, dynamic> json) => Bill(
        id: json["id"],
        userId: json['userId'],
        total: json["total"],
        createdAt: json["createdAt"],
        foodOrder: List<FoodOrder>.from(
          json["foodOrder"].map(
            (x) => FoodOrder.fromJson(x),
          ),
        ),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "userId": userId,
        "total": total,
        "createdAt": createdAt,
        "foodOrder": List<Map<String, dynamic>>.from(
          foodOrder.map(
            (x) => x.toJson(),
          ),
        ),
      };
}
