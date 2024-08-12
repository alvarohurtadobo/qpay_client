import 'package:flutter/material.dart';

Widget getTagTile(String title, String subtitle, String trailMessage,
    IconData icon, bool active, VoidCallback callback) {
  return Container(
    margin: const EdgeInsets.only(bottom: 10),
    decoration: BoxDecoration(
        color: Colors.black12,
        border: Border(
            bottom: BorderSide(
                color: active ? const Color(0xfff85f6a) : Colors.black38))),
    child: ListTile(
      leading:
          Icon(icon, color: active ? const Color(0xfff85f6a) : Colors.black38),
      title: Text(
        title,
        style: const TextStyle(fontWeight: FontWeight.bold),
      ),
      subtitle: Text(subtitle),
      trailing: Text(
          trailMessage), //active ? const Icon(Icons.delete) : Text(trailMessage),
      onTap: callback,
    ),
  );
}
