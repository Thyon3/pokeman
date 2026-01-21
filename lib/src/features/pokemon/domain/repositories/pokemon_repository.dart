import '../entities/pokemon.dart';
import '../../data/models/pokemon_short_model.dart';

abstract class PokemonRepository {
  Future<List<PokemonShortModel>> getPokemonList({int limit = 20, int offset = 0});
  Future<Pokemon> getPokemonDetails(String urlOrId);
}
