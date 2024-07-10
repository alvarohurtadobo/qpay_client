import 'package:flutter/material.dart';

Widget myButton(String number) {
  return Container(
    width: 60,
    height: 60,
    alignment: Alignment.center,
    decoration: BoxDecoration(
        border: Border.all(color: Colors.black, width: 1), color: Colors.black12),
    child: Text(number),
  );
}
