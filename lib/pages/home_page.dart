import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get_it/get_it.dart';
import 'package:pokemanriverpod/controllers/home_page_controller.dart';
import 'package:pokemanriverpod/dependencyinjection/service_locator.dart';
import 'package:pokemanriverpod/models/pokeman.dart';
import 'package:pokemanriverpod/providers/favourite_provider.dart';
import 'package:pokemanriverpod/services/services.dart/http_services.dart';
import 'package:pokemanriverpod/widget/pokeman_grid.dart';
import 'package:pokemanriverpod/widget/pokeman_list_tile.dart';

class HomePage extends ConsumerStatefulWidget {
  const HomePage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() {
    // TODO: implement createState
    return _HomePageState();
  }
}

class _HomePageState extends ConsumerState<HomePage> {
  final ScrollController _allPokemanListController = ScrollController();
  late List<String> favourites;
  @override
  void initState() {
    super.initState();
    _allPokemanListController.addListener(_scrollListener);
  }

  @override
  void dispose() {
    _allPokemanListController.removeListener(_scrollListener);
    _allPokemanListController.dispose();
    super.dispose();
  }

  void _scrollListener() {
    final homePageProvider = ref.watch(HomePageControllerProvider.notifier);
    if (_allPokemanListController.offset >=
            _allPokemanListController.position.maxScrollExtent * 1 &&
        !_allPokemanListController.position.outOfRange) {
      homePageProvider.loadData();
    }
  }

  @override
  Widget build(BuildContext context) {
    favourites = ref.watch(favouriteProvider);
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            margin: EdgeInsets.only(
              top: MediaQuery.sizeOf(context).height * 0.02,
            ),
            width: MediaQuery.sizeOf(context).width,
            padding: EdgeInsets.symmetric(
              horizontal: MediaQuery.sizeOf(context).width * 0.02,
            ),
            child: Column(
              children: [
                _allFavouritePokeman(context, favourites),
                _allPokemansList(context, ref, _allPokemanListController),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _allPokemansList(
    BuildContext context,
    WidgetRef ref,
    ScrollController controller,
  ) {
    final homePageController = ref.watch(HomePageControllerProvider);

    return SizedBox(
      width: MediaQuery.sizeOf(context).width,
      child: Column(
        children: [
          Text('All Pokemans', style: TextTheme.of(context).bodyLarge),

          SizedBox(
            height: MediaQuery.sizeOf(context).height * 0.6,
            child: ListView.builder(
              controller: controller,
              itemCount: homePageController.data!.results!.length ?? 0,

              itemBuilder: (context, index) {
                final pokemanUrl = homePageController.data!.results![index];
                return PokemanListTile(pokemanUrl: pokemanUrl.url!);
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _allFavouritePokeman(BuildContext context, List<String> favourites) {
    return SizedBox(
      width: MediaQuery.sizeOf(context).width,
      height: favourites.isEmpty ? 0 : MediaQuery.sizeOf(context).height * 0.5,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text('Favourites'),
          Column(
            children: [
              SizedBox(
                height: MediaQuery.sizeOf(context).height * 0.4,
                child: GridView.builder(
                  itemCount: favourites.length,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                  ),
                  itemBuilder: (context, index) {
                    return PokemanGrid(url: favourites[index]);
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
