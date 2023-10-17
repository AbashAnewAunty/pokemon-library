import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

final prefManagerProvider = Provider<PrefManager>((ref) => PrefManager());

class PrefManager {
  Future<void> setPokemonJsonList(List<String> jsonList) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setStringList("pokemonList", jsonList);
  }

  Future<List<String>> getPokemonJsonList() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getStringList("pokemonList") ?? [];
  }
}
