import 'package:flutter/material.dart';
import 'package:qpay_client/common/responsive.dart';
import 'package:qpay_client/common/services/repository.dart';
import 'package:qpay_client/common/toast.dart';
import 'package:shared_preferences/shared_preferences.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  bool hidden = true;
  final _formKey = GlobalKey<FormState>();

  String email = '';
  String firstname = '';
  String surname = '';
  String phone = '';
  String password = '';

  bool loading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: Responsive.width,
        height: Responsive.height,
        padding: EdgeInsets.all(Responsive.padding),
        child: ListView(children: [
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
                      "Email",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                          color: Color(0xfff85f6a)),
                    )),
                TextFormField(
                  onChanged: (val) {
                    email = val;
                  },
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
                  onChanged: (val) {
                    firstname = val;
                  },
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
                  onChanged: (val) {
                    surname = val;
                  },
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
                  onChanged: (val) {
                    phone = val;
                  },
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
                    if (loading) {
                      return;
                    }
                    bool? success = _formKey.currentState?.validate();
                    if (success == true) {
                      setState(() {
                        loading = true;
                      });
                      apiService.postRequest('app/register', {
                        "name": "$firstname $surname",
                        "email": email,
                        "password": password,
                        "phone": phone
                      }).then((res) {
                        if (res.statusCode == 201) {
                          showToast(
                              "Usuario creado exitosamente, por favor inicie sesion");
                          SharedPreferences.getInstance().then((prefs) {
                            prefs.setString('username', email);
                            Navigator.of(context).pushReplacementNamed('/');
                          });
                        }
                        setState(() {
                          loading = false;
                        });
                      }).catchError((err) {
                        print("No se pudo crear usuario por error: $err");
                        showToast("No se pudo crear", error: true);
                        setState(() {
                          loading = false;
                        });
                      });
                      // showToast("Función aún no implementada", error: true);
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
