import 'package:flutter/material.dart';

import 'package:inventario_app/src/ui/admin/widgets/admin_body.dart';

class AdminScreen extends StatelessWidget {
  const AdminScreen({super.key});

  final String _titleText = 'Panel de Administración';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(_titleText)),
      body: AdminBody(),
    );
  }
}
