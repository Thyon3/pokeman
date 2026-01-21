import '../../../../core/network/dio_client.dart';
import '../models/pokemon_model.dart';
import '../models/pokemon_short_model.dart';

abstract class PokemonRemoteDataSource {
  Future<List<PokemonShortModel>> getPokemonList({int limit = 20, int offset = 0});
  Future<PokemonModel> getPokemonDetails(String urlOrId);
  Future<List<PokemonShortModel>> getPokemonByType(String type);
}

class PokemonRemoteDataSourceImpl implements PokemonRemoteDataSource {
  final DioClient _client;

  PokemonRemoteDataSourceImpl(this._client);

  @override
  Future<List<PokemonShortModel>> getPokemonList({int limit = 20, int offset = 0}) async {
    final response = await _client.get(
      'pokemon',
      queryParameters: {
        'limit': limit,
        'offset': offset,
      },
    );

    final results = response.data['results'] as List;
    return results.map((json) => PokemonShortModel.fromJson(json)).toList();
  }

  @override
  Future<PokemonModel> getPokemonDetails(String urlOrId) async {
    // If it's a full URL, we extract the ID or use it directly
    final path = urlOrId.contains('http') 
        ? urlOrId.replaceFirst('https://pokeapi.co/api/v2/', '') 
        : 'pokemon/$urlOrId';
    
    final response = await _client.get(path);
    return PokemonModel.fromJson(response.data);
  }

  @override
  Future<List<PokemonShortModel>> getPokemonByType(String type) async {
    final response = await _client.get('type/$type');
    final results = response.data['pokemon'] as List;
    return results.map((json) => PokemonShortModel.fromJson(json['pokemon'])).toList();
  }
}
