import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/di/injection.dart';
import '../../data/models/pokemon_short_model.dart';
import '../../domain/usecases/get_pokemon_list.dart';

class PokemonListNotifier extends AsyncNotifier<List<PokemonShortModel>> {
  @override
  FutureOr<List<PokemonShortModel>> build() async {
    return await locator<GetPokemonList>().call(offset: 0);
  }

  Future<void> loadMore() async {
    final currentData = state.value ?? [];
    final nextOffset = currentData.length;

    // We don't want to set state to loading if we already have data, 
    // to avoid flickering the whole list. 
    // Instead we can use a separate flag or just append.
    
    try {
      final moreData = await locator<GetPokemonList>().call(offset: nextOffset);
      state = AsyncValue.data([...currentData, ...moreData]);
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }
}

final pokemonListProvider = AsyncNotifierProvider<PokemonListNotifier, List<PokemonShortModel>>(() {
  return PokemonListNotifier();
});
