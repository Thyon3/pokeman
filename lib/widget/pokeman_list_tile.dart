import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pokemanriverpod/models/pokeman.dart';
import 'package:pokemanriverpod/providers/data_providers.dart';
import 'package:pokemanriverpod/providers/favourite_provider.dart';
import 'package:skeletonizer/skeletonizer.dart';

class PokemanListTile extends ConsumerWidget {
  PokemanListTile({super.key, required this.pokemanUrl});
  final String pokemanUrl;
  late var _favouritesListProvider;
  late List<String> favourites;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    _favouritesListProvider = ref.watch(favouriteProvider.notifier);
    favourites = ref.watch(favouriteProvider);
    final pokemanData = ref.watch(pokemonProvider(pokemanUrl));
    return pokemanData.when(
      data: (data) {
        return _tile(context, false, data);
      },
      error: (error, s) {
        return Text('unable to load data');
      },
      loading: () {
        return _tile(context, true, null);
      },
    );
  }

  Widget _tile(BuildContext context, bool isLoading, Pokemon? data) {
    return Skeletonizer(
      enabled: isLoading,
      child: ListTile(
        leading:
            data != null
                ? CircleAvatar(
                  backgroundImage: NetworkImage(data.sprites!.frontDefault!),
                )
                : CircleAvatar(),
        title: Text(data != null ? data.name!.toUpperCase() : 'Loading'),
        subtitle: Text(
          data != null ? 'Has ${data.moves!.length.toString()} Moves' : '0',
        ),
        trailing: IconButton(
          onPressed: () {
            if (favourites.contains(pokemanUrl)) {
              _favouritesListProvider.removeFavourite(pokemanUrl);
            } else {
              _favouritesListProvider.addFavourite(pokemanUrl);
            }
          },
          icon: Icon(
            favourites.contains(pokemanUrl)
                ? Icons.favorite
                : Icons.favorite_border,
          ),
          color: Colors.red,
        ),
      ),
    );
  }
}
