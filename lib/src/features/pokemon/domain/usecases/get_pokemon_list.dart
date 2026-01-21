import '../repositories/pokemon_repository.dart';
import '../../data/models/pokemon_short_model.dart';

class GetPokemonList {
  final PokemonRepository repository;

  GetPokemonList(this.repository);

  Future<List<PokemonShortModel>> call({int limit = 20, int offset = 0}) async {
    return await repository.getPokemonList(limit: limit, offset: offset);
  }
}
