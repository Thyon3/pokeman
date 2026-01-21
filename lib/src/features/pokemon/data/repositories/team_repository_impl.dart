import 'package:hive_flutter/hive_flutter.dart';
import '../../domain/repositories/team_repository.dart';

class TeamRepositoryImpl implements TeamRepository {
  static const String _boxName = 'team';
  static const int maxTeamSize = 6;

  @override
  Future<List<String>> getTeam() async {
    final box = Hive.box<String>(_boxName);
    return box.values.toList();
  }

  @override
  Future<void> addToTeam(String pokemonId) async {
    final box = Hive.box<String>(_boxName);
    if (box.length >= maxTeamSize) {
      throw Exception('Team is full (max 6)');
    }
    await box.put(pokemonId, pokemonId);
  }

  @override
  Future<void> removeFromTeam(String pokemonId) async {
    final box = Hive.box<String>(_boxName);
    await box.delete(pokemonId);
  }

  @override
  Future<bool> isInTeam(String pokemonId) async {
    final box = Hive.box<String>(_boxName);
    return box.containsKey(pokemonId);
  }

  static Future<void> init() async {
    await Hive.openBox<String>(_boxName);
  }
}
