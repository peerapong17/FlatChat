import 'package:cloud_firestore/cloud_firestore.dart';
import 'food_order.dart';

class Bill {
  String? id;
  String userId;
  String name;
  String email;
  String phone;
  String address;
  String total;
  Timestamp orderedAt;
  List<FoodOrder> foodOrder;


  Bill({
    this.id,
    required this.userId,
    required this.name,
    required this.email,
    required this.phone,
    required this.address,
    required this.total,
    required this.orderedAt,
    required this.foodOrder,
  });

  factory Bill.fromJson(Map<String, dynamic> json) => Bill(
        id: json["id"],
        userId: json['userId'],
        name: json['name'],
        email: json['email'],
        phone: json['phone'],
        total: json["total"],
        address: json["address"],
        orderedAt: json["createdAt"],
        foodOrder: List<FoodOrder>.from(
          json["foodOrder"].map(
            (x) => FoodOrder.fromJson(x),
          ),
        ),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "userId": userId,
        "name": name,
        "email": email,
        "phone": phone,
        "total": total,
        "address": address,
        "createdAt": orderedAt,
        "foodOrder": List<Map<String, dynamic>>.from(
          foodOrder.map(
            (x) => x.toJson(),
          ),
        ),
      };
}
