import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:login_ui/food-shop/models/bill.dart';

class BillDetail extends StatelessWidget {
  final Bill bill;

  BillDetail({required this.bill});

  final double iconSize = 40;

  @override
  Widget build(BuildContext context) {
    DateTime now = DateTime.now();
    String formattedDate = DateFormat('yyyy-MM-dd').format(now);
    return Scaffold(
      appBar: AppBar(
        title: Text('Bill Detail'),
        centerTitle: true,
      ),
      body: Container(
        padding: EdgeInsets.all(10),
        child: Column(
          children: [
            // DataTable(
            //   columns: [
            //     DataColumn(
            //       label: Text(
            //         'Name',
            //         style: TextStyle(fontStyle: FontStyle.italic),
            //         textAlign: TextAlign.center,
            //       ),
            //     ),
            //     DataColumn(
            //       label: Text('Price',
            //           style: TextStyle(fontStyle: FontStyle.italic),
            //           textAlign: TextAlign.center),
            //     ),
            //     DataColumn(
            //       label: Text('Amount',
            //           style: TextStyle(fontStyle: FontStyle.italic),
            //           textAlign: TextAlign.center),
            //     ),
            //     DataColumn(
            //       label: Text('Amount',
            //           style: TextStyle(fontStyle: FontStyle.italic),
            //           textAlign: TextAlign.center),
            //     ),
            //   ],
            //   rows: const <DataRow>[
            //     DataRow(
            //       cells: <DataCell>[
            //         DataCell(Text('Sarah')),
            //         DataCell(Text('19')),
            //         DataCell(Text('Student')),
            //         DataCell(Text('Student')),
            //       ],
            //     ),
            //     DataRow(
            //       cells: <DataCell>[
            //         DataCell(Text('Janine')),
            //         DataCell(Text('43')),
            //         DataCell(Text('Professor')),
            //         DataCell(Text('Professor')),
            //       ],
            //     ),
            //     DataRow(
            //       cells: <DataCell>[
            //         DataCell(Text('William')),
            //         DataCell(Text('27')),
            //         DataCell(Text('Associate Professor')),
            //         DataCell(Text('Associate Professor')),
            //       ],
            //     ),
            //   ],
            // ),
            Table(
              border: TableBorder.all(),
              children: [
                TableRow(
                  children: [
                    buildTableTitle("Name"),
                    buildTableTitle("Price"),
                    buildTableTitle("Amount"),
                    buildTableTitle("Total"),
                  ],
                ),
                ...bill.foodOrder.map(
                  (item) {
                    return TableRow(
                      children: [
                        buildTableBody(item.name),
                        buildTableBody(item.price),
                        buildTableBody(item.amount.toString()),
                        buildTableBody((int.parse(item.price) * item.amount).toString())
                      ],
                    );
                  },
                ),
                // TableRow(
                //   children: [
                //     buildTableBody("Spagetti"),
                //     buildTableBody("60"),
                //     buildTableBody("2"),
                //     buildTableBody("120")
                //   ],
                // ),
                // TableRow(
                //   children: [
                //     buildTableBody("ผักระเพรา"),
                //     buildTableBody("35"),
                //     buildTableBody("1"),
                //     buildTableBody("35")
                //   ],
                // ),
              ],
            ),
            SizedBox(
              height: 10,
            ),
            buildDetail("Ordered At:", bill.createdAt),
            buildDetail("Status:", "Pending..."),
            buildDetail("Tax:", "0%"),
            buildDetail("Total:", bill.total),
          ],
        ),
      ),
    );
  }

  Padding buildDetail(String lable, String detail) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      child: Container(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              lable,
              style: TextStyle(fontSize: 23, fontWeight: FontWeight.w700),
            ),
            Text(
              detail,
              style: TextStyle(fontSize: 23, fontWeight: FontWeight.w700),
            ),
          ],
        ),
      ),
    );
  }

  Padding buildTableTitle(String title) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Text(
        title,
        textAlign: TextAlign.center,
        style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
      ),
    );
  }

  Padding buildTableBody(String body) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Text(
        body,
        textAlign: TextAlign.center,
        style: TextStyle(fontSize: 17),
      ),
    );
  }
}
