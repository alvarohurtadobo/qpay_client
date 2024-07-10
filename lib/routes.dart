import 'package:flutter/material.dart';
import 'package:qpay_client/user/views/home.dart';
import 'package:qpay_client/user/views/login.dart';
import 'package:qpay_client/payment/views/qr_view.dart';
import 'package:qpay_client/payment/views/register.dart';
import 'package:qpay_client/payment/views/device_added.dart';
import 'package:qpay_client/payment/views/charge_amount.dart';
import 'package:qpay_client/payment/views/last_transactions.dart';

Route<dynamic> onGenerateRoute(RouteSettings settings) {
  print("On generate route with name: ${settings.name}");
  switch (settings.name) {
    case '/':
      return MaterialPageRoute(builder: (_) => const LoginPage());
    case '/home':
      return MaterialPageRoute(builder: (_) => const HomePage());
    case '/register_device':
      return MaterialPageRoute(builder: (_) => const RegisterDevicePage());
    case '/device_registered':
      return MaterialPageRoute(builder: (_) => const DeviceRegisteredPage());
    case '/transaction_history':
      return MaterialPageRoute(builder: (_) => const TransactionHistoryPage());
    case '/charge_amount':
      return MaterialPageRoute(builder: (_) => const ChargeAmountPage());
    case '/qr_view':
      return MaterialPageRoute(builder: (_) => const QrViewPage());
    default:
      return _errorRoute();
  }
}

Route<dynamic> _errorRoute() {
  return MaterialPageRoute(builder: (_) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Error'),
      ),
      body: const Center(
        child: Text('Page not found!'),
      ),
    );
  });
}
