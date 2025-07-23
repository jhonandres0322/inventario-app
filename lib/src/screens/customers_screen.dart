import 'package:flutter/material.dart';
import 'package:inventario_app/src/widgets/tile_info_card_widget.dart';

class CustomersScreen extends StatelessWidget {
  const CustomersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Clientes'), bottom: _SearchCustomersWidget()),
      body: Builder(
        builder: (context) {
          return SizedBox.expand(child: _ListCustomers());
        },
      ),
    );
  }
}

class _ListCustomers extends StatelessWidget {
  const _ListCustomers();

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        TileInfoCardWidget(
          title: 'Pedro Perez',
          infoItems: [
            InfoItem(Icons.phone, '312 458 1245'),
            InfoItem(Icons.location_on, 'Antonia Santos'),
          ],
          trailingItems: [InfoItem(Icons.visibility, 'Ver')],
          onTap: () {},
        ),
        TileInfoCardWidget(
          title: 'Pedro Perez',
          infoItems: [
            InfoItem(Icons.phone, '312 458 1245'),
            InfoItem(Icons.location_on, 'Antonia Santos'),
          ],
          trailingItems: [InfoItem(Icons.visibility, 'Ver')],
          onTap: () {},
        ),
        TileInfoCardWidget(
          title: 'Pedro Perez',
          infoItems: [
            InfoItem(Icons.phone, '312 458 1245'),
            InfoItem(Icons.location_on, 'Antonia Santos'),
          ],
          trailingItems: [InfoItem(Icons.visibility, 'Ver')],
          onTap: () {},
        ),
        TileInfoCardWidget(
          title: 'Pedro Perez',
          infoItems: [
            InfoItem(Icons.phone, '312 458 1245'),
            InfoItem(Icons.location_on, 'Antonia Santos'),
          ],
          trailingItems: [InfoItem(Icons.visibility, 'Ver')],
          onTap: () {},
        ),
        TileInfoCardWidget(
          title: 'Pedro Perez',
          infoItems: [
            InfoItem(Icons.phone, '312 458 1245'),
            InfoItem(Icons.location_on, 'Antonia Santos'),
          ],
          trailingItems: [InfoItem(Icons.visibility, 'Ver')],
          onTap: () {},
        ),
        TileInfoCardWidget(
          title: 'Pedro Perez',
          infoItems: [
            InfoItem(Icons.phone, '312 458 1245'),
            InfoItem(Icons.location_on, 'Antonia Santos'),
          ],
          trailingItems: [InfoItem(Icons.visibility, 'Ver')],
          onTap: () {},
        ),
        TileInfoCardWidget(
          title: 'Pedro Perez',
          infoItems: [
            InfoItem(Icons.phone, '312 458 1245'),
            InfoItem(Icons.location_on, 'Antonia Santos'),
          ],
          trailingItems: [InfoItem(Icons.visibility, 'Ver')],
          onTap: () {},
        ),
      ],
    );
  }
}

class _SearchCustomersWidget extends StatelessWidget
    implements PreferredSizeWidget {
  const _SearchCustomersWidget();

  @override
  Size get preferredSize => const Size.fromHeight(56);

  @override
  Widget build(BuildContext context) {
    return PreferredSize(
      preferredSize: const Size.fromHeight(48.0),
      child: Padding(
        padding: const EdgeInsetsGeometry.symmetric(
          horizontal: 16,
          vertical: 8,
        ),
        child: TextField(
          decoration: InputDecoration(
            hintText: 'Buscar por nombre',
            prefixIcon: const Icon(Icons.search),
            filled: true,
            fillColor: Colors.white,
            contentPadding: const EdgeInsets.symmetric(vertical: 0),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide.none,
            ),
          ),
        ),
      ),
    );
  }
}
