import 'package:flutter/material.dart';

Widget getTile(String title, String subtitle, String trailMessage, String type,
    IconData icon) {
  bool isNegative = type == "POS_CHARGE";
  double value = double.tryParse(trailMessage) ?? 0;
  if (isNegative) {
    value = -value;
  }
  return Container(
    margin: const EdgeInsets.only(bottom: 10),
    decoration: const BoxDecoration(
        color: Colors.black12,
        border: Border(bottom: BorderSide(color: Color(0xfff85f6a)))),
    child: ListTile(
      leading: Icon(icon, color: const Color(0xfff85f6a)),
      title: Text(
        title,
        style: const TextStyle(fontWeight: FontWeight.bold),
      ),
      subtitle: Text(subtitle),
      trailing: Text(
        value.toStringAsFixed(2),
        style: TextStyle(
            fontSize: 18, color: isNegative ? Colors.red : Colors.grey),
      ),
    ),
  );
}
