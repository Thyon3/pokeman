import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pokemanriverpod/models/pokeman.dart';
import 'package:pokemanriverpod/providers/data_providers.dart';
import 'package:pokemanriverpod/providers/favourite_provider.dart';
import 'package:skeletonizer/skeletonizer.dart';

class PokemanGrid extends ConsumerWidget {
  PokemanGrid({required this.url});
  final String url;

  Widget build(BuildContext context, WidgetRef ref) {
    final pokemon = ref.watch(pokemonProvider(url));
    final favouriteStateProvider = ref.watch(favouriteProvider);
    final favouriteStateProviderAction = ref.watch(favouriteProvider.notifier);
    return pokemon.when(
      data: (data) {
        return _gridElement(
          data,
          false,
          context,
          favouriteStateProvider,
          favouriteStateProviderAction,
        );
      },
      error: (error, s) {
        return Text('something went wrong $error');
      },
      loading: () {
        return _gridElement(
          null,
          true,
          context,
          favouriteStateProvider,
          favouriteStateProviderAction,
        );
        ;
      },
    );
  }

  Widget _gridElement(
    Pokemon? pokemon,
    bool isLoading,
    BuildContext context,
    dynamic favourites,
    dynamic favouritesAciton,
  ) {
    return Skeletonizer(
      enabled: isLoading,
      ignoreContainers: true,
      child: Container(
        margin: EdgeInsets.symmetric(
          horizontal: MediaQuery.sizeOf(context).width * 0.01,
          vertical: MediaQuery.sizeOf(context).height * 0.01,
        ),
        padding: EdgeInsets.symmetric(
          vertical: MediaQuery.sizeOf(context).height * 0.02,
          horizontal: MediaQuery.sizeOf(context).width * 0.02,
        ),
        decoration: BoxDecoration(
          color: const Color.fromARGB(255, 74, 59, 162),
          borderRadius: BorderRadius.circular(12),
          boxShadow: const [
            BoxShadow(blurRadius: 5, color: Colors.black38, spreadRadius: 2),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  pokemon != null ? pokemon.name!.toUpperCase() : 'pokemon',
                  style: GoogleFonts.lato(
                    textStyle: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
                Text(
                  pokemon != null ? '#${pokemon.id!.toString()}' : '0',
                  style: GoogleFonts.lato(
                    textStyle: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
              ],
            ),
            Expanded(
              child: Center(
                child: CircleAvatar(
                  backgroundImage:
                      pokemon != null
                          ? NetworkImage(pokemon.sprites!.frontDefault!)
                          : null,
                  radius: MediaQuery.sizeOf(context).width * 0.13,
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  pokemon != null
                      ? '${pokemon.moves!.length.toString()} Moves'
                      : '0',
                  style: GoogleFonts.lato(
                    textStyle: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
                IconButton(
                  onPressed: () {
                    if (favourites.contains(url)) {
                      favouritesAciton.addFavourite(url);
                    } else {
                      favouritesAciton.removeFavourite(url);
                    }
                  },
                  icon:
                      favourites.contains(url)
                          ? Icon(Icons.favorite_outlined)
                          : Icon(Icons.favorite_outline_outlined),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
