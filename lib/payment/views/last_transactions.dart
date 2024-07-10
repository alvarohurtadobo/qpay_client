import 'package:flutter/material.dart';
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
        padding: EdgeInsets.all(Responsive.padding),
        child: Column(
          children: [
            const SizedBox(height: 50),
            Container(
              width: Responsive.width - 2 * Responsive.padding,
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
            const ListTile(
              leading: Icon(Icons.pending, color: Color(0xfff85f6a)),
              title: Text("\$200.00"),
              subtitle: Text("Supermercado Fidalga"),
            ),
            const SizedBox(height: 10),
            const ListTile(
              leading: Icon(Icons.timer, color: Color(0xfff85f6a)),
              title: Text("\$200.00"),
              subtitle: Text("Supermercado Ktal"),
            )
            ,const SizedBox(height: 10),
            const ListTile(
              leading: Icon(Icons.timer, color: Color(0xfff85f6a)),
              title: Text("\$20.00"),
              subtitle: Text("Panaderia"),
            )
          ],
        ),
      ),
    );
  }
}
