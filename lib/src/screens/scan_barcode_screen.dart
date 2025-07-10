import 'package:flutter/material.dart';
import 'package:inventario_app/src/providers/load_product_provider.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:provider/provider.dart';

class ScanBarcodeScreen extends StatelessWidget {
  const ScanBarcodeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Escaneo de Código de Barras')),
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          MobileScanner(
            onDetect: (BarcodeCapture capture) {
              final barcode = capture.barcodes.firstOrNull;
              if (barcode != null) {
                context.read<LoadProductProvider>().setBarcode(barcode);
              }
            },
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
                  Expanded(
                    child: Center(
                      child: Consumer<LoadProductProvider>(
                        builder: (_, provider, __) {
                          final value = provider.barcode?.displayValue;
                          return Text(
                            value ?? 'Código',
                            overflow: TextOverflow.fade,
                            style: const TextStyle(color: Colors.white),
                          );
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: Consumer<LoadProductProvider>(
        builder: (_, provider, __) {
          final value = provider.barcode?.displayValue;

          return FloatingActionButton.extended(
            onPressed: value != null
                ? () {
                    Navigator.pop(context, value);
                  }
                : null,
            label: const Text('Capturar'),
            icon: const Icon(Icons.check),
            backgroundColor: value != null ? Colors.deepPurple : Colors.grey,
          );
        },
      ),
    );
  }
}
