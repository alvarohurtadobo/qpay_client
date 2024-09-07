import 'package:flutter/material.dart';
import 'package:qpay_client/common/drawer.dart';
import 'package:qpay_client/common/responsive.dart';
import 'package:qpay_client/payment/model/transaction.dart';
import 'package:qpay_client/common/components/listTile.dart';

class TransactionHistoryPage extends StatefulWidget {
  const TransactionHistoryPage({super.key});

  @override
  State<TransactionHistoryPage> createState() => _TransactionHistoryPageState();
}

class _TransactionHistoryPageState extends State<TransactionHistoryPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      drawer: myDrawer(context),
      body: Container(
        width: Responsive.width,
        height: Responsive.height,
        padding: EdgeInsets.symmetric(vertical: Responsive.padding),
        child: ListView(
          children: [
            const SizedBox(height: 50),
            Container(
              width: Responsive.width,
              height: 100,
              decoration: const BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage('assets/images/cloud.png'))),
            ),
            Container(
              width: Responsive.width,
              alignment: Alignment.center,
              child: const Text(
                "qpay",
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                    color: Colors.grey),
              ),
            ),
            const SizedBox(height: 40),
            Column(
              children: myTransactions.reversed
                  .map(
                    (e) => getTile(
                        e.detail,
                        e.dateAdd
                            .toIso8601String()
                            .substring(0, 16)
                            .replaceAll("T", ' '),
                        e.amount,
                        e.type,
                        Icons.timer),
                  )
                  .toList(),
            )
          ],
        ),
      ),
    );
  }
}
