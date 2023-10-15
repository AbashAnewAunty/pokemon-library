import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../data_models/pokemon.dart';

final apiManagerProvider = Provider<ApiManager>((ref) => ApiManager());

class ApiManager {
  Future<http.Response> _getHttpResponse(String path) async {
    return await http.get(Uri.parse(path));
  }

  Future<Pokemon> getPokemon({required int id}) async {
    final response = await _getHttpResponse("https://pokeapi.co/api/v2/pokemon/$id/");
    final bodyJson = jsonDecode(response.body);
    return Pokemon.fromJson(bodyJson);
  }
}
