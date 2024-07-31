import 'package:flutter/material.dart';
import 'package:qpay_client/common/toast.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:qpay_client/common/responsive.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:qpay_client/common/services/repository.dart';

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

  bool loading = false;

  TextEditingController emailController = TextEditingController();

  ValueNotifier userCredential = ValueNotifier('');

  @override
  void initState() {
    SharedPreferences.getInstance().then((prefs) {
      username = prefs.getString('username');
      emailController.text = username ?? "";
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
                    onChanged: (val) {
                      username = val;
                    },
                    controller: emailController,
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
                    onChanged: (val) {
                      password = val;
                    },
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
                    onTap: () async {
                      if (loading) {
                        return;
                      }
                      bool? success = _formKey.currentState?.validate();
                      if (success == true) {
                        setState(() {
                          loading = true;
                        });
                        final response = await apiService.postRequest(
                            'login_check', {
                          "email": username,
                          "password": password
                        }).catchError((err) {
                          showToast("Error de credenciales", error: true);
                          setState(() {
                            loading = false;
                          });
                        });
                        if (response.statusCode == 200) {
                          print("Response is ${response.data}");
                          SharedPreferences.getInstance().then((prefs) {
                            prefs.setString('username', username ?? "");
                            prefs.setString('password', password ?? "");
                            // prefs.setString('jwt', response.data);
                            debugPrint(
                                "Set shared prefernces to $username and $password");
                          });
                          Navigator.of(context).pushNamed('/home');
                        } else {
                          showToast("Error de credenciales", error: true);
                        }
                        setState(() {
                          loading = false;
                        });
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
                      child: loading
                          ? const Center(
                              child: CircularProgressIndicator(
                                color: Colors.white,
                              ),
                            )
                          : const Text(
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
                GestureDetector(
                  onTap: () async {
                    userCredential.value = await signInWithGoogle();
                    if (userCredential.value != null) {
                      print(
                          "User all received is: ${userCredential.value.user!}");
                      print(
                          "User email received is: ${userCredential.value.user!.email}");
                    } else {
                      print("User all received is: null");
                    }
                  },
                  child: Container(
                    width: Responsive.width / 3,
                    height: 36,
                    alignment: Alignment.center,
                    padding: EdgeInsets.symmetric(
                        horizontal: Responsive.padding / 2),
                    decoration: const BoxDecoration(
                        color: Color(0xff131314),
                        borderRadius: BorderRadius.all(Radius.circular(6))),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          height: 24,
                          width: 24,
                          decoration: const BoxDecoration(
                              image: DecorationImage(
                                  image: AssetImage(
                                      'assets/images/google_icon.png'))),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        const Text(
                          "Google",
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 12,
                              color: Colors.white),
                        ),
                      ],
                    ),
                  ),
                ),
                // Center(
                //   child: Card(
                //     elevation: 5,
                //     shape: RoundedRectangleBorder(
                //         borderRadius: BorderRadius.circular(10)),
                //     child: IconButton(
                //       iconSize: 40,
                //       icon: Image.asset(
                //         'assets/images/google_icon.png',
                //       ),
                //       onPressed: () async {
                //         userCredential.value = await signInWithGoogle();
                //         if (userCredential.value != null){
                //           print(
                //               "User email received is: ${userCredential.value.user!.email}");}
                //       },
                //     ),
                //   ),
                // ),
                const SizedBox(width: 20),
                GestureDetector(
                  onTap: () async {
                    userCredential.value = await signInWithGoogle();
                    if (userCredential.value != null) {
                      print(
                          "User email received is: ${userCredential.value.user!.email}");
                    }
                  },
                  child: Container(
                    width: Responsive.width / 3,
                    height: 36,
                    alignment: Alignment.center,
                    padding: EdgeInsets.symmetric(
                        horizontal: Responsive.padding / 2),
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

Future<dynamic> signInWithGoogle() async {
  try {
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

    final GoogleSignInAuthentication? googleAuth =
        await googleUser?.authentication;

    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );

    return await FirebaseAuth.instance.signInWithCredential(credential);
  } on Exception catch (e) {
    print('exception->$e');
  }
}

Future<bool> signOutFromGoogle() async {
  try {
    await FirebaseAuth.instance.signOut();
    return true;
  } on Exception catch (_) {
    return false;
  }
}
