import 'package:flutter/material.dart';
import 'package:qpay_client/payment/views/charge_tag.dart';
import 'package:qpay_client/payment/views/tag_transactions.dart';
import 'package:qpay_client/user/views/home.dart';
import 'package:qpay_client/user/views/login.dart';
import 'package:qpay_client/user/views/register.dart';
import 'package:qpay_client/payment/views/qr_view.dart';
import 'package:qpay_client/payment/views/register.dart';
import 'package:qpay_client/payment/views/device_added.dart';
import 'package:qpay_client/payment/views/charge_amount.dart';
import 'package:qpay_client/user/views/recover_passwords.dart';
import 'package:qpay_client/payment/views/registered_tags.dart';
import 'package:qpay_client/payment/views/last_transactions.dart';
import 'package:qpay_client/user/views/scanner.dart';

Route<dynamic> onGenerateRoute(RouteSettings settings) {
  switch (settings.name) {
    case '/':
      return MaterialPageRoute(builder: (_) => const LoginPage());
    case '/recover':
      return MaterialPageRoute(builder: (_) => const RecoverPasswordPage());
    case '/register':
      return MaterialPageRoute(builder: (_) => const RegisterPage());
    case '/home':
      return MaterialPageRoute(builder: (_) => const HomePage());
    case '/register_device':
      return MaterialPageRoute(builder: (_) => const RegisterDevicePage());
    case '/device_registered':
      return MaterialPageRoute(builder: (_) => const DeviceRegisteredPage());
    case '/transaction_history':
      return MaterialPageRoute(builder: (_) => const TransactionHistoryPage());
    case '/tags':
      return MaterialPageRoute(builder: (_) => const RegisteredTagsPage());
    case '/charge_amount':
      return MaterialPageRoute(builder: (_) => const ChargeAmountPage());
    case '/charge_tag':
      return MaterialPageRoute(builder: (_) => const ChargeTagPage());
    case '/qr_view':
      return MaterialPageRoute(builder: (_) => const QrViewPage());
    case '/tag':
      return MaterialPageRoute(builder: (_) => const TagTransactionsPage());
    case '/scanner':
      return MaterialPageRoute(builder: (_) => const BarcodeScannerSimple());
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
