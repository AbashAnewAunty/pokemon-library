import 'dart:convert';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pokemon_library/domain/entity/pokemon.dart';
import 'package:pokemon_library/models/managers/api_manager.dart';
import 'package:pokemon_library/models/managers/pref_manager.dart';

final pokemonRepositoryProvider = FutureProvider<List<Pokemon>>((ref) async {
  final pokemonRepository = PokemonRepository(
    apiManager: ref.read(apiManagerProvider),
    prefManager: ref.read(prefManagerProvider),
  );
  await pokemonRepository.fetchPokemonList(startId: 1, lastId: 26);
  return pokemonRepository.pokemonList;
});

class PokemonRepository {
  final ApiManager apiManager;
  final PrefManager prefManager;

  PokemonRepository({
    required this.apiManager,
    required this.prefManager,
  });

  final List<Pokemon> _pokemonList = [];

  List<Pokemon> get pokemonList => _pokemonList;

  Future<void> fetchPokemonList({
    required int startId,
    required int lastId,
  }) async {
    if (lastId - startId < 0) {
      return;
    }

    final List<Pokemon> tempList = [];
    final List<String> strList = [];
    _pokemonList.clear();

    final localPokemonList = await prefManager.getPokemonJsonList();
    if (localPokemonList.isNotEmpty) {
      /// キャッシュあり
      print("キャッシュがあったので採用");
      print("キャッシュ数: ${localPokemonList.length}");
      print("キャッシュ例: ${localPokemonList.first}");
      final b = jsonDecode(localPokemonList.first);
      print("キャッシュ例: ${b["name"]}");
      for (var element in localPokemonList) {
        tempList.add(Pokemon.fromJson(jsonDecode(element)));
      }
      print("キャッシュ呼び出し完了");
      print("キャッシュ数: ${tempList.length}");
    } else {
      /// キャッシュ無し
      print("キャッシュがなかったのでAPI実行");
      for (int i = startId; i <= lastId; i++) {
        final pokemon = await apiManager.getPokemon(id: i);
        tempList.add(pokemon);
        strList.add(jsonEncode(pokemon.toJson()));
      }
      await prefManager.setPokemonJsonList(strList);
      print("APIレスポンスをキャッシュに保存");
    }

    if (tempList.isEmpty) {
      return;
    }
    _pokemonList.addAll(tempList);
  }
}
