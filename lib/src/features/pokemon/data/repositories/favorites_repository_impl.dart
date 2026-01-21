import 'package:hive_flutter/hive_flutter.dart';
import '../../domain/repositories/favorites_repository.dart';

class FavoritesRepositoryImpl implements FavoritesRepository {
  static const String _boxName = 'favorites';

  @override
  Future<List<String>> getFavorites() async {
    final box = Hive.box<String>(_boxName);
    return box.values.toList();
  }

  @override
  Future<void> toggleFavorite(String pokemonId) async {
    final box = Hive.box<String>(_boxName);
    if (box.containsKey(pokemonId)) {
      await box.delete(pokemonId);
    } else {
      await box.put(pokemonId, pokemonId);
    }
  }

  @override
  Future<bool> isFavorite(String pokemonId) async {
    final box = Hive.box<String>(_boxName);
    return box.containsKey(pokemonId);
  }

  static Future<void> init() async {
    await Hive.openBox<String>(_boxName);
  }
}
