import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../widgets/pokemon_card.dart';
import '../widgets/ui_states.dart';
import '../providers/pokemon_list_provider.dart';
import '../providers/pokemon_search_provider.dart';
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
            _scrollController.position.maxScrollExtent - 200 &&
        ref.read(pokemonSearchQueryProvider).isEmpty) {
      ref.read(pokemonListProvider.notifier).loadMore();
    }
  }

  @override
  Widget build(BuildContext context) {
    final pokemonListAsync = ref.watch(pokemonSearchResultProvider);
    final searchQuery = ref.watch(pokemonSearchQueryProvider);

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
            bottom: PreferredSize(
              preferredSize: const Size.fromHeight(60),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: TextField(
                  onChanged: (value) => ref.read(pokemonSearchQueryProvider.notifier).state = value,
                  decoration: InputDecoration(
                    hintText: 'Search Pokémon by name or ID...',
                    prefixIcon: const Icon(Icons.search),
                    filled: true,
                    fillColor: Theme.of(context).colorScheme.surfaceContainerHighest.withValues(alpha: 0.5),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30),
                      borderSide: BorderSide.none,
                    ),
                  ),
                ),
              ),
            ),
          ),
          pokemonListAsync.when(
            data: (list) => list.isEmpty 
              ? const SliverFillRemaining(child: PokemonEmptyWidget())
              : SliverPadding(
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
              child: PokemonErrorWidget(
                message: err.toString(),
                onRetry: () => ref.refresh(pokemonListProvider),
              ),
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
