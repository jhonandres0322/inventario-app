import 'package:flutter/material.dart';
import 'package:inventario_app/src/ui/products/download_product/widgets/download_product_bottom_navigator_bar.dart';

class DownloadProductScreen extends StatelessWidget {
  const DownloadProductScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(bottomNavigationBar: DownloadProductBottomNavigatorBar());
  }
}
