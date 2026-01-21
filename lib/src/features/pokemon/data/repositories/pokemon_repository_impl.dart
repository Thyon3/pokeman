import '../../domain/entities/pokemon.dart';
import '../../domain/repositories/pokemon_repository.dart';
import '../models/pokemon_short_model.dart';
import '../sources/pokemon_local_data_source.dart';
import '../sources/pokemon_remote_data_source.dart';
import '../models/pokemon_model.dart';

class PokemonRepositoryImpl implements PokemonRepository {
  final PokemonRemoteDataSource _remoteDataSource;
  final PokemonLocalDataSource _localDataSource;

  PokemonRepositoryImpl(this._remoteDataSource, this._localDataSource);

  @override
  Future<List<PokemonShortModel>> getPokemonList({int limit = 20, int offset = 0}) async {
    try {
      final remoteList = await _remoteDataSource.getPokemonList(limit: limit, offset: offset);
      await _localDataSource.cachePokemonList(remoteList, offset: offset);
      return remoteList;
    } catch (e) {
      final localList = _localDataSource.getCachedPokemonList(offset: offset);
      if (localList != null) return localList;
      rethrow;
    }
  }

  @override
  Future<Pokemon> getPokemonDetails(String urlOrId) async {
    final id = urlOrId.split('/').where((e) => e.isNotEmpty).last;
    
    try {
      final remotePokemon = await _remoteDataSource.getPokemonDetails(urlOrId);
      await _localDataSource.cachePokemonDetails(remotePokemon as PokemonModel);
      return remotePokemon;
    } catch (e) {
      final localPokemon = _localDataSource.getCachedPokemonDetails(id);
      if (localPokemon != null) return localPokemon;
      rethrow;
    }
  }
}
