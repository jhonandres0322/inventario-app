import 'dart:developer';

import 'package:inventario_app/src/models/customer_model.dart';
import 'package:inventario_app/src/models/product_model.dart';

class MockSupabaseUtil {
  Future<List<CustomerModel>> generateMockCustomers({
    int count = 10,
    Duration delay = const Duration(seconds: 2),
  }) async {
    log('****** Consumiendo mock List Customers');
    await Future.delayed(delay);
    return List.generate(count, (index) {
      return CustomerModel(
        id: 'cust_$index',
        nombre: 'Cliente $index',
        telefono: '32000000${index.toString().padLeft(2, '0')}',
        direccion: 'Calle Falsa #${index + 1} - ${index + 10}',
        fechaRegistro: DateTime.now().subtract(Duration(days: index * 5)),
      );
    });
  }

  Future<List<ProductModel>> generateMockProducts({
    int count = 10,
    Duration delay = const Duration(seconds: 2),
  }) async {
    log('****** Consumiendo mock List Products');
    await Future.delayed(delay);
    return List.generate(count, (index) {
      final precio = (50000 + index * 1000).toString();
      final cantidad = (10 + index).toString();

      return ProductModel(
          id: 'prod_$index',
          nombre: 'Producto $index',
          precioCompra: precio,
          talla: 'M',
          marca: 'Marca $index',
          codigoKliker: 'KLK-${1000 + index}',
          cantidad: cantidad,
          foto1: '',
          foto2: '',
          fechaCreacion: DateTime.now().subtract(Duration(days: index * 3)),
        )
        ..calculateCommision()
        ..calculateRealCost(); // Calcula comisiones y costo real
    });
  }
}
