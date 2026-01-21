import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../network/dio_client.dart';
import '../database/local_storage.dart';
import '../../features/pokemon/data/repositories/favorites_repository_impl.dart';
import '../../features/pokemon/data/repositories/pokemon_repository_impl.dart';
import '../../features/pokemon/data/repositories/team_repository_impl.dart';
import '../../features/pokemon/data/sources/pokemon_local_data_source.dart';
import '../../features/pokemon/data/sources/pokemon_remote_data_source.dart';
import '../../features/pokemon/domain/repositories/favorites_repository.dart';
import '../../features/pokemon/domain/repositories/pokemon_repository.dart';
import '../../features/pokemon/domain/repositories/team_repository.dart';
import '../../features/pokemon/domain/usecases/get_pokemon_details.dart';
import '../../features/pokemon/domain/usecases/get_pokemon_list.dart';

final locator = GetIt.instance;

Future<void> initDependencies() async {
  // External
  await PokemonLocalDataSourceImpl.init();
  await FavoritesRepositoryImpl.init();
  await TeamRepositoryImpl.init();
  final sharedPreferences = await SharedPreferences.getInstance();
  locator.registerLazySingleton(() => sharedPreferences);
  locator.registerLazySingleton(() => DioClient());
  locator.registerLazySingleton(() => LocalStorage(locator()));

  // Data Sources
  locator.registerLazySingleton<PokemonRemoteDataSource>(
    () => PokemonRemoteDataSourceImpl(locator()),
  );
  locator.registerLazySingleton<PokemonLocalDataSource>(
    () => PokemonLocalDataSourceImpl(),
  );

  // Repositories
  locator.registerLazySingleton<PokemonRepository>(
    () => PokemonRepositoryImpl(locator(), locator()),
  );
  locator.registerLazySingleton<FavoritesRepository>(
    () => FavoritesRepositoryImpl(),
  );
  locator.registerLazySingleton<TeamRepository>(
    () => TeamRepositoryImpl(),
  );

  // Use Cases
  locator.registerLazySingleton(() => GetPokemonList(locator()));
  locator.registerLazySingleton(() => GetPokemonDetails(locator()));
}
