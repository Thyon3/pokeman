import 'package:equatable/equatable.dart';

class Pokemon extends Equatable {
  final int id;
  final String name;
  final int height;
  final int weight;
  final List<String> types;
  final List<PokemonStat> stats;
  final String imageUrl;
  final List<String> abilities;

  const Pokemon({
    required this.id,
    required this.name,
    required this.height,
    required this.weight,
    required this.types,
    required this.stats,
    required this.imageUrl,
    required this.abilities,
  });

  @override
  List<Object?> get props => [id, name, height, weight, types, stats, imageUrl, abilities];
}

class PokemonStat extends Equatable {
  final String name;
  final int baseStat;

  const PokemonStat({
    required this.name,
    required this.baseStat,
  });

  @override
  List<Object?> get props => [name, baseStat];
}
