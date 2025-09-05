import 'package:flutter/material.dart';
import 'package:inventario_app/src/ui/core/themes/app_colors.dart';

class DetailProductAppBar extends StatelessWidget
    implements PreferredSizeWidget {
  const DetailProductAppBar({super.key, required this.productName});

  final double height = 48;
  final String productName;

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return AppBar(
      title: Tooltip(
        message: productName,
        child: Text(productName, overflow: TextOverflow.ellipsis),
      ),
      actions: [
        IconButton(
          onPressed: () {},
          icon: Icon(Icons.delete, color: AppColors().textAppBar),
          highlightColor: AppColors().textAppBar,
        ),
        SizedBox(width: size.width * 0.01),
      ],
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(height);
}
