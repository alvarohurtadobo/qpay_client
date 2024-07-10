import 'package:flutter/material.dart';
import 'package:qpay_client/common/responsive.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                width: Responsive.width - 2 * Responsive.padding,
                alignment: Alignment.centerLeft,
                child: const Text(
                  "Login",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
                )),
            const SizedBox(height: 40),
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
            const TextField(),
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
            const TextField(
              obscureText: true,
              decoration: InputDecoration(
                  suffixIcon: Icon(
                Icons.remove_red_eye,
                color: Colors.grey,
              )),
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
                  "Acceder",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                      color: Colors.white),
                ),
              ),
            ),
            const SizedBox(height: 10),
            const Text(
              "ó acceder con redes sociales",
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                  color: Colors.grey),
            ),
            const SizedBox(height: 40),
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
            const Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "¿Olvidó su contraseña?",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                      color: Colors.grey),
                ),
                SizedBox(width: 20),
                Text(
                  "Registrarse",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                      color: Color(0xfff85f6a)),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
