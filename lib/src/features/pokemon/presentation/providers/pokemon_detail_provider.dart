import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/di/injection.dart';
import '../../domain/entities/pokemon.dart';
import '../../domain/usecases/get_pokemon_details.dart';

final pokemonDetailProvider = FutureProvider.family<Pokemon, String>((ref, id) async {
  return await locator<GetPokemonDetails>().call(id);
});
