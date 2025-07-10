import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

class ScanBarcodeScreen extends StatelessWidget {
  const ScanBarcodeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    Barcode? barcode;
    return Scaffold(
      appBar: AppBar(title: Text('Escanear Código de Barras')),
      body: Stack(
        children: [
          MobileScanner(controller: MobileScannerController()),
          Center(
            child: Container(
              width: size.width * 0.9,
              height: size.height * 0.25,
              decoration: BoxDecoration(
                border: Border.all(color: Colors.white, width: 2),
                borderRadius: BorderRadius.circular(12),
                color: Colors.transparent,
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              alignment: Alignment.bottomCenter,
              height: 100,
              color: const Color.fromRGBO(0, 0, 0, 0.4),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Expanded(child: Center(child: _barcodePreview(barcode))),
                ],
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          log('Capturando código de barras');
        },
        child: Icon(Icons.barcode_reader),
      ),
    );
  }

  Widget _barcodePreview(Barcode? value) {
    if (value == null) {
      return const Text(
        'Escanea el código',
        overflow: TextOverflow.fade,
        style: TextStyle(color: Colors.white),
      );
    }
    return Text(
      value.displayValue ?? 'Valor no mostrado!',
      overflow: TextOverflow.fade,
      style: const TextStyle(color: Colors.white),
    );
  }
}
