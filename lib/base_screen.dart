import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:pokemon_library/views/favorite_page.dart';
import 'package:pokemon_library/views/home_page.dart';
import 'package:pokemon_library/views/login_page.dart';

import 'models/repositories/user_repository.dart';

class BaseScreen extends StatelessWidget {
  final Widget child;
  final int currentIndex;

  const BaseScreen({
    super.key,
    required this.child,
    required this.currentIndex,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Pokemon Library"),
        actions: [
          Consumer(builder: (context, ref, _) {
            final user = ref.watch(authControllerProvider);

            return GestureDetector(
              onTap: () {
                Navigator.of(context, rootNavigator: true)
                    .push(MaterialPageRoute(builder: (_) => LoginPage()));
              },
              child: SizedBox(
                width: 100,
                height: 100,
                child: user != null
                    ? const Icon(Icons.person)
                    : const Icon(Icons.person_outline),
              ),
            );
          })
        ],
      ),
      body: Row(
        children: [
          NavigationRail(
            destinations: const [
              NavigationRailDestination(
                icon: Icon(Icons.home),
                label: Text("Home"),
              ),
              NavigationRailDestination(
                icon: Icon(Icons.favorite),
                label: Text("Favorite"),
              ),
            ],
            onDestinationSelected: (index) {
              switch (index) {
                case 0:
                  GoRouter.of(context).go("/list");
                  break;
                case 1:
                  GoRouter.of(context).go("/favorite");
                  break;
                default:
                  GoRouter.of(context).go("/list");
                  break;
              }
            },
            selectedIndex: currentIndex,
          ),
          Expanded(
            child: child,
          ),
        ],
      ),
    );
  }
}
