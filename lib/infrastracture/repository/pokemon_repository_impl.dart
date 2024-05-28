import 'package:pokemon_library/domain/entity/pokemon.dart';
import 'package:pokemon_library/domain/repository/pokemon_repository.dart';
import 'package:pokemon_library/models/managers/api_manager.dart';

class PokemonRepositoryImpl implements PokemonRepository {
  late final ApiManager _apiManager;

  PokemonRepositoryImpl({
    required ApiManager apiManager,
  }) {
    _apiManager = apiManager;
  }

  @override
  Future<List<Pokemon>> fetchPokemonList() async {
    final pokemonList = <Pokemon>[];
    for (int i = 0; i < 26; i++) {
      final pokemon = await _apiManager.getPokemon(id: i);
      pokemonList.add(pokemon);
    }
    return pokemonList;
  }
}
