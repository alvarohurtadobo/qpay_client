import 'package:flutter/material.dart';
import 'package:qpay_client/common/components/listTile.dart';
import 'package:qpay_client/common/drawer.dart';
import 'package:qpay_client/common/responsive.dart';

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
        padding: EdgeInsets.symmetric(vertical: Responsive.padding),
        child: Column(
          children: [
            const SizedBox(height: 50),
            Container(
              width: Responsive.width,
              height: 100,
              decoration: const BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage('assets/images/cloud.png'))),
            ),
            const Text(
              "qpay",
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                  color: Colors.grey),
            ),
            const SizedBox(height: 40),
            getTile("\$300.00", "Supermercado Fidalga", "2024-07-01",
                Icons.pending),
            getTile("\$200.00", "Supermercado Ktal", "2024-06-08", Icons.timer),
            getTile("\$100.00", "Heladeria", "2024-05-08", Icons.timer),
            getTile("\$30.00", "Panaderia", "2024-04-08", Icons.timer),
          ],
        ),
      ),
    );
  }
}
