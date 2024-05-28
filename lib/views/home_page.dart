import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:pokemon_library/domain/entity/pokemon.dart';
import 'package:pokemon_library/models/repositories/pokemon_repository.dart';
import 'package:pokemon_library/views/views_common/my_loading_indicator.dart';

class HomePage extends ConsumerWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final AsyncValue<List<Pokemon>> pokemonRepository = ref.watch(pokemonRepositoryProvider);

    return Center(
      child: Container(
        constraints: const BoxConstraints(maxWidth: 750),
        child: pokemonRepository.when(
          data: (data) {
            return GridView.builder(
              gridDelegate: _gridViewDelegate(),
              itemCount: data.length,
              itemBuilder: (_, index) {
                final pokemon = data[index];
                return GestureDetector(
                  onTap: () {
                    GoRouter.of(context).go("/list/detail", extra: pokemon);
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border.all(),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Hero(
                          tag: pokemon.name,
                          child: CachedNetworkImage(
                            imageUrl: pokemon.spriteUrlFrontDefault,
                            placeholder: (context, url) => const MyLoadingIndicator(),
                            errorWidget: (context, url, error) => const Icon(Icons.error),
                          ),
                        ),
                        Text("No.${pokemon.id} ${pokemon.name}"),
                      ],
                    ),
                  ),
                );
              },
            );
          },
          error: (err, _) => Text(err.toString()),
          loading: () => const MyLoadingIndicator(),
        ),
      ),
    );
  }

  SliverGridDelegateWithFixedCrossAxisCount _gridViewDelegate() {
    return const SliverGridDelegateWithFixedCrossAxisCount(
      crossAxisCount: 3,
      mainAxisSpacing: 5,
      crossAxisSpacing: 5,
      childAspectRatio: 1.5,
    );
  }
}
