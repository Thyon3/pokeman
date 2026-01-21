import 'package:flutter_riverpod/flutter_riverpod.dart';
import './pokemon_list_provider.dart';

final pokemonTypeFilterProvider = StateProvider<String?>((ref) => null);

final pokemonSearchQueryProvider = StateProvider<String>((ref) => '');

final pokemonSearchResultProvider = Provider((ref) {
  final query = ref.watch(pokemonSearchQueryProvider).toLowerCase();
  final typeFilter = ref.watch(pokemonTypeFilterProvider);
  final listAsync = ref.watch(pokemonListProvider);

  return listAsync.whenData((list) {
    var filteredList = list;
    
    if (query.isNotEmpty) {
      filteredList = filteredList.where((p) => 
        p.name.toLowerCase().contains(query) || 
        p.id.toString() == query
      ).toList();
    }
    
    // Note: PokemonShortModel doesn't have types. 
    // For local filtering by type, we would need to have types in the list model.
    // Or fetch by type from API. 
    // I'll update PokemonShortModel to optionally include types if available.
    
    return filteredList;
  });
});
