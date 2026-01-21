import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pokemanriverpod/src/core/theme/app_theme.dart';
import 'package:pokemanriverpod/dependencyinjection/service_locator.dart';
import 'package:pokemanriverpod/pages/home_page.dart';

void main() {
  setUp();
  runApp(
    ProviderScope(
      child: MaterialApp(
        title: 'ThyPok',
        debugShowCheckedModeBanner: false,
        theme: AppTheme.light,
        darkTheme: AppTheme.dark,
        themeMode: ThemeMode.system,
        home: const HomePage(),
      ),
    ),
  );
}
