import 'package:flutter/material.dart';
import 'package:qpay_client/common/toast.dart';
import 'package:qpay_client/common/drawer.dart';
import 'package:qpay_client/payment/model/tag.dart';
import 'package:qpay_client/payment/model/transaction.dart';
import 'package:qpay_client/user/model/user.dart';
import 'package:qpay_client/common/responsive.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:qpay_client/common/services/repository.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool loading = false;

  @override
  void initState() {
    SharedPreferences.getInstance().then((prefs) {
      String username = prefs.getString('username') ?? "";
      if (username.isNotEmpty) {
        setState(() {
          loading = true;
        });
        apiService
            .postRequest('user/profile', {"email": username}).then((response) {
          if (response.statusCode == 200) {
            setState(() {
              currentUser = User.fromJson(response.data);
              List<dynamic> myTagsString = response.data['tags'];
              List<dynamic> myTransactionsString = response.data['trxApps'];
              myTags = myTagsString
                  .map(
                    (e) => Tag.fromJson(e),
                  )
                  .toList();
                  myTransactions = myTransactionsString.map(
                    (e) => Transaction.fromJson(e),
                  )
                  .toList();
              print("Received user: $currentUser, with ${myTags.length} tags and with ${myTransactions.length} transactions");
            });
          } else {
            showToast("No se pudo descargar la informacion de usuario",
                error: true);
          }
          setState(() {
            loading = false;
          });
        }).catchError((err) {
          print("Error is $err");
          showToast("No se pudo descargar la informacion de usuario",
              error: true);
          setState(() {
            loading = false;
          });
        });
      }
    });
    super.initState();
  }

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
            const Text("Bienvenido a QPay"),
            const SizedBox(height: 20),
            const Text("Tu balance es"),
            const SizedBox(height: 10),
            loading
                ? const Center(
                    child: CircularProgressIndicator(
                      color: Color(0xfff85f6a),
                    ),
                  )
                : Text(
                    currentUser.balance,
                    style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 24,
                        color: Color(0xfff85f6a)),
                  ),
          ],
        ),
      ),
    );
  }
}
