import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pokemon_library/models/repositories/favorite_pokemon_repository.dart';
import 'package:pokemon_library/views/views_common/my_loading_indicator.dart';

class FavoritePage extends ConsumerWidget {
  const FavoritePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Center(
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 750),
        child: Consumer(
          builder: (context, ref, _) {
            final favoritePokemonList =
                ref.watch(favoritePokemonNotifierProvider);
            return ListView.builder(
              itemCount: favoritePokemonList.length,
              itemBuilder: (context, index) {
                final pokemon = favoritePokemonList[index];
                return ListTile(
                  leading: CachedNetworkImage(
                    imageUrl: pokemon.spriteUrlFrontDefault,
                    placeholder: (context, url) => const MyLoadingIndicator(),
                    errorWidget: (context, url, error) =>
                        const Icon(Icons.error),
                  ),
                  title: Text("No.${pokemon.id}: ${pokemon.name}"),
                  trailing: GestureDetector(
                    onTap: () {
                      final favoritePokemonNotifier =
                          ref.read(favoritePokemonNotifierProvider.notifier);
                      favoritePokemonNotifier.removePokemonId(pokemon.id);
                    },
                    behavior: HitTestBehavior.opaque,
                    child: const Icon(Icons.delete),
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }
}
