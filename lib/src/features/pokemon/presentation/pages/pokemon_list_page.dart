import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../widgets/pokemon_card.dart';
import '../providers/pokemon_list_provider.dart';
import './pokemon_detail_page.dart';
import 'package:skeletonizer/skeletonizer.dart';

class PokemonListPage extends ConsumerStatefulWidget {
  const PokemonListPage({super.key});

  @override
  ConsumerState<PokemonListPage> createState() => _PokemonListPageState();
}

class _PokemonListPageState extends ConsumerState<PokemonListPage> {
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    if (_scrollController.position.pixels >=
        _scrollController.position.maxScrollExtent - 200) {
      ref.read(pokemonListProvider.notifier).loadMore();
    }
  }

  @override
  Widget build(BuildContext context) {
    final pokemonListAsync = ref.watch(pokemonListProvider);

    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: CustomScrollView(
        controller: _scrollController,
        slivers: [
          SliverAppBar.large(
            title: const Text('Pokédex'),
            floating: true,
            pinned: true,
            backgroundColor: Theme.of(context).colorScheme.surface,
          ),
          pokemonListAsync.when(
            data: (list) => SliverPadding(
              padding: const EdgeInsets.all(16),
              sliver: SliverGrid(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 0.8,
                  crossAxisSpacing: 16,
                  mainAxisSpacing: 16,
                ),
                delegate: SliverChildBuilderDelegate(
                  (context, index) {
                    if (index >= list.length) {
                      return const Center(child: CircularProgressIndicator());
                    }
                    return PokemonCard(
                      pokemon: list[index],
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => PokemonDetailPage(
                              pokemonId: list[index].id.toString(),
                              pokemonName: list[index].name,
                            ),
                          ),
                        );
                      },
                    );
                  },
                  itemCount: list.length,
                ),
              ),
            ),
            error: (err, stack) => SliverFillRemaining(
              child: Center(child: Text('Error: $err')),
            ),
            loading: () => SliverPadding(
              padding: const EdgeInsets.all(16),
              sliver: Skeletonizer.sliver(
                child: SliverGrid(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: 0.8,
                    crossAxisSpacing: 16,
                    mainAxisSpacing: 16,
                  ),
                  delegate: SliverChildBuilderDelegate(
                    (context, index) => Card(
                      child: Container(height: 150),
                    ),
                    childCount: 8,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
