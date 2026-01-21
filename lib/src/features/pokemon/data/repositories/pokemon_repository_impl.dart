import '../../domain/entities/pokemon.dart';
import '../../domain/repositories/pokemon_repository.dart';
import '../models/pokemon_short_model.dart';
import '../sources/pokemon_remote_data_source.dart';

class PokemonRepositoryImpl implements PokemonRepository {
  final PokemonRemoteDataSource _remoteDataSource;

  PokemonRepositoryImpl(this._remoteDataSource);

  @override
  Future<List<PokemonShortModel>> getPokemonList({int limit = 20, int offset = 0}) async {
    return await _remoteDataSource.getPokemonList(limit: limit, offset: offset);
  }

  @override
  Future<Pokemon> getPokemonDetails(String urlOrId) async {
    return await _remoteDataSource.getPokemonDetails(urlOrId);
  }
}
