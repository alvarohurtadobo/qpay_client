import 'dart:math';

import 'package:flutter/material.dart';
import 'package:qpay_client/common/button.dart';
import 'package:qpay_client/common/drawer.dart';
import 'package:qpay_client/common/constants.dart';
import 'package:qpay_client/common/responsive.dart';
import 'package:qpay_client/common/services/repository.dart';
import 'package:qpay_client/common/toast.dart';
import 'package:qpay_client/payment/model/tag.dart';
import 'package:qpay_client/user/model/user.dart';

class ChargeTagPage extends StatefulWidget {
  const ChargeTagPage({super.key});

  @override
  State<ChargeTagPage> createState() => _ChargeTagPageState();
}

class _ChargeTagPageState extends State<ChargeTagPage> {
  bool loading = false;
  double saldoDisponible = 0;

  @override
  Widget build(BuildContext context) {
    // double saldoEnManillas = 0;
    // myTags.forEach((tag) {
    //   tag.trxApps.forEach((transaction) {
    //     saldoEnManillas += transaction.amountDouble;
    //   });
    // });
    saldoDisponible = currentUser.balanceDouble; // - saldoEnManillas;
    return Scaffold(
      appBar: AppBar(),
      drawer: myDrawer(context),
      body: Container(
        width: Responsive.width,
        height: Responsive.height,
        padding: EdgeInsets.all(Responsive.padding),
        child: ListView(
          children: [
            // const SizedBox(height: 30),
            Container(
              width: Responsive.width - 2 * Responsive.padding,
              height: 100,
              decoration: const BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage('assets/images/cloud.png'))),
            ),
            Container(
              width: Responsive.width - 2 * Responsive.padding,
              alignment: Alignment.center,
              child: const Text(
                "qpay",
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                    color: Colors.grey),
              ),
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
                "\$ ${tagAmount.toStringAsFixed(2)}",
                style: const TextStyle(color: Colors.grey),
              ),
            ),
            const SizedBox(height: 20),
            Text("Saldo disponible: $saldoDisponible"),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                myButton(1, (digit) {
                  setState(() {
                    tagAmount = tagAmount * 10 + digit / 100;
                  });
                  print("newamount is $tagAmount");
                }),
                const SizedBox(width: 20),
                myButton(2, (digit) {
                  setState(() {
                    tagAmount = tagAmount * 10 + digit / 100;
                  });
                }),
                const SizedBox(width: 20),
                myButton(3, (digit) {
                  setState(() {
                    tagAmount = tagAmount * 10 + digit / 100;
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
                    tagAmount = tagAmount * 10 + digit / 100;
                  });
                }),
                const SizedBox(width: 20),
                myButton(5, (digit) {
                  setState(() {
                    tagAmount = tagAmount * 10 + digit / 100;
                  });
                }),
                const SizedBox(width: 20),
                myButton(6, (digit) {
                  setState(() {
                    tagAmount = tagAmount * 10 + digit / 100;
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
                    tagAmount = tagAmount * 10 + digit / 100;
                  });
                }),
                const SizedBox(width: 20),
                myButton(8, (digit) {
                  setState(() {
                    tagAmount = tagAmount * 10 + digit / 100;
                  });
                }),
                const SizedBox(width: 20),
                myButton(9, (digit) {
                  setState(() {
                    tagAmount = tagAmount * 10 + digit / 100;
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
                    tagAmount = tagAmount * 10;
                  });
                }),
                const SizedBox(width: 20),
                myBackButton(() {
                  setState(() {
                    tagAmount = (tagAmount / 10 * 100).toInt() / 100;
                  });
                })
              ],
            ),
            const SizedBox(height: 40),
            GestureDetector(
              onTap: () {
                setState(() {
                  loading = true;
                });
                var random = Random();
                int randomNumber = random.nextInt(10000) + 1;
                apiService.postRequest('trx/registerapp', {
                  "userId": currentUser.id,
                  "detail": "Carga de Manilla $randomNumber",
                  "amount": tagAmount.toString(),
                  "tagId": myTag.id,
                  "type": "TAG_CHARGE"
                }).then((res) {
                  if (res.statusCode == 201) {
                    showToast("Carga exitosa");
                    Navigator.of(context).pop();
                  }
                  setState(() {
                    loading = false;
                  });
                }).catchError((err) {
                  print("Error is $err");
                  showToast("Limite sobrepasado", error: true);
                  setState(() {
                    loading = false;
                  });
                });
              },
              child: Container(
                width: Responsive.width - 2 * Responsive.padding,
                height: 36,
                alignment: Alignment.center,
                padding: EdgeInsets.symmetric(horizontal: Responsive.padding),
                decoration: const BoxDecoration(
                    color: Color(0xfff85f6a),
                    borderRadius: BorderRadius.all(Radius.circular(6))),
                child: loading
                    ? const Center(
                        child: CircularProgressIndicator(
                          color: Colors.white,
                        ),
                      )
                    : const Text(
                        "Cargar",
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
