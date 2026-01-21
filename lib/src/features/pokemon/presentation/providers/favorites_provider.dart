import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/di/injection.dart';
import '../../domain/repositories/favorites_repository.dart';

class FavoritesNotifier extends StateNotifier<List<String>> {
  final FavoritesRepository _repository;

  FavoritesNotifier(this._repository) : super([]) {
    _loadFavorites();
  }

  Future<void> _loadFavorites() async {
    state = await _repository.getFavorites();
  }

  Future<void> toggleFavorite(String pokemonId) async {
    await _repository.toggleFavorite(pokemonId);
    await _loadFavorites();
  }

  bool isFavorite(String pokemonId) {
    return state.contains(pokemonId);
  }
}

final favoritesProvider = StateNotifierProvider<FavoritesNotifier, List<String>>((ref) {
  return FavoritesNotifier(locator<FavoritesRepository>());
});
