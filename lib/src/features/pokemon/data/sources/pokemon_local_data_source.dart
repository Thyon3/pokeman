import 'dart:convert';
import 'package:hive_flutter/hive_flutter.dart';
import '../models/pokemon_model.dart';
import '../models/pokemon_short_model.dart';

abstract class PokemonLocalDataSource {
  Future<void> cachePokemonList(List<PokemonShortModel> list, {int offset = 0});
  List<PokemonShortModel>? getCachedPokemonList({int offset = 0});
  Future<void> cachePokemonDetails(PokemonModel pokemon);
  PokemonModel? getCachedPokemonDetails(String id);
}

class PokemonLocalDataSourceImpl implements PokemonLocalDataSource {
  static const String _listBoxName = 'pokemon_list';
  static const String _detailsBoxName = 'pokemon_details';

  @override
  Future<void> cachePokemonList(List<PokemonShortModel> list, {int offset = 0}) async {
    final box = Hive.box<String>(_listBoxName);
    final jsonList = list.map((e) => json.encode(e.toJson())).toList();
    await box.put('offset_$offset', json.encode(jsonList));
  }

  @override
  List<PokemonShortModel>? getCachedPokemonList({int offset = 0}) {
    final box = Hive.box<String>(_listBoxName);
    final cached = box.get('offset_$offset');
    if (cached == null) return null;

    final List<dynamic> jsonList = json.decode(cached);
    return jsonList.map((e) => PokemonShortModel.fromJson(json.decode(e))).toList();
  }

  @override
  Future<void> cachePokemonDetails(PokemonModel pokemon) async {
    final box = Hive.box<String>(_detailsBoxName);
    await box.put(pokemon.id.toString(), json.encode(pokemon.toJson()));
  }

  @override
  PokemonModel? getCachedPokemonDetails(String id) {
    final box = Hive.box<String>(_detailsBoxName);
    final cached = box.get(id);
    if (cached == null) return null;

    return PokemonModel.fromJson(json.decode(cached));
  }

  static Future<void> init() async {
    await Hive.initFlutter();
    await Hive.openBox<String>(_listBoxName);
    await Hive.openBox<String>(_detailsBoxName);
  }
}
