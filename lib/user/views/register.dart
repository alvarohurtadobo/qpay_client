import 'package:flutter/material.dart';
import 'package:qpay_client/common/responsive.dart';
import 'package:qpay_client/common/toast.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  bool hidden = true;
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.all(Responsive.padding),
        child: Column(children: [
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
                fontWeight: FontWeight.bold, fontSize: 16, color: Colors.grey),
          ),
          const SizedBox(height: 20),
          Container(
              width: Responsive.width - 2 * Responsive.padding,
              alignment: Alignment.centerLeft,
              child: const Text(
                "Registro",
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
                const SizedBox(height: 10),
                Container(
                    width: Responsive.width - 2 * Responsive.padding,
                    alignment: Alignment.centerLeft,
                    child: const Text(
                      "Password",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                          color: Color(0xfff85f6a)),
                    )),
                TextFormField(
                  obscureText: hidden,
                  validator: (value) {
                    if (value == null) {
                      return null;
                    }
                    if (value.length < 8) {
                      return "Este campo debe tener al menos 8 carácteres";
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                      suffixIcon: GestureDetector(
                    onTap: () {
                      setState(() {
                        hidden = !hidden;
                      });
                    },
                    child: Icon(
                      hidden
                          ? Icons.remove_red_eye_outlined
                          : Icons.remove_red_eye,
                      color: Colors.grey,
                    ),
                  )),
                ),
                const SizedBox(height: 40),
                Container(
                    width: Responsive.width - 2 * Responsive.padding,
                    alignment: Alignment.centerLeft,
                    child: const Text(
                      "Nombres",
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
                const SizedBox(height: 10),
                Container(
                    width: Responsive.width - 2 * Responsive.padding,
                    alignment: Alignment.centerLeft,
                    child: const Text(
                      "Apellidos",
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
                const SizedBox(height: 10),
                Container(
                    width: Responsive.width - 2 * Responsive.padding,
                    alignment: Alignment.centerLeft,
                    child: const Text(
                      "Teléfono",
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
                const SizedBox(height: 30),
                GestureDetector(
                  onTap: () {
                    bool? success = _formKey.currentState?.validate();
                    if (success == true) {
                      showToast("Función aún no implementada", error: true);
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
                      "Registrarse",
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
        ]),
      ),
    );
  }
}
