import 'package:flutter/material.dart';
import 'package:qpay_client/common/drawer.dart';
import 'package:qpay_client/common/responsive.dart';
import 'package:qpay_client/common/services/repository.dart';
import 'package:qpay_client/common/toast.dart';
import 'package:qpay_client/payment/model/tag.dart';
import 'package:qpay_client/payment/model/transaction.dart';
import 'package:qpay_client/common/components/listTile.dart';
import 'package:qpay_client/user/model/user.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TagTransactionsPage extends StatefulWidget {
  const TagTransactionsPage({super.key});

  @override
  State<TagTransactionsPage> createState() => _TagTransactionsPageState();
}

class _TagTransactionsPageState extends State<TagTransactionsPage> {
  bool loading = false;
  Tag myTag = Tag.empty();

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
              print("All tags are: ${myTags.map(
                (e) => e.id,
              )} currentTag: $currentTag contains: ${myTags.map(
                    (e) => e.id,
                  ).contains(currentTag)}");
              //(d173450d-f24f-4528-bdc6-9593e1351ef9, ea6fa33a-f1cf-4a71-a5fe-f0c0208248e9, 1ce14021-7a5b-4d4a-b931-2b2221a176d0, ..., a6cfff5f-4176-492e-9eeb-05ca3a87c2a3, ae601ce0-6368-4a62-963a-cee39e31a112)
              myTag = myTags.firstWhere((e) => e.id == currentTag, orElse: () {
                showToast("Could not find tag", error: true);
                return Tag.empty();
              });
              myTransactions = myTransactionsString
                  .map(
                    (e) => Transaction.fromJson(e),
                  )
                  .toList();
              print(
                  "Received user: $currentUser, with ${myTags.length} tags and with ${myTransactions.length} transactions");
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
        width: Responsive.width,
        height: Responsive.height,
        padding: EdgeInsets.symmetric(vertical: Responsive.padding),
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
            loading
                ? SizedBox(
                    width: Responsive.width,
                    height: 120,
                    child: const Center(
                      child: CircularProgressIndicator(),
                    ),
                  )
                : SizedBox(
                    width: Responsive.width,
                    height: 120,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          myTag.code,
                          style: const TextStyle(fontSize: 21),
                        ),
                        Text(myTag.tagId),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Text(
                              myTag.disabled ? "Inactivo" : "Activo",
                              style: const TextStyle(fontSize: 21),
                            ),
                            myTag.disabled
                                ? GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        loading = true;
                                      });
                                      apiService.patchRequest('tag/activate',
                                          {"tagId": myTag.id}).then((response) {
                                        if (response.statusCode == 200) {
                                          setState(() {
                                            myTag.disabled = false;
                                            loading = false;
                                          });
                                        } else {
                                          showToast(
                                              "No se pudo dar de baja la manilla",
                                              error: true);
                                        }
                                      });
                                    },
                                    child: const Icon(Icons.restore))
                                : GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        loading = true;
                                      });
                                      apiService.patchRequest('tag/unregister',
                                          {"tagId": myTag.id}).then((response) {
                                        if (response.statusCode == 200) {
                                          setState(() {
                                            myTag.disabled = true;
                                            loading = false;
                                          });
                                        } else {
                                          showToast(
                                              "No se pudo dar de baja la manilla",
                                              error: true);
                                        }
                                      });
                                    },
                                    child: const Icon(Icons.delete)),
                          ],
                        )
                      ],
                    ),
                  ),
            Column(
              children: myTag.trxApps.reversed
                  .map(
                    (e) => getTile(
                        e.detail,
                        e.dateAdd
                            .toIso8601String()
                            .substring(0, 16)
                            .replaceAll("T", ' '),
                        e.amount,
                        Icons.timer),
                  )
                  .toList(),
            )
          ],
        ),
      ),
    );
  }
}


// apiService.patchRequest('tag/unregister',
//                               {"tagId": e.id}).then((response) {
//                             if (response.statusCode == 200) {
//                               setState(() {
//                                 myTags
//                                     .firstWhere((t) => t.tagId == e.tagId)
//                                     .disabled = true;
//                               });
//                             } else {
//                               showToast("No se pudo dar de baja la manilla",
//                                   error: true);
//                             }
//                           });