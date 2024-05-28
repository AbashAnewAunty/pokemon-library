import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:pokemon_library/domain/entity_notifier/pokemon_list_notifier.dart';
import 'package:pokemon_library/domain/repository/pokemon_repository_provider.dart';

import 'package:pokemon_library/views/views_common/my_loading_indicator.dart';

class HomePage extends ConsumerStatefulWidget {
  const HomePage({super.key});

  @override
  ConsumerState<HomePage> createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<HomePage> {
  late final Future<void> Function() _init;

  Future<void> _fetchPokemonList() async {
    final pokemonRepository = ref.read(pokemonRepositoryProvider);
    final pokeomnListNotifier = ref.read(pokemonListNotifierProvider.notifier);
    final pokemonList = await pokemonRepository.fetchPokemonList();
    pokeomnListNotifier.update(pokemonList);
  }

  @override
  void initState() {
    super.initState();
    _init = _fetchPokemonList;
  }

  @override
  Widget build(BuildContext context) {
    final pokemonList = ref.watch(pokemonListNotifierProvider);

    return Center(
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 750),
        child: FutureBuilder(
          future: _init(),
          builder: (context, snapshot) {
            if (snapshot.connectionState != ConnectionState.done) {
              return const MyLoadingIndicator();
            }

            return GridView.builder(
              gridDelegate: _gridViewDelegate(),
              itemCount: pokemonList.length,
              itemBuilder: (_, index) {
                final pokemon = pokemonList[index];
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
