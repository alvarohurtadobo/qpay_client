import 'package:flutter/material.dart';
import 'package:qpay_client/common/drawer.dart';
import 'package:qpay_client/common/responsive.dart';
import 'package:qpay_client/common/services/repository.dart';
import 'package:qpay_client/common/toast.dart';
import 'package:qpay_client/payment/model/tag.dart';
import 'package:qpay_client/user/model/user.dart';

class RegisterDevicePage extends StatefulWidget {
  const RegisterDevicePage({super.key});

  @override
  State<RegisterDevicePage> createState() => _RegisterDevicePageState();
}

class _RegisterDevicePageState extends State<RegisterDevicePage> {
  String tagNumber = '';
  String tagCode = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      drawer: myDrawer(context),
      body: Container(
        width: Responsive.width,
        height: Responsive.height,
        padding: EdgeInsets.all(Responsive.padding),
        child: ListView(
          children: [
            const SizedBox(height: 50),
            Container(
              width: Responsive.width - 2 * Responsive.padding,
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
            const SizedBox(height: 20),
            Container(
              width: Responsive.width,
              alignment: Alignment.center,
              child: Container(
                width: Responsive.width / 2,
                height: Responsive.width / 2,
                alignment: Alignment.center,
                padding: EdgeInsets.symmetric(horizontal: Responsive.padding),
                decoration: const BoxDecoration(
                    color: Colors.grey,
                    borderRadius: BorderRadius.all(Radius.circular(6))),
                child: const Text(
                  "Escanear dispositivo",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                      color: Colors.white),
                ),
              ),
            ),
            const SizedBox(height: 10),
            TextField(
              onChanged: (val) {
                tagNumber = val;
              },
              decoration: const InputDecoration(hintText: "Numero de manilla"),
            ),
            const SizedBox(height: 10),
            TextField(
              onChanged: (val) {
                tagCode = val;
              },
              decoration: const InputDecoration(hintText: "Nombre de manilla"),
            ),
            const SizedBox(height: 20),
            GestureDetector(
              onTap: () {
                if (tagNumber.isNotEmpty && tagCode.isNotEmpty) {
                  apiService.postRequest('tag/register', {
                    "userId": currentUser.id,
                    "tagId": tagNumber,
                    "code": tagCode
                  }).then((response) {
                    if (response.statusCode == 201) {
                      myTags.add(Tag(
                          id: "",
                          dateAdd: DateTime.now(),
                          tagId: tagNumber,
                          code: tagCode,
                          disabled: false,
                          state: 'ACTIVE',
                          balance: '0.00',
                          trxApps: []));
                      setState(() {});
                    } else {
                      showToast("No se pudo registrar", error: true);
                    }
                  }).catchError((err) {
                    print("Error is $err");
                    showToast("Error, No se pudo registrar", error: true);
                  });
                }
                Navigator.of(context).pushNamed('/device_registered');
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
                  "Escanear dispositivo",
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
