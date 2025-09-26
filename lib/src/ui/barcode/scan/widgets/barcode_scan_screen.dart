import 'package:flutter/material.dart';
import 'package:inventario_app/src/ui/barcode/scan/widgets/barcode_scan_body.dart';

class BarcodeScanScreen extends StatelessWidget {
  const BarcodeScanScreen({super.key, required this.onBarcodeScanned});

  final Function(String) onBarcodeScanned;

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: BarcodeScanBody(onBarcodeScanned: onBarcodeScanned));
  }
}
