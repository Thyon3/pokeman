import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/di/injection.dart';
import '../../data/models/pokemon_short_model.dart';
import '../../domain/usecases/get_pokemon_list.dart';
import '../../domain/usecases/get_pokemon_by_type.dart';

class PokemonListNotifier extends AsyncNotifier<List<PokemonShortModel>> {
  String? _currentType;

  @override
  FutureOr<List<PokemonShortModel>> build() async {
    return await locator<GetPokemonList>().call(offset: 0);
  }

  Future<void> filterByType(String? type) async {
    if (_currentType == type) return;
    _currentType = type;
    
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      if (type == null) {
        return await locator<GetPokemonList>().call(offset: 0);
      } else {
        return await locator<GetPokemonByType>().call(type);
      }
    });
  }

  Future<void> loadMore() async {
    // Only paginate if no type filter is active (basic PokeAPI limit)
    if (_currentType != null) return;
    
    final currentData = state.value ?? [];
    final nextOffset = currentData.length;
    
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
