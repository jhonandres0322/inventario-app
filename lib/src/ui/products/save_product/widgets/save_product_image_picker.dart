import 'package:flutter/material.dart';
import 'package:inventario_app/src/ui/core/widgets/generic_image_picker_screen.dart';
import 'package:inventario_app/src/ui/products/save_product/viewmodels/save_product_provider.dart';
import 'package:provider/provider.dart';

class SaveProductImagePicker {
  const SaveProductImagePicker();

  static showModal(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (_) {
        final vm = context.watch<SaveProductProvider>();
        return Padding(
          padding: EdgeInsets.all(15),
          child: GenericImagePickerScreen(
            onImageSelected: (file) {
              vm.selectedImage = file;
            },
          ),
        );
      },
    );
  }
}
