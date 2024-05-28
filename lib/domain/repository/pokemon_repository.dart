import 'package:pokemon_library/domain/entity/pokemon.dart';

abstract class PokemonRepository {
  Future<List<Pokemon>> fetchPokemonList();
}
