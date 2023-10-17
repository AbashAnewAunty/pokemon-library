import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../data_models/pokemon.dart';
import '../../enum.dart';

final apiManagerProvider = Provider<ApiManager>((ref) => ApiManager());

class ApiManager {
  Future<http.Response> _getHttpResponse(String path) async {
    return await http.get(Uri.parse(path));
  }

  Future<Pokemon> getPokemon({required int id}) async {
    final response =
        await _getHttpResponse("https://pokeapi.co/api/v2/pokemon/$id/");
    final bodyJson = jsonDecode(response.body);
    return _convertPokemonFromApiResponse(bodyJson);
  }

  Pokemon _convertPokemonFromApiResponse(Map<String, dynamic> json) {
    return Pokemon(
      id: json["id"],
      name: json["name"],
      heightM: json["height"] / 10,
      weightKg: json["weight"] / 10,
      spriteUrlFrontDefault: json['sprites']['front_default'],
      hp: json["stats"][0]["base_stat"],
      attack: json["stats"][1]["base_stat"],
      defense: json["stats"][2]["base_stat"],
      specialAttack: json["stats"][3]["base_stat"],
      specialDefense: json["stats"][4]["base_stat"],
      speed: json["stats"][5]["base_stat"],
      types: (json["types"] as List).map((e) {
        return PokeType.values.firstWhere((pokeTypeEnum) {
          return pokeTypeEnum.name == e["type"]["name"];
        });
      }).toList(),
    );
  }
}
