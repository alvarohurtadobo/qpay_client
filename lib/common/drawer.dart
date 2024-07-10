import 'package:flutter/material.dart';

Widget myDrawer(BuildContext context) {
  return Drawer(
    child: ListView(
      padding: EdgeInsets.zero,
      children: <Widget>[
        const DrawerHeader(
          child: Column(
            children: [
              Center(
                child: CircleAvatar(
                  radius: 36,
                  backgroundImage: AssetImage('assets/images/user.png'),
                ),
              ),
              Text(
                'Johana Doe',
                style: TextStyle(
                  color: Colors.grey,
                  fontSize: 24,
                ),
              ),Text(
                'johana@gmail.com',
                style: TextStyle(
                  color: Colors.grey,
                  fontSize: 16,
                ),
              ),
            ],
          ),
        ),
        ListTile(
          leading:const Icon(Icons.home),
          title: const Text('Inicio'),
          onTap: () {
            Navigator.of(context).pushReplacementNamed('/home');
          },
        ),
        ListTile(
          leading: const Icon(Icons.device_unknown_outlined),
          title: const Text('Registrar dispositivo'),
          onTap: () {
            Navigator.of(context).pushReplacementNamed('/register_device');
          },
        ),
        ListTile(
          leading:const Icon(Icons.charging_station),
          title:const Text('Realizar recarga'),
          onTap: () {
            Navigator.of(context).pushReplacementNamed('/charge_amount');
          },
        ),
        ListTile(
          leading:const Icon(Icons.history),
          title: const Text('Historial de recargas'),
          onTap: () {
            Navigator.of(context).pushReplacementNamed('/transaction_history');
          },
        ),
        ListTile(
          leading: const Icon(Icons.exit_to_app),
          title: const Text('Salir'),
          onTap: () {
            Navigator.of(context).pushReplacementNamed('/');
          },
        ),
      ],
    ),
  );
}
