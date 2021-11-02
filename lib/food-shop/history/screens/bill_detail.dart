import 'package:flutter/material.dart';
import 'package:login_ui/food-shop/models/bill.dart';
import 'package:login_ui/utils/build_detail.dart';
import 'package:login_ui/utils/build_table_body.dart';
import 'package:login_ui/utils/build_table_title.dart';

class BillDetail extends StatelessWidget {
  final Bill bill;
  BillDetail({required this.bill});
  @override
  Widget build(BuildContext context) {
    // DateTime now = DateTime.now();
    // String formattedDate = DateFormat('dd-MM-yyyy').format(now);
    // print(formattedDate);
    return Scaffold(
      appBar: AppBar(
        title: Text('Bill Detail'),
        centerTitle: true,
      ),
      body: Container(
        padding: EdgeInsets.all(10),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: Text(
                "Bill ID# ${bill.id}",
                style: TextStyle(fontSize: 23, fontWeight: FontWeight.w700),
                textAlign: TextAlign.left,
              ),
            ),
            Table(
              border: TableBorder.all(),
              children: [
                TableRow(
                  children: [
                    buildTableTitle("Name"),
                    buildTableTitle("Price"),
                    buildTableTitle("Amount"),
                    buildTableTitle("SubTotal"),
                  ],
                ),
                ...bill.foodOrder.map(
                  (item) {
                    return TableRow(
                      children: [
                        buildTableBody(
                          item.name,
                        ),
                        buildTableBody(
                          item.price,
                        ),
                        buildTableBody(
                          item.amount.toString(),
                        ),
                        buildTableBody(
                          item.subTotal.toString(),
                        ),
                      ],
                    );
                  },
                ),
              ],
            ),
            SizedBox(
              height: 10,
            ),
            buildDetail("Name:", bill.name, 27),
            buildDetail("Email:", bill.email, 27),
            buildDetail("Phone number:", bill.phone, 27),
            buildDetail("Address:", bill.address, 27),
            buildDetail(
                "Date:", bill.orderedAt.toDate().toString().split(" ")[0], 27),
            buildDetail("Status:", "Pending...", 27),
            buildDetail("Tax:", "0%", 27),
            buildDetail("Total:", bill.total, 27),
          ],
        ),
      ),
    );
  }
}

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