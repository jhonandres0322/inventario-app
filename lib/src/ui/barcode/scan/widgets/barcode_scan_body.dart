import 'package:flutter/material.dart';
import 'package:inventario_app/src/ui/barcode/scan/widgets/barcode_scan_guide.dart';
import 'package:inventario_app/src/ui/core/themes/app_colors.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

class BarcodeScanBody extends StatefulWidget {
  const BarcodeScanBody({super.key, required this.onBarcodeScanned});

  final Function(String) onBarcodeScanned;

  @override
  State<BarcodeScanBody> createState() => _BarcodeScanBodyState();
}

class _BarcodeScanBodyState extends State<BarcodeScanBody> {
  String? _barcodeValue;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        MobileScanner(
          onDetect: (BarcodeCapture capture) {
            final barcode = capture.barcodes.firstOrNull;
            if (barcode != null && barcode.displayValue != null) {
              setState(() {
                _barcodeValue = barcode.displayValue;
              });
              widget.onBarcodeScanned(barcode.displayValue!);
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
                    child: Text(
                      _barcodeValue ?? 'Código',
                      overflow: TextOverflow.fade,
                      style: TextStyle(color: AppColors().textAppBar),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        BarcodeScanGuide(),
        Align(
          alignment: Alignment.bottomRight,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: FloatingActionButton.extended(
              onPressed: _barcodeValue != null
                  ? () {
                      Navigator.pop(context);
                    }
                  : null,
              label: const Text('Capturar'),
              icon: const Icon(Icons.check),
              backgroundColor: _barcodeValue != null
                  ? AppColors().secondary
                  : Colors.grey,
            ),
          ),
        ),
      ],
    );
  }
}
