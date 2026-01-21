abstract class FavoritesRepository {
  Future<List<String>> getFavorites();
  Future<void> toggleFavorite(String pokemonId);
  Future<bool> isFavorite(String pokemonId);
}
