import 'package:get_it/get_it.dart';
import 'package:pokemanriverpod/database/database_services.dart';
import 'package:pokemanriverpod/services/services.dart/http_services.dart';

final locator = GetIt.instance;

// registering dependencies
void setUp() {
  locator.registerSingleton<HttpServices>(HttpServices());
  locator.registerSingleton<DatabaseServices>(DatabaseServices());
}
