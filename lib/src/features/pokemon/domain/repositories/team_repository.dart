abstract class TeamRepository {
  Future<List<String>> getTeam();
  Future<void> addToTeam(String pokemonId);
  Future<void> removeFromTeam(String pokemonId);
  Future<bool> isInTeam(String pokemonId);
}
