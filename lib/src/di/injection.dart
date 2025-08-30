import 'package:get_it/get_it.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import 'package:inventario_app/src/config/env_loader.dart';
import 'package:inventario_app/src/data/products/repositories/products_repository.dart';
import 'package:inventario_app/src/data/products/services/products_remote_service.dart';
import 'package:inventario_app/src/data/services/supabase_service.dart';

final sl = GetIt.instance;

Future<void> init() async {
  final config = await EnvLoader.load();

  // Supabase (infra)
  await Supabase.initialize(
    url: config.supabaseUrl,
    anonKey: config.supabaseAnonKey,
  );
  sl.registerSingleton(SupabaseService(Supabase.instance.client));

  sl.registerLazySingleton(() => ProductsRemoteService(sl<SupabaseService>()));

  // Repositorio
  sl.registerLazySingleton<ProductsRepository>(
    () => ProductsRepository(sl<ProductsRemoteService>()),
  );
}
