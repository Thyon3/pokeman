import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pokemanriverpod/dependencyinjection/service_locator.dart';
import 'package:pokemanriverpod/pages/home_page.dart';
import 'package:pokemanriverpod/util/theme.dart';

void main() {
  setUp();
  runApp(
    ProviderScope(
      child: MaterialApp(
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.black38),
          textTheme: textTheme,
        ),

        title: 'ThyPok',
        debugShowCheckedModeBanner: false,
        home: HomePage(),
      ),
    ),
  );
}
