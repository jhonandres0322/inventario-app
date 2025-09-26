import 'package:flutter/material.dart';

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
            child: ClipRRect(
              child: Image.network(
                images[index],
                fit: BoxFit.fitHeight,
                width: double.infinity,
                loadingBuilder: (context, child, progress) {
                  if (progress == null) return child;
                  return const Center(child: CircularProgressIndicator());
                },
                errorBuilder: (context, error, stackTrace) =>
                    const Center(child: Icon(Icons.broken_image, size: 100)),
              ),
            ),
          );
        },
      ),
    );
  }
}
