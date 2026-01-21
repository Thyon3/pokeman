import '../../data/models/pokemon_short_model.dart';
import '../repositories/pokemon_repository.dart';

class GetPokemonByType {
  final PokemonRepository repository;

  GetPokemonByType(this.repository);

  Future<List<PokemonShortModel>> call(String type) async {
    return await repository.getPokemonByType(type);
  }
}
