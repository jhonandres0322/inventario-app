import 'package:flutter/material.dart';

class TileInfoCardWidget extends StatelessWidget {
  const TileInfoCardWidget({
    super.key,
    required this.title,
    required this.infoItems,
    required this.trailingItems,
    required this.onTap,
  });

  final String title;
  final List<InfoItem> infoItems;
  final List<InfoItem> trailingItems;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: InkWell(
        borderRadius: BorderRadius.circular(10),
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                        color: Colors.black87,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Wrap(
                      spacing: 12,
                      runSpacing: 4,
                      children: infoItems
                          .map((item) => item.toWidget())
                          .toList(),
                    ),
                  ],
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: trailingItems.map((item) => item.toWidget()).toList(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class InfoItem {
  final IconData icon;
  final String text;
  final Color? color;

  InfoItem(this.icon, this.text, {this.color});

  Widget toWidget() {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, size: 16, color: color ?? Colors.grey),
        const SizedBox(width: 4),
        Text(
          text,
          style: TextStyle(fontSize: 14, color: color ?? Colors.grey.shade700),
        ),
      ],
    );
  }
}
