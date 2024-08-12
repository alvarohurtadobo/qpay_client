import 'package:flutter/material.dart';
import 'package:qpay_client/common/drawer.dart';
import 'package:qpay_client/common/responsive.dart';
import 'package:qpay_client/common/services/repository.dart';
import 'package:qpay_client/common/toast.dart';
import 'package:qpay_client/payment/model/tag.dart';
import 'package:qpay_client/common/components/tagTile.dart';

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
        child: Column(
          children: [
            const SizedBox(height: 50),
            Container(
              width: Responsive.width,
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
            const SizedBox(height: 40),
            Column(
                children: myTags
                    .map((e) => getTagTile(
                            e.code,
                            e.tagId,
                            e.dateAdd.toIso8601String().substring(0, 10),
                            Icons.tag,
                            !e.disabled, () {
                          currentTag = e.id;
                          print("Selecting tagId: $currentTag");
                          Navigator.of(context).pushNamed('/tag');
                        }))
                    .toList())
          ],
        ),
      ),
    );
  }
}
