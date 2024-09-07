import 'package:flutter/material.dart';
import 'package:qpay_client/common/toast.dart';
import 'package:qpay_client/common/drawer.dart';
import 'package:qpay_client/user/model/user.dart';
import 'package:qpay_client/payment/model/tag.dart';
import 'package:qpay_client/common/responsive.dart';
import 'package:qpay_client/common/components/tagTile.dart';
import 'package:qpay_client/payment/model/transaction.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:qpay_client/common/services/repository.dart';

class RegisteredTagsPage extends StatefulWidget {
  const RegisteredTagsPage({super.key});

  @override
  State<RegisteredTagsPage> createState() => _RegisteredTagsPageState();
}

class _RegisteredTagsPageState extends State<RegisteredTagsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      drawer: myDrawer(context),
      body: Container(
        padding: EdgeInsets.symmetric(vertical: Responsive.padding),
        width: Responsive.width,
        height: Responsive.height,
        child: ListView(
          children: [
            const SizedBox(height: 50),
            Container(
              width: Responsive.width,
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
            const SizedBox(height: 40),
            Column(
                children: myTags
                    .map((e) => getTagTile(
                            e.code,
                            e.tagId,
                            //e.dateAdd.toIso8601String().substring(0, 10),
                            e.balance,
                            Icons.tag,
                            !e.disabled, () {
                          currentTag = e.id;
                          print("Selecting tagId: $currentTag");
                          Navigator.of(context).pushNamed('/tag').then((res) {
                            SharedPreferences.getInstance().then((prefs) {
                              String username =
                                  prefs.getString('username') ?? "";
                              if (username.isNotEmpty) {
                                apiService.postRequest('user/profile',
                                    {"email": username}).then((response) {
                                  if (response.statusCode == 200) {
                                    setState(() {
                                      currentUser =
                                          User.fromJson(response.data);
                                      List<dynamic> myTagsString =
                                          response.data['tags'];
                                      List<dynamic> myTransactionsString =
                                          response.data['trxApps'];
                                      myTags = myTagsString
                                          .map(
                                            (e) => Tag.fromJson(e),
                                          )
                                          .toList();
                                      print("All tags are: ${myTags.map(
                                        (e) => e.id,
                                      )} currentTag: $currentTag contains: ${myTags.map(
                                            (e) => e.id,
                                          ).contains(currentTag)}");
                                      //(d173450d-f24f-4528-bdc6-9593e1351ef9, ea6fa33a-f1cf-4a71-a5fe-f0c0208248e9, 1ce14021-7a5b-4d4a-b931-2b2221a176d0, ..., a6cfff5f-4176-492e-9eeb-05ca3a87c2a3, ae601ce0-6368-4a62-963a-cee39e31a112)

                                      myTransactions = myTransactionsString
                                          .map(
                                            (e) => Transaction.fromJson(e),
                                          )
                                          .toList();
                                      print(
                                          "Received user: $currentUser, with ${myTags.length} tags and with ${myTransactions.length} transactions");
                                    });
                                  } else {
                                    showToast(
                                        "No se pudo descargar la informacion de usuario",
                                        error: true);
                                  }
                                  setState(() {});
                                }).catchError((err) {
                                  print("Error is $err");
                                  showToast(
                                      "No se pudo descargar la informacion de usuario",
                                      error: true);
                                  setState(() {});
                                });
                              }
                            });
                          });
                        }))
                    .toList())
          ],
        ),
      ),
    );
  }
}
