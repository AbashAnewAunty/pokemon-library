import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pokemon_library/data_models/pokemon.dart';

final favoritePokemonNotifierProvider = StateNotifierProvider<FavoritePokemonNotifier, List<Pokemon>>((ref) => FavoritePokemonNotifier());

class FavoritePokemonNotifier extends StateNotifier<List<Pokemon>> {

  FavoritePokemonNotifier() : super([]);

  void addPokemon(Pokemon pokemon) {
    if (state.any((element) => element.id == pokemon.id)) {
      return;
    }

    state.add(pokemon);
  }

  void removePokemonId(int pokemonId){
    state.removeWhere((element) => element.id == pokemonId);
  }

  void reset(){
    state.clear();
  }


}
