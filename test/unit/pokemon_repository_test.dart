import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:pokemanriverpod/src/features/pokemon/data/repositories/pokemon_repository_impl.dart';
import 'package:pokemanriverpod/src/features/pokemon/data/sources/pokemon_local_data_source.dart';
import 'package:pokemanriverpod/src/features/pokemon/data/sources/pokemon_remote_data_source.dart';
import 'package:pokemanriverpod/src/features/pokemon/data/models/pokemon_short_model.dart';

class MockRemoteDataSource extends Mock implements PokemonRemoteDataSource {}
class MockLocalDataSource extends Mock implements PokemonLocalDataSource {}

void main() {
  late PokemonRepositoryImpl repository;
  late MockRemoteDataSource mockRemoteDataSource;
  late MockLocalDataSource mockLocalDataSource;

  setUp(() {
    mockRemoteDataSource = MockRemoteDataSource();
    mockLocalDataSource = MockLocalDataSource();
    repository = PokemonRepositoryImpl(mockRemoteDataSource, mockLocalDataSource);
  });

  group('getPokemonList', () {
    final tPokemonList = [
      PokemonShortModel(name: 'bulbasaur', url: 'https://pokeapi.co/api/v2/pokemon/1/'),
    ];

    test('should return remote data when the call to remote data source is successful', () async {
      // arrange
      when(() => mockRemoteDataSource.getPokemonList(limit: any(named: 'limit'), offset: any(named: 'offset')))
          .thenAnswer((_) async => tPokemonList);
      when(() => mockLocalDataSource.cachePokemonList(any(), offset: any(named: 'offset')))
          .thenAnswer((_) async => Future.value());

      // act
      final result = await repository.getPokemonList();

      // assert
      expect(result, equals(tPokemonList));
      verify(() => mockRemoteDataSource.getPokemonList(limit: 20, offset: 0));
      verify(() => mockLocalDataSource.cachePokemonList(tPokemonList, offset: 0));
    });

    test('should return cached data when the call to remote data source is unsuccessful', () async {
      // arrange
      when(() => mockRemoteDataSource.getPokemonList(limit: any(named: 'limit'), offset: any(named: 'offset')))
          .thenThrow(Exception());
      when(() => mockLocalDataSource.getCachedPokemonList(offset: any(named: 'offset')))
          .thenReturn(tPokemonList);

      // act
      final result = await repository.getPokemonList();

      // assert
      expect(result, equals(tPokemonList));
      verify(() => mockLocalDataSource.getCachedPokemonList(offset: 0));
    });
  });
}
