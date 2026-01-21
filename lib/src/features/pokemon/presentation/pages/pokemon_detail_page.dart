import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domain/entities/pokemon.dart';
import '../providers/pokemon_detail_provider.dart';
import 'package:google_fonts/google_fonts.dart';

class PokemonDetailPage extends ConsumerWidget {
  final String pokemonId;
  final String pokemonName;

  const PokemonDetailPage({
    required this.pokemonId,
    required this.pokemonName,
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final pokemonAsync = ref.watch(pokemonDetailProvider(pokemonId));

    return Scaffold(
      body: pokemonAsync.when(
        data: (pokemon) => _PokemonDetailBody(pokemon: pokemon),
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (err, stack) => Center(child: Text('Error: $err')),
      ),
    );
  }
}

class _PokemonDetailBody extends StatelessWidget {
  final Pokemon pokemon;

  const _PokemonDetailBody({required this.pokemon});

  @override
  Widget build(BuildContext context) {
    final typeColor = _getTypeColor(pokemon.types.first);

    return CustomScrollView(
      slivers: [
        SliverAppBar(
          expandedHeight: 300,
          pinned: true,
          backgroundColor: typeColor,
          flexibleSpace: FlexibleSpaceBar(
            title: Text(
              pokemon.name.toUpperCase(),
              style: GoogleFonts.pressStart2p(fontSize: 14, color: Colors.white),
            ),
            background: Stack(
              children: [
                Positioned.fill(
                  child: Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [typeColor, typeColor.withValues(alpha: 0.7)],
                      ),
                    ),
                  ),
                ),
                Center(
                  child: Hero(
                    tag: 'pokemon-${pokemon.id}',
                    child: Image.network(
                      pokemon.imageUrl,
                      height: 200,
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        SliverToBoxAdapter(
          child: Container(
            padding: const EdgeInsets.all(24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _TypeBadges(types: pokemon.types),
                const SizedBox(height: 24),
                _AboutSection(pokemon: pokemon),
                const SizedBox(height: 24),
                const Text(
                  'Base Stats',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 16),
                _StatsList(stats: pokemon.stats, color: typeColor),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Color _getTypeColor(String type) {
    switch (type.toLowerCase()) {
      case 'fire': return Colors.orange;
      case 'water': return Colors.blue;
      case 'grass': return Colors.green;
      case 'electric': return Colors.yellow.shade700;
      case 'psychic': return Colors.pink;
      case 'ice': return Colors.cyan;
      case 'dragon': return Colors.indigo;
      case 'ghost': return Colors.purple;
      case 'poison': return Colors.deepPurple;
      case 'ground': return Colors.brown;
      case 'rock': return Colors.grey.shade700;
      case 'bug': return Colors.lightGreen;
      case 'fighting': return Colors.red.shade900;
      case 'normal': return Colors.grey;
      default: return Colors.blueGrey;
    }
  }
}

class _TypeBadges extends StatelessWidget {
  final List<String> types;
  const _TypeBadges({required this.types});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: types.map((type) => Container(
        margin: const EdgeInsets.only(right: 8),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color: Colors.white.withValues(alpha: 0.2),
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: Colors.white.withValues(alpha: 0.5)),
        ),
        child: Text(
          type.toUpperCase(),
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
      )).toList(),
    );
  }
}

class _AboutSection extends StatelessWidget {
  final Pokemon pokemon;
  const _AboutSection({required this.pokemon});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        _InfoItem(label: 'Weight', value: '${pokemon.weight / 10} kg'),
        _InfoItem(label: 'Height', value: '${pokemon.height / 10} m'),
      ],
    );
  }
}

class _InfoItem extends StatelessWidget {
  final String label;
  final String value;
  const _InfoItem({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(value, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        Text(label, style: const TextStyle(color: Colors.grey)),
      ],
    );
  }
}

class _StatsList extends StatelessWidget {
  final List<PokemonStat> stats;
  final Color color;
  const _StatsList({required this.stats, required this.color});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: stats.map((stat) => Padding(
        padding: const EdgeInsets.only(bottom: 12),
        child: Row(
          children: [
            SizedBox(
              width: 80,
              child: Text(
                stat.name.toUpperCase(),
                style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(width: 8),
            Text(
              stat.baseStat.toString().padLeft(3, '0'),
              style: const TextStyle(fontSize: 12),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: LinearProgressIndicator(
                  value: stat.baseStat / 255,
                  backgroundColor: Colors.grey.withValues(alpha: 0.2),
                  valueColor: AlwaysStoppedAnimation<Color>(color),
                  minHeight: 8,
                ),
              ),
            ),
          ],
        ),
      )).toList(),
    );
  }
}
