import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:qpay_client/common/constants.dart';

class BarcodeScannerSimple extends StatefulWidget {
  const BarcodeScannerSimple({super.key});

  @override
  State<BarcodeScannerSimple> createState() => _BarcodeScannerSimpleState();
}

class _BarcodeScannerSimpleState extends State<BarcodeScannerSimple> {
  Barcode? _barcode;
  bool oneDetected = false;

  Widget _buildBarcode(Barcode? value) {
    if (value == null) {
      return GestureDetector(
        onTap: () => Navigator.of(context).pop(),
        child: const Text(
          'Cancelar',
          overflow: TextOverflow.fade,
          style: TextStyle(color: Colors.white),
        ),
      );
    }

    return Text(
      value.displayValue ?? 'No display value.',
      overflow: TextOverflow.fade,
      style: const TextStyle(color: Colors.white),
    );
  }

  void _handleBarcode(BarcodeCapture barcodes) {
    if (mounted) {
      setState(() {
        _barcode = barcodes.barcodes.firstOrNull;
      });

      if (_barcode != null) {
        print("Detected _barcode : ${_barcode!.rawValue}");
        detectedCode = _barcode!.rawValue ?? "";
        // Navigator.of(context).pop();
      }
      if (!oneDetected) {
        Navigator.of(context).pop();
        oneDetected = true;
      }else{
        print("Detected _barcode pass");
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Escanear código manilla')),
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          MobileScanner(
            onDetect: _handleBarcode,
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              alignment: Alignment.bottomCenter,
              height: 100,
              color: Colors.black.withOpacity(0.4),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Expanded(child: Center(child: _buildBarcode(_barcode))),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
