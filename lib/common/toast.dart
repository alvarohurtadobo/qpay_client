import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

void showToast(String message, {bool error = false}) {
  Fluttertoast.showToast(
    msg: message,
    backgroundColor: error ? Colors.red : Colors.green,
    textColor: Colors.white,
    fontSize: 16,
    gravity: ToastGravity.CENTER,
  );
}
