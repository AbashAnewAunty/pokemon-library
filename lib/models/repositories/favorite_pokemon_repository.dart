import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pokemon_library/data_models/pokemon.dart';

final favoritePokemonNotifierProvider = StateNotifierProvider<FavoritePokemonNotifier, List<Pokemon>>((ref) => FavoritePokemonNotifier());

class FavoritePokemonNotifier extends StateNotifier<List<Pokemon>> {

  FavoritePokemonNotifier() : super([]);

  void addPokemon(Pokemon pokemon) {
    if (state.any((element) => element.id == pokemon.id)) {
      return;
    }

    /// NOTE: state.add(~) の書き方ではviewに変更が反映されない
    state = [...state, pokemon];
  }

  void removePokemonId(int pokemonId){
    /// NOTE: state.removeWhere(~) の書き方ではviewに変更が反映されない
    state = state.where((element) => element.id != pokemonId).toList();
  }

  void reset(){
    /// NOTE: state.clear() の書き方ではviewに変更が反映されない
    state = [];
  }


}
