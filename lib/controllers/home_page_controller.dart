import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get_it/get_it.dart';
import 'package:pokemanriverpod/dependencyinjection/service_locator.dart';
import 'package:pokemanriverpod/models/page_data.dart';
import 'package:pokemanriverpod/models/pokeman.dart';
import 'package:pokemanriverpod/providers/favourite_provider.dart';
import 'package:pokemanriverpod/services/services.dart/http_services.dart';

class HomePageController extends StateNotifier<HomePageData> {
  final _getIt = GetIt.instance;
  late HttpServices _httpServices;
  HomePageController(super._state) {
    _httpServices = _getIt.get<HttpServices>();
    setUp();
  }
  Future<void> setUp() async {
    await loadData();
  }

  Future<void> loadData() async {
    if (state.data == null) {
      Response? res = await _httpServices.get(
        'https://pokeapi.co/api/v2/pokemon?limit=20&offset=0.',
      );
      //  now update the state
      if (res != null && res.data != null) {
        PokemonListData data = PokemonListData.fromJson(res.data);
        state = state.copyWith(data: data);
      }
    } else {
      if (state.data!.next != null) {
        Response? res = await _httpServices.get(state.data!.next!);
        //  now update the state
        if (res != null && res.data != null) {
          PokemonListData data = PokemonListData.fromJson(res.data);
          state = state.copyWith(
            data: data.copyWith(
              results: [...?state.data?.results, ...?data.results],
            ),
          );
        }
      }
    }
  }
}

final HomePageControllerProvider =
    StateNotifierProvider<HomePageController, HomePageData>((ref) {
      return HomePageController(HomePageData.initial());
    });
