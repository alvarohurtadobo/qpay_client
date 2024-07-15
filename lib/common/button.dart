import 'package:flutter/material.dart';

Widget myButton(int number, Function(int) update) {
  return GestureDetector(
    onTap: () {
      update(number);
    },
    child: Container(
      width: 60,
      height: 60,
      alignment: Alignment.center,
      decoration: BoxDecoration(
          border: Border.all(color: Colors.black, width: 1),
          color: Colors.black12),
      child: Text(number.toString()),
    ),
  );
}

Widget myBackButton(VoidCallback update) {
  return GestureDetector(
      onTap: () {
        update();
      },
      child: Container(
        width: 60,
        height: 60,
        alignment: Alignment.center,
        decoration: BoxDecoration(
            border: Border.all(color: Colors.black, width: 1),
            color: Colors.black12),
        child: const Text("D"),
      ));
}

Widget placeHolder() {
  return const SizedBox(width: 60, height: 60);
}
