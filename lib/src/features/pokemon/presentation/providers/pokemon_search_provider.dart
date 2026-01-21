import 'package:flutter_riverpod/flutter_riverpod.dart';
import './pokemon_list_provider.dart';

final pokemonSearchQueryProvider = StateProvider<String>((ref) => '');

final pokemonSearchResultProvider = Provider((ref) {
  final query = ref.watch(pokemonSearchQueryProvider).toLowerCase();
  final listAsync = ref.watch(pokemonListProvider);

  return listAsync.whenData((list) {
    if (query.isEmpty) return list;
    return list.where((p) => 
      p.name.toLowerCase().contains(query) || 
      p.id.toString() == query
    ).toList();
  });
});
