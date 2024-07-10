import 'package:flutter/material.dart';
import 'package:qpay_client/common/drawer.dart';
import 'package:qpay_client/common/responsive.dart';

class QrViewPage extends StatefulWidget {
  const QrViewPage({super.key});

  @override
  State<QrViewPage> createState() => _QrViewPageState();
}

class _QrViewPageState extends State<QrViewPage> {
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
              width: 200,
              height: 200,
              decoration: const BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage('assets/images/qr.jpeg'))),
            ),
            const SizedBox(height: 40),
            GestureDetector(
              onTap: () {
                Navigator.of(context).pushNamed('/home');
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
                  "Volver a inicio",
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
