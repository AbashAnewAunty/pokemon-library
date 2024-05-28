import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pokemon_library/domain/entity/pokemon.dart';

final pokemonListNotifierProvider = NotifierProvider<PokemoListNotifier, List<Pokemon>>(() {
  return PokemoListNotifier();
});

class PokemoListNotifier extends Notifier<List<Pokemon>> {
  @override
  List<Pokemon> build() => [];

  void update(List<Pokemon> pokemonList) {
    state = [...pokemonList];
  }
}
