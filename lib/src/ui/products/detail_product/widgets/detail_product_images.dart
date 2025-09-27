import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';

class DetailProductImages extends StatelessWidget {
  const DetailProductImages({super.key, required this.images});
  final List<String> images;

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Container(
      margin: EdgeInsets.only(top: size.height * 0.02),
      height: size.height * 0.4,
      child: PageView.builder(
        itemCount: images.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: GestureDetector(
              onTap: () {
                // Navegar a la vista ampliada al hacer tap
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        FullScreenImageViewer(imageUrl: images[index]),
                  ),
                );
              },
              child: ClipRRect(
                borderRadius: BorderRadius.circular(8.0),
                child: CachedNetworkImage(
                  imageUrl: images[index],
                  fit: BoxFit.fitHeight,
                  width: double.infinity,
                  placeholder: (context, url) =>
                      const Center(child: CircularProgressIndicator()),
                  errorWidget: (context, url, error) =>
                      const Center(child: Icon(Icons.broken_image, size: 100)),
                  // Habilitar caché para optimizar la carga
                  memCacheHeight: (size.height * 0.4).round(),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

// Nueva pantalla para la vista ampliada con zoom
class FullScreenImageViewer extends StatelessWidget {
  final String imageUrl;

  const FullScreenImageViewer({super.key, required this.imageUrl});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          Center(
            child: InteractiveViewer(
              panEnabled: true, // Permitir desplazamiento
              scaleEnabled: true, // Permitir zoom
              minScale: 0.5, // Zoom mínimo
              maxScale: 4.0, // Zoom máximo
              child: CachedNetworkImage(
                imageUrl: imageUrl,
                fit: BoxFit.contain,
                placeholder: (context, url) => const Center(
                  child: CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                  ),
                ),
                errorWidget: (context, url, error) => const Center(
                  child: Icon(
                    Icons.broken_image,
                    size: 100,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
          // Botón de cerrar
          Positioned(
            top: 40,
            right: 20,
            child: IconButton(
              icon: const Icon(Icons.close, color: Colors.white, size: 30),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ),
        ],
      ),
    );
  }
}
