import '../entities/pokemon.dart';
import '../repositories/pokemon_repository.dart';

class GetPokemonDetails {
  final PokemonRepository repository;

  GetPokemonDetails(this.repository);

  Future<Pokemon> call(String urlOrId) async {
    return await repository.getPokemonDetails(urlOrId);
  }
}
