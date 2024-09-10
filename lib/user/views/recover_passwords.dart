import 'package:flutter/material.dart';
import 'package:qpay_client/common/responsive.dart';
import 'package:qpay_client/common/toast.dart';

class RecoverPasswordPage extends StatefulWidget {
  const RecoverPasswordPage({super.key});

  @override
  State<RecoverPasswordPage> createState() => _RecoverPasswordPageState();
}

class _RecoverPasswordPageState extends State<RecoverPasswordPage> {
  bool hidden = true;
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.all(Responsive.padding),
        child: Column(
          children: [
            // const SizedBox(height: 30),
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
                width: Responsive.width - 2 * Responsive.padding,
                alignment: Alignment.centerLeft,
                child: const Text(
                  "Recuperar contraseña",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 26),
                )),
            const SizedBox(height: 40),
            Form(
              key: _formKey,
              child: Column(
                children: [
                  Container(
                      width: Responsive.width - 2 * Responsive.padding,
                      alignment: Alignment.centerLeft,
                      child: const Text(
                        "Usuario",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 14,
                            color: Color(0xfff85f6a)),
                      )),
                  TextFormField(
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Este campo es obligatorio";
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 60),
                  GestureDetector(
                    onTap: () {
                      bool? success = _formKey.currentState?.validate();
                      if (success == true) {
                        showToast("Usuario no registrado", error: true);
                      }
                    },
                    child: Container(
                      width: Responsive.width - 2 * Responsive.padding,
                      height: 36,
                      alignment: Alignment.center,
                      padding:
                          EdgeInsets.symmetric(horizontal: Responsive.padding),
                      decoration: const BoxDecoration(
                          color: Color(0xfff85f6a),
                          borderRadius: BorderRadius.all(Radius.circular(6))),
                      child: const Text(
                        "Recuperar",
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
          ],
        ),
      ),
    );
  }
}
