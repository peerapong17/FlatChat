// import 'package:flutter/material.dart';
// import 'package:login_ui/food-shop/food/food_detail.dart';
// import 'package:login_ui/food-shop/models/food_menu.dart';

// Padding foodMenuCard(FoodMenu foodMenu, BuildContext context) {
//   return Padding(
//     padding: const EdgeInsets.symmetric(vertical: 3),
//     child: ListTile(
//       leading: Image(
//         image: AssetImage(foodMenu.image),
//       ),
//       title: Text(foodMenu.menu),
//       subtitle: Text(foodMenu.price),
//       trailing: Icon(Icons.arrow_forward_ios_outlined),
//       onTap: () {
//         Navigator.push(
//           context,
//           MaterialPageRoute(
//             builder: (context) => foodDetail(
//               foodName: foodMenu.menu,
//               image: foodMenu.image,
//               price: foodMenu.price,
//               context: context,
//             ),
//           ),
//         );
//       },
//     ),
//   );
// }
