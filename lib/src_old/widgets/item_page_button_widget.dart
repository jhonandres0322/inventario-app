import 'package:flutter/material.dart';

class ItemPageButton extends StatelessWidget {
  const ItemPageButton({
    super.key,
    required this.text,
    required this.icon,
    required this.routeTo,
  });

  final String text;
  final IconData icon;
  final String routeTo;

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        IconButton(
          onPressed: () {
            Navigator.pushNamed(context, routeTo);
          },
          icon: Icon(icon, size: size.height * 0.1),
        ),
        Text(
          text,
          style: TextStyle(
            fontSize: size.height * 0.03,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}
