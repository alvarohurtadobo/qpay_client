import 'package:flutter/material.dart';
import 'package:qpay_client/common/responsive.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool hidden = true;
  final _formKey = GlobalKey<FormState>();
  String? username;
  String? password;

  @override
  void initState() {
    SharedPreferences.getInstance().then((prefs) {
      username = prefs.getString('username');
      password = prefs.getString('password');
      debugPrint("Recovered shared prefernces to $username and $password");
      if (username != null &&
          username != "" &&
          password != null &&
          password != "") {
        Navigator.of(context).pushReplacementNamed('/home');
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: Responsive.width,
        height: Responsive.height,
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
                width: Responsive.width - 2 * Responsive.padding,
                alignment: Alignment.centerLeft,
                child: const Text(
                  "Login",
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
                  GestureDetector(
                    onTap: () {
                      bool? success = _formKey.currentState?.validate();
                      if (success == true) {
                        SharedPreferences.getInstance().then((prefs) {
                          prefs.setString('username', username ?? "");
                          prefs.setString('password', password ?? "");
                          debugPrint(
                              "Set shared prefernces to $username and $password");
                        });
                        Navigator.of(context).pushNamed('/home');
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
                        "Acceder",
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
            const SizedBox(height: 20),
            const Text(
              "ó acceder con redes sociales",
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                  color: Colors.grey),
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  width: Responsive.width / 3,
                  height: 36,
                  alignment: Alignment.center,
                  padding: EdgeInsets.symmetric(horizontal: Responsive.padding),
                  decoration: const BoxDecoration(
                      color: Color(0xff1da1f2),
                      borderRadius: BorderRadius.all(Radius.circular(6))),
                  child: Row(
                    children: [
                      Container(
                        height: 30,
                        width: 30,
                        decoration: const BoxDecoration(
                            image: DecorationImage(
                                image:
                                    AssetImage('assets/images/twitter.jpeg'))),
                      ),
                      const Text(
                        "Twitter",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 12,
                            color: Colors.white),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 20),
                Container(
                  width: Responsive.width / 3,
                  height: 36,
                  alignment: Alignment.center,
                  padding: EdgeInsets.symmetric(horizontal: Responsive.padding),
                  decoration: const BoxDecoration(
                      color: Color(0xff0165e1),
                      borderRadius: BorderRadius.all(Radius.circular(6))),
                  child: const Text(
                    "Facebook",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 12,
                        color: Colors.white),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 40),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.of(context).pushNamed('/recover');
                  },
                  child: const Text(
                    "¿Olvidó su contraseña?",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                        color: Colors.grey),
                  ),
                ),
                const SizedBox(width: 20),
                GestureDetector(
                  onTap: () {
                    Navigator.of(context).pushNamed('/register');
                  },
                  child: const Text(
                    "Registrarse",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                        color: Color(0xfff85f6a)),
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
