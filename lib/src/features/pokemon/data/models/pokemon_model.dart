import '../../domain/entities/pokemon.dart';

class PokemonModel extends Pokemon {
  const PokemonModel({
    required super.id,
    required super.name,
    required super.height,
    required super.weight,
    required super.types,
    required super.stats,
    required super.imageUrl,
    required super.abilities,
  });

  factory PokemonModel.fromJson(Map<String, dynamic> json) {
    return PokemonModel(
      id: json['id'],
      name: json['name'],
      height: json['height'],
      weight: json['weight'],
      types: (json['types'] as List)
          .map((type) => type['type']['name'] as String)
          .toList(),
      stats: (json['stats'] as List)
          .map((stat) => PokemonStat(
                name: stat['stat']['name'],
                baseStat: stat['base_stat'],
              ))
          .toList(),
      imageUrl: json['sprites']['other']['official-artwork']['front_default'] ?? 
                json['sprites']['front_default'],
      abilities: (json['abilities'] as List)
          .map((ability) => ability['ability']['name'] as String)
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'height': height,
      'weight': weight,
      'types': types.map((t) => {'type': {'name': t}}).toList(),
      'stats': stats.map((s) => {
        'stat': {'name': s.name},
        'base_stat': s.baseStat,
      }).toList(),
      'sprites': {
        'other': {
          'official-artwork': {'front_default': imageUrl}
        }
      },
      'abilities': abilities.map((a) => {'ability': {'name': a}}).toList(),
    };
  }
}
