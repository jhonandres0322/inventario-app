import 'package:get_it/get_it.dart';
import 'package:inventario_app/src/data/customers/repositories/customers_repository.dart';
import 'package:inventario_app/src/data/customers/services/customers_remote_service.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import 'package:inventario_app/src/config/env/env_loader.dart';
import 'package:inventario_app/src/data/products/services/get_info_website/get_info_from_website_service_factory.dart';
import 'package:inventario_app/src/data/products/repositories/products_repository.dart';
import 'package:inventario_app/src/data/products/services/products_remote_service.dart';
import 'package:inventario_app/src/data/services/supabase/supabase_service.dart';

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
  sl.registerSingleton<GetInfoFromWebsiteServiceFactory>(
    DefaultLoadInfoFromWebsiteServiceFactory(),
  );

  // Repositorio
  sl.registerLazySingleton<ProductsRepository>(
    () => ProductsRepository(
      sl<ProductsRemoteService>(),
      sl<GetInfoFromWebsiteServiceFactory>(),
    ),
  );

  sl.registerLazySingleton(() => CustomersRemoteService(sl<SupabaseService>()));
  sl.registerLazySingleton<CustomersRepository>(
    () => CustomersRepository(sl<CustomersRemoteService>()),
  );
}
