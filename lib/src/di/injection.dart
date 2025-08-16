import 'package:get_it/get_it.dart';
import 'package:inventario_app/src/features/products/data/datasources/product_remote_source.dart';
import 'package:inventario_app/src/features/products/data/repositories/product_repository_impl.dart';
import 'package:inventario_app/src/features/products/domain/repositories/product_repository.dart';
import 'package:inventario_app/src/features/products/domain/usecases/get_products_page.dart';
import 'package:inventario_app/src/features/products/infrastructure/datasources/product_supabase_datasource.dart';
import 'package:inventario_app/src/features/products/presentation/providers/get_products_provider.dart';
import 'package:inventario_app/src/shared/infrastructure/config/env_loader.dart';
import 'package:inventario_app/src/shared/infrastructure/ports/supabase_port.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

final sl = GetIt.instance;

Future<void> init() async {
  final config = await EnvLoader.load();

  // Supabase (infra)
  await Supabase.initialize(
    url: config.supabaseUrl,
    anonKey: config.supabaseAnonKey,
  );
  sl.registerSingleton(SupabaseClientPort(Supabase.instance.client));

  // Datasource (infra)

  sl.registerLazySingleton<ProductRemoteSource>(
    () => ProductSupabaseDatasource(sl<SupabaseClientPort>()),
  );

  // Repositorio
  sl.registerLazySingleton<ProductRepository>(
    () => ProductRepositoryImpl(sl<ProductRemoteSource>()),
  );

  // Caso de Uso
  sl.registerLazySingleton(
    () => GetProductsPageUseCase(sl<ProductRepository>()),
  );
  sl.registerLazySingleton(() => GetProductsProvider());
}
