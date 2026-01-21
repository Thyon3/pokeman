import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pokemanriverpod/src/core/theme/app_theme.dart';
import 'package:pokemanriverpod/src/core/di/injection.dart';
import 'package:pokemanriverpod/src/features/pokemon/presentation/pages/pokemon_list_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initDependencies();
  runApp(
    ProviderScope(
      child: MaterialApp(
        title: 'ThyPok',
        debugShowCheckedModeBanner: false,
        theme: AppTheme.light,
        darkTheme: AppTheme.dark,
        themeMode: ThemeMode.system,
        home: const PokemonListPage(),
      ),
    ),
  );
}
