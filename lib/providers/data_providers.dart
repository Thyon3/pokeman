import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get_it/get_it.dart';
import 'package:pokemanriverpod/models/pokeman.dart';
import 'package:pokemanriverpod/services/services.dart/http_services.dart';

final pokemonProvider = FutureProvider.family<Pokemon?, String>((
  ref,
  url,
) async {
  final httpServices = GetIt.instance.get<HttpServices>();
  Response? res = await httpServices.get(url);
  if (res != null && res.data != null) {
    return Pokemon.fromJson(res.data);
  } else {
    return null;
  }
});
