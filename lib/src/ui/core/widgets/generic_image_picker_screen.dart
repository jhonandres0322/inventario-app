import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class GenericImagePickerScreen extends StatefulWidget {
  final Function(File? file) onImageSelected;

  const GenericImagePickerScreen({super.key, required this.onImageSelected});

  @override
  State<GenericImagePickerScreen> createState() =>
      _GenericImagePickerScreenState();
}

class _GenericImagePickerScreenState extends State<GenericImagePickerScreen> {
  final ImagePicker _picker = ImagePicker();
  File? _selectedImage;

  Future<void> _pickImage(ImageSource source) async {
    try {
      final XFile? pickedFile = await _picker.pickImage(
        source: source,
        imageQuality: 75,
      );

      if (pickedFile != null) {
        setState(() {
          _selectedImage = File(pickedFile.path);
        });

        widget.onImageSelected(_selectedImage);
      }
    } catch (e) {
      debugPrint("Error al seleccionar imagen: $e");
    }
  }

  void _removeImage() {
    setState(() {
      _selectedImage = null;
    });

    widget.onImageSelected(null);
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Column(
      children: [
        // CONTAINER PRINCIPAL
        Container(
          height: size.height * 0.5,
          width: double.infinity,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: Colors.grey.shade400),
            color: Colors.grey.shade100,
          ),
          child: _selectedImage == null
              ? _buildButtons()
              : _buildImagePreview(),
        ),

        const SizedBox(height: 10),
      ],
    );
  }

  Widget _buildButtons() {
    return Center(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ElevatedButton.icon(
            onPressed: () => _pickImage(ImageSource.camera),
            icon: const Icon(Icons.camera_alt),
            label: const Text("Tomar foto"),
          ),
          const SizedBox(width: 16),
          ElevatedButton.icon(
            onPressed: () => _pickImage(ImageSource.gallery),
            icon: const Icon(Icons.image),
            label: const Text("Galería"),
          ),
        ],
      ),
    );
  }

  Widget _buildImagePreview() {
    return Stack(
      fit: StackFit.expand,
      children: [
        // Imagen
        ClipRRect(
          borderRadius: BorderRadius.circular(16),
          child: Image.file(_selectedImage!, fit: BoxFit.cover),
        ),

        // Capa oscura con check
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            // ignore: deprecated_member_use
            color: Colors.black.withOpacity(0.25),
          ),
        ),

        // Icono de check ✔️
        const Center(
          child: Icon(Icons.check_circle, size: 60, color: Colors.white),
        ),

        // 🔥 Botón para borrar imagen
        Positioned(
          top: 10,
          right: 10,
          child: CircleAvatar(
            radius: 20,
            // ignore: deprecated_member_use
            backgroundColor: Colors.black.withOpacity(0.6),
            child: IconButton(
              icon: const Icon(Icons.close, color: Colors.white),
              onPressed: _removeImage,
            ),
          ),
        ),
      ],
    );
  }
}
