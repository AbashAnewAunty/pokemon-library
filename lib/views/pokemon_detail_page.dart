import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pokemon_library/data_models/pokemon.dart';
import 'package:pokemon_library/models/repositories/favorite_pokemon_repository.dart';
import 'package:pokemon_library/views/views_common/my_loading_indicator.dart';
import 'package:pokemon_library/views/views_common/my_radar_chart.dart';

import '../models/repositories/user_repository.dart';
import 'login_page.dart';

class PokemonDetailPage extends StatelessWidget {
  final Pokemon pokemon;

  const PokemonDetailPage({
    super.key,
    required this.pokemon,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Align(
        alignment: Alignment.topCenter,
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 750),
          child: SingleChildScrollView(
            child: Column(
              children: [
                AppBar(
                  title: const Text("Pokemon Detail"),
                  actions: [
                    GestureDetector(
                      onTap: () {
                        Navigator.of(context, rootNavigator: true)
                            .push(MaterialPageRoute(builder: (_) => LoginPage()));
                      },
                      child: Consumer(builder: (context, ref, _) {
                        final user = ref.watch(authControllerProvider);
                        return SizedBox(
                          width: 100,
                          height: 100,
                          child: user != null
                              ? const Icon(Icons.person)
                              : const Icon(Icons.person_outline),
                        );
                      }),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    SizedBox(
                      width: 100,
                      height: 100,
                      child: Consumer(
                        builder: (context, ref, _) {
                          final favoritePokemonList =
                              ref.watch(favoritePokemonNotifierProvider);
                          return favoritePokemonList.any(
                                  (element) => element.id == pokemon.id)
                              ? GestureDetector(
                                  onTap: () {
                                    final favoritePokemonListNotifier =
                                        ref.read(
                                            favoritePokemonNotifierProvider
                                                .notifier);
                                    favoritePokemonListNotifier
                                        .removePokemonId(pokemon.id);
                                  },
                                  child: const Icon(Icons.favorite),
                                )
                              : GestureDetector(
                                  onTap: () {
                                    final favoritePokemonListNotifier =
                                        ref.read(
                                            favoritePokemonNotifierProvider
                                                .notifier);

                                    favoritePokemonListNotifier
                                        .addPokemon(pokemon);
                                  },
                                  child: const Icon(Icons.favorite_border),
                                );
                        },
                      ),
                    )
                  ],
                ),
                Hero(
                  tag: pokemon.name,
                  child: CachedNetworkImage(
                    imageUrl: pokemon.spriteUrlFrontDefault,
                    placeholder: (context, url) =>
                        const MyLoadingIndicator(),
                    errorWidget: (context, url, error) =>
                        const Icon(Icons.error),
                  ),
                ),
                Text("No.${pokemon.id} ${pokemon.name}"),
                const SizedBox(height: 10),
                Text("height: ${pokemon.heightM} m"),
                Text("weight: ${pokemon.weightKg} kg"),
                for (int i = 0; i < pokemon.types.length; i++)
                  Text("type${i + 1}: ${pokemon.types[i].name}"),
                const SizedBox(height: 60),
                SizedBox(
                  width: 200,

                  /// NOTE: RadarChartの親にAspectRatioを定義しないとエラー発生
                  child: MyRadarCart(pokemon: pokemon),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
