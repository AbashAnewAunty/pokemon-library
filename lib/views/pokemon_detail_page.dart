import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pokemon_library/data_models/pokemon.dart';
import 'package:pokemon_library/models/repositories/favorite_pokemon_repository.dart';
import 'package:pokemon_library/views/views_common/my_loading_indicator.dart';
import 'package:pokemon_library/views/views_common/my_radar_chart.dart';

class PokemonDetailPage extends StatelessWidget {
  final Pokemon pokemon;

  const PokemonDetailPage({
    super.key,
    required this.pokemon,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Center(
        child: SingleChildScrollView(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 750),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    SizedBox(
                      height: 50,
                      width: 50,
                      child: GestureDetector(
                        onTap: () => Navigator.of(context).pop(),
                        behavior: HitTestBehavior.opaque,
                        child: const Icon(Icons.chevron_left),
                      ),
                    ),
                    Consumer(
                      builder: (context, ref, _) {
                        final favoritePokemonList =
                            ref.watch(favoritePokemonNotifierProvider);
                        return favoritePokemonList
                                .any((element) => element.id == pokemon.id)
                            ? GestureDetector(
                                onTap: () {
                                  final favoritePokemonListNotifier = ref.read(
                                      favoritePokemonNotifierProvider.notifier);
                                  favoritePokemonListNotifier
                                      .removePokemonId(pokemon.id);
                                },
                                child: const Icon(Icons.favorite),
                              )
                            : GestureDetector(
                                onTap: () {
                                  final favoritePokemonListNotifier = ref.read(
                                      favoritePokemonNotifierProvider.notifier);

                                  favoritePokemonListNotifier
                                      .addPokemon(pokemon);
                                },
                                child: const Icon(Icons.favorite_border),
                              );
                      },
                    )
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
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
                  ],
                ),
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
