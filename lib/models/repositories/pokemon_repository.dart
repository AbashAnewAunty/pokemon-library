import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pokemon_library/models/managers/api_manager.dart';

import '../../data_models/pokemon.dart';

final pokemonRepositoryProvider = FutureProvider<List<Pokemon>>((ref) async {
  final pokemonRepository =
      PokemonRepository(apiManager: ref.read(apiManagerProvider));
  await pokemonRepository.fetchPokemonList(startId: 1, lastId: 151);
  return pokemonRepository.pokemonList;
});

class PokemonRepository {
  final ApiManager apiManager;

  PokemonRepository({required this.apiManager});

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
    for (int i = startId; i <= lastId; i++) {
      final pokemon = await apiManager.getPokemon(id: i);
      tempList.add(pokemon);
      print("get ${pokemon.name}");
    }

    _pokemonList.addAll(tempList);
  }
}
