import 'package:flutter/material.dart';
import 'package:qpay_client/routes.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:qpay_client/firebase_options.dart';
import 'package:qpay_client/common/responsive.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    Responsive.initSizes(size.width, size.height);

    return MaterialApp(
      title: 'QPay client',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      onGenerateRoute: onGenerateRoute,
      initialRoute: '/',
    );
  }
}
