import 'package:flutter/cupertino.dart';

import 'package:flutter/material.dart';
import 'package:login_ui/models/models.dart';

class Food extends StatefulWidget {
  @override
  _FoodState createState() => _FoodState();
}

class _FoodState extends State<Food> {
  List<Map<String, String>> hotFood = [
    {'image': 'assets/images/ต้มยำกุ้ง.jpg'},
    {'image': 'assets/images/ข้าวผัด.jpg'},
    {'image': 'assets/images/ผัดไทย.jpg'}
  ];

  List<FoodMenu> listFood = [
    FoodMenu(image: 'assets/images/pizza.jpg', menu: 'pizza', price: '90'),
    FoodMenu(
        image: 'assets/images/hamberger.jpg', menu: 'hamberger', price: '50'),
    FoodMenu(
        image: 'assets/images/ผัดกะเพราหมูสับ.jpg',
        menu: 'ผัดกระเพรา',
        price: '35'),
  ];

  int currentPage = 0;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text('Hot menu',
            style: TextStyle(
              fontFamily: 'Chewy',
              fontSize: 40,
              color: Colors.red,
            )),
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(60),
          ),
          height: 250,
          width: double.infinity,
          child: PageView.builder(
            onPageChanged: (index) {
              setState(() {
                currentPage = index;
              });
            },
            itemCount: hotFood.length,
            itemBuilder: (context, index) {
              return Image.asset(
                hotFood[index]['image'],
                fit: BoxFit.contain,
              );
            },
          ),
        ),
        Container(
          width: double.infinity,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(
              hotFood.length,
              (index) {
                return BallPageList(index, currentPage);
              },
            ),
          ),
        )
      ],
    );
  }
}

class BallPageList extends StatelessWidget {
  final int index;
  final int currentPage;
  BallPageList(this.index, this.currentPage);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 10, left: 10),
      child: Container(
        height: 12,
        width: 12,
        decoration: BoxDecoration(
            color: currentPage == index ? Colors.black : Colors.grey[300],
            borderRadius: BorderRadius.circular(50)),
      ),
    );
  }
}
