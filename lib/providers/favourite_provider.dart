import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get_it/get_it.dart';
import 'package:pokemanriverpod/database/database_services.dart';

class FavouriteProvider extends StateNotifier<List<String>> {
  FavouriteProvider(super.state) {
    setUp();
  }
  final databaseServices = GetIt.instance.get<DatabaseServices>();
  final FAVOURITE_LIST_KEY = 'faouriteList';

  Future<void> setUp() async {
    List<String>? list = await databaseServices.getList(FAVOURITE_LIST_KEY);
    state = list ?? [];
  }

  void addFavourite(String url) {
    state = [...state, url];
    // after updating the state update the shared preference favourite list
    databaseServices.saveList(FAVOURITE_LIST_KEY, state);
  }

  void removeFavourite(String url) {
    state = [...state.where((e) => e != url)];
    databaseServices.saveList(FAVOURITE_LIST_KEY, state);
  }
}

final favouriteProvider =
    StateNotifierProvider<FavouriteProvider, List<String>>((ref) {
      return FavouriteProvider([]);
    });
