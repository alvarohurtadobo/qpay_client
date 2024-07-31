import 'package:flutter/material.dart';
import 'package:qpay_client/common/button.dart';
import 'package:qpay_client/common/drawer.dart';
import 'package:qpay_client/common/constants.dart';
import 'package:qpay_client/common/responsive.dart';

class ChargeAmountPage extends StatefulWidget {
  const ChargeAmountPage({super.key});

  @override
  State<ChargeAmountPage> createState() => _ChargeAmountPageState();
}

class _ChargeAmountPageState extends State<ChargeAmountPage> {
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
            const SizedBox(height: 20),
            Container(
              width: Responsive.width / 3,
              height: 40,
              decoration: BoxDecoration(
                  border: Border.all(color: Colors.black, width: 1),
                  color: Colors.white),
              alignment: Alignment.center,
              child: Text(
                "\$ ${amount.toStringAsFixed(2)}",
                style: const TextStyle(color: Colors.grey),
              ),
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                myButton(1, (digit) {
                  setState(() {
                    amount = amount * 10 + digit / 100;
                  });
                  print("newamount is $amount");
                }),
                const SizedBox(width: 20),
                myButton(2, (digit) {
                  setState(() {
                    amount = amount * 10 + digit / 100;
                  });
                }),
                const SizedBox(width: 20),
                myButton(3, (digit) {
                  setState(() {
                    amount = amount * 10 + digit / 100;
                  });
                }),
              ],
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                myButton(4, (digit) {
                  setState(() {
                    amount = amount * 10 + digit / 100;
                  });
                }),
                const SizedBox(width: 20),
                myButton(5, (digit) {
                  setState(() {
                    amount = amount * 10 + digit / 100;
                  });
                }),
                const SizedBox(width: 20),
                myButton(6, (digit) {
                  setState(() {
                    amount = amount * 10 + digit/ 100;
                  });
                }),
              ],
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                myButton(7, (digit) {
                  setState(() {
                    amount = amount * 10 + digit / 100;
                  });
                }),
                const SizedBox(width: 20),
                myButton(8, (digit) {
                  setState(() {
                    amount = amount * 10 + digit / 100;
                  });
                }),
                const SizedBox(width: 20),
                myButton(9, (digit) {
                  setState(() {
                    amount = amount * 10 + digit / 100;
                  });
                }),
              ],
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                placeHolder(),
                const SizedBox(width: 20),
                myButton(0, (digit) {
                  setState(() {
                    amount = amount * 10;
                  });
                }),
                const SizedBox(width: 20),
                myBackButton(() {
                  setState(() {
                    amount = (amount / 10 *100).toInt()/100;
                  });
                })
              ],
            ),
            const SizedBox(height: 40),
            GestureDetector(
              onTap: () {
                Navigator.of(context).pushNamed('/qr_view');
              },
              child: Container(
                width: Responsive.width - 2 * Responsive.padding,
                height: 36,
                alignment: Alignment.center,
                padding: EdgeInsets.symmetric(horizontal: Responsive.padding),
                decoration: const BoxDecoration(
                    color: Color(0xfff85f6a),
                    borderRadius: BorderRadius.all(Radius.circular(6))),
                child: const Text(
                  "Generar QR",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                      color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
