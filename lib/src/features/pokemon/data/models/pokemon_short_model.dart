class PokemonShortModel {
  final String name;
  final String url;

  PokemonShortModel({
    required this.name,
    required this.url,
  });

  factory PokemonShortModel.fromJson(Map<String, dynamic> json) {
    return PokemonShortModel(
      name: json['name'],
      url: json['url'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'url': url,
    };
  }

  int get id {
    final parts = url.split('/');
    return int.parse(parts[parts.length - 2]);
  }
}
