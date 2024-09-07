import 'dart:convert';
import 'dart:math';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:qpay_client/common/toast.dart';
import 'package:qpay_client/common/drawer.dart';
import 'package:qpay_client/user/model/user.dart';
import 'package:qpay_client/common/constants.dart';
import 'package:qpay_client/common/responsive.dart';
import 'package:qpay_client/common/services/repository.dart';

class QrViewPage extends StatefulWidget {
  const QrViewPage({super.key});

  @override
  State<QrViewPage> createState() => _QrViewPageState();
}

class _QrViewPageState extends State<QrViewPage> {
  bool loading = false;
  bool loadingQR = false;
  bool hasImage = false;
  String base64ImageString = "";
  Uint8List? bytes;

  @override
  void initState() {
    super.initState();
    setState(() {
      loadingQR = true;
    });
    apiService.postRequest('pay/generateqr',
        {"userId": currentUser.id, "amount": amount.toString()}).then((res) {
      if (res.statusCode == 201) {
        base64ImageString = res.data['imagenQR'] ?? "";
        setState(() {
          hasImage = true;
        });
      }
      setState(() {
        loadingQR = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    if (base64ImageString != "") {
      bytes = const Base64Decoder().convert(base64ImageString);
    }

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
            hasImage
                ? Container(
                    width: 200,
                    height: 200,
                    decoration: BoxDecoration(
                        image: DecorationImage(
                            image: bytes != null
                                ? MemoryImage(bytes!)
                                : const AssetImage('assets/images/qr.jpeg'))),
                  )
                : const Center(
                    child: CircularProgressIndicator(),
                  ),
            const SizedBox(height: 40),
            GestureDetector(
              onTap: () {
                if (loading) {
                  return;
                }
                print("Cargar $amount pesos");
                setState(() {
                  loading = true;
                });
                var random = Random();
                int randomNumber = random.nextInt(10000) + 1;
                apiService.postRequest("trx/registerapp", {
                  "userId": currentUser.id,
                  "detail": "Carga de Saldo $randomNumber",
                  "amount": amount.toString(),
                  "type": "CLIENT_CHARGE"
                }).then((res) {
                  if (res.statusCode == 201) {
                    showToast("Carga exitosa");
                    Navigator.of(context).pushNamed('/home');
                  }
                  setState(() {
                    loading = false;
                  });
                }).catchError((err) {
                  showToast("No se pudo realizar la recarga", error: true);
                  Navigator.of(context).pushNamed('/home');
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
                        "Cargar y Volver a inicio",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                            color: Colors.white),
                      ),
              ),
            ),
            const SizedBox(height: 20),
            Container(
              width: Responsive.width / 2,
              height: Responsive.width / 2.5,
              alignment: Alignment.center,
              padding: const EdgeInsets.symmetric(horizontal: 6),
              decoration: BoxDecoration(
                  border: Border.all(color: Colors.black),
                  color: Colors.white,
                  borderRadius: const BorderRadius.all(Radius.circular(6))),
              child: const Text(
                "Utilice códigos QR de banca solo en sitios oficiales. Verifique la autenticidad antes de escanear. Evite compartir información personal o financiera a través de QR no verificados. Mantenga su dispositivo seguro y actualizado para protegerse de fraudes y phishing. La seguridad es su responsabilidad.",
                textAlign: TextAlign.justify,
                style: TextStyle(
                    fontWeight: FontWeight.normal,
                    fontSize: 10,
                    color: Colors.black54),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
