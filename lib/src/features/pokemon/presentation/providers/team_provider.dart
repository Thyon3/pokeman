import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/di/injection.dart';
import '../../domain/repositories/team_repository.dart';

class TeamNotifier extends StateNotifier<List<String>> {
  final TeamRepository _repository;

  TeamNotifier(this._repository) : super([]) {
    _loadTeam();
  }

  Future<void> _loadTeam() async {
    state = await _repository.getTeam();
  }

  Future<void> addToTeam(String pokemonId) async {
    try {
      await _repository.addToTeam(pokemonId);
      await _loadTeam();
    } catch (e) {
      rethrow;
    }
  }

  Future<void> removeFromTeam(String pokemonId) async {
    await _repository.removeFromTeam(pokemonId);
    await _loadTeam();
  }

  bool isInTeam(String pokemonId) {
    return state.contains(pokemonId);
  }
}

final teamProvider = StateNotifierProvider<TeamNotifier, List<String>>((ref) {
  return TeamNotifier(locator<TeamRepository>());
});
