// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:inventario_app/src/core/ui/app_colors.dart';
import 'package:inventario_app/src/models/product_model.dart';
import 'package:inventario_app/src/providers/detail_product_provider.dart';
import 'package:inventario_app/src/widgets/snackbar_custom_widget.dart';
import 'package:inventario_app/src/widgets/text_form_field_widget.dart';
import 'package:provider/provider.dart';

class DetalleProductoScreen extends StatelessWidget {
  const DetalleProductoScreen({super.key, required this.producto});

  final ProductModel producto;

  @override
  Widget build(BuildContext context) {
    final List<String> imagenes = [
      if (producto.foto1.isNotEmpty) producto.foto1,
      if (producto.foto2.isNotEmpty) producto.foto2,
    ];
    final size = MediaQuery.of(context).size;
    final DetailProductProvider provider = Provider.of<DetailProductProvider>(
      context,
    );
    final formatter = NumberFormat.currency(
      locale: 'es_CO',
      symbol: '\$',
      decimalDigits: 0,
    );

    return Scaffold(
      appBar: AppBar(
        title: Tooltip(
          message: producto.nombre,
          child: Text(producto.nombre, overflow: TextOverflow.ellipsis),
        ),
        actions: [
          IconButton(
            onPressed: () {
              _showConfirmForDelete(
                context: context,
                onConfirm: () => provider.deleteProduct(producto),
                onDoneRedirect: () => Navigator.pop(context),
              );
            },
            icon: Icon(Icons.delete, color: AppColors().textAppBar),
            highlightColor: AppColors().textAppBar,
          ),
          SizedBox(width: size.width * 0.01),
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: EdgeInsets.only(top: size.height * 0.02),
            height: size.height * 0.4,
            child: PageView.builder(
              itemCount: imagenes.length,
              controller: PageController(viewportFraction: 0.9),
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  child: ClipRRect(
                    child: Image.network(
                      imagenes[index],
                      fit: BoxFit.fitHeight,
                      width: double.infinity,
                      loadingBuilder: (context, child, progress) {
                        if (progress == null) return child;
                        return const Center(child: CircularProgressIndicator());
                      },
                      errorBuilder: (context, error, stackTrace) =>
                          const Center(
                            child: Icon(Icons.broken_image, size: 100),
                          ),
                    ),
                  ),
                );
              },
            ),
          ),

          SizedBox(height: size.height * 0.05),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: size.width * 0.05),
            child: Card(
              color: AppColors().secondary,
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: [
                    _buildInfoRow(Icons.straighten, 'Talla', producto.talla),
                    const Divider(),
                    _buildInfoRow(Icons.store, 'Marca', producto.marca),
                    const Divider(),
                    _buildInfoRow(
                      Icons.price_check,
                      'Precio',
                      formatter.format(double.parse(producto.precioCompra)),
                    ),
                    const Divider(),
                    _buildInfoRow(
                      Icons.inventory_2,
                      'Cantidad disponible',
                      producto.cantidad,
                    ),
                    const Divider(),
                    _buildInfoRow(
                      Icons.price_check,
                      'Costo Real',
                      formatter.format(double.parse(producto.costoReal)),
                    ),
                    const Divider(),
                    _buildInfoRow(
                      Icons.price_check,
                      'Comisión',
                      formatter.format(double.parse(producto.comision)),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => _showEditProductModal(context, producto),
        label: Row(
          children: [
            Icon(Icons.edit),
            SizedBox(width: size.width * 0.01),
            Text('Editar'),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoRow(IconData icon, String label, String value) {
    return Row(
      children: [
        Icon(icon, color: AppColors().primary),
        const SizedBox(width: 12),
        Text(
          '$label:',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w600,
            color: AppColors().primary,
          ),
        ),
        const SizedBox(width: 8),
        Expanded(
          child: Text(
            value,
            style: TextStyle(fontSize: 18, color: AppColors().primary),
          ),
        ),
      ],
    );
  }

  void _showEditProductModal(
    BuildContext context,
    ProductModel productToUpdate,
  ) {
    final provider = context.read<DetailProductProvider>();
    provider.changeValuePriceForm(productToUpdate.precioCompra);
    provider.changeValueQuantityForm(productToUpdate.cantidad);
    final Size size = MediaQuery.of(context).size;

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return Padding(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom,
            top: 20,
            left: 20,
            right: 20,
          ),
          child: Form(
            key: provider.formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text('Editar Producto'),
                SizedBox(height: size.height * 0.03),
                TextFormFieldWidget(
                  hintText: 'Ej: 30000',
                  labelText: 'Precio de Compra',
                  validator: (value) => provider.validateNumberForm(value),
                  keyboardType: TextInputType.number,
                  controller: provider.priceController,
                ),
                SizedBox(height: size.height * 0.03),
                TextFormFieldWidget(
                  hintText: 'Ej: 10',
                  labelText: 'Cantidad',
                  validator: (value) => provider.validateNumberForm(value),
                  keyboardType: TextInputType.number,
                  controller: provider.quantityController,
                ),
                SizedBox(height: size.height * 0.03),
                ElevatedButton.icon(
                  onPressed: () async {
                    final bool response = await provider.updateProduct(
                      productToUpdate,
                    );
                    String message = response
                        ? 'Producto actualizado!'
                        : 'Error al editar el producto';
                    Navigator.pop(context);
                    SnackbarCustomWidget.show(
                      context,
                      message: message,
                      type: response
                          ? SnackbarType.success
                          : SnackbarType.error,
                    );
                  },
                  icon: Icon(Icons.save),
                  label: Text('Guardar cambios'),
                ),
                SizedBox(height: size.height * 0.03),
              ],
            ),
          ),
        );
      },
    );
  }

  Future<void> _showConfirmForDelete({
    required BuildContext context,
    required Future<void> Function() onConfirm,
    required VoidCallback onDoneRedirect,
    String titulo = '¿Estás seguro?',
    String mensaje = '¿Deseas eliminar el producto?',
  }) async {
    final confirmed = await showDialog<bool>(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return AlertDialog(
          title: Text(titulo),
          content: Text(mensaje),
          actions: [
            TextButton(
              child: const Text('Cancelar'),
              onPressed: () => Navigator.of(context).pop(false),
            ),
            ElevatedButton(
              child: const Text('Aceptar'),
              onPressed: () => Navigator.of(context).pop(true),
            ),
          ],
        );
      },
    );

    if (confirmed != true) return;

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => const Center(child: CircularProgressIndicator()),
    );

    try {
      await onConfirm();
    } catch (e) {
      Navigator.of(context).pop();
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Error: $e')));
      return;
    }

    Navigator.of(context).pop();
    onDoneRedirect();
  }
}
