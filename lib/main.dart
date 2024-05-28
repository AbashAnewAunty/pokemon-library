import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:pokemon_library/base_screen.dart';
import 'package:pokemon_library/domain/entity/pokemon.dart';
import 'package:pokemon_library/views/favorite_page.dart';
import 'package:pokemon_library/views/home_page.dart';
import 'package:pokemon_library/views/pokemon_detail_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'firebase_options.dart';

void main() async {
  /// webでsharedPrefが動作しないバグ対応
  /// https://cloud.tencent.com/developer/article/1870603
  /// おそらく本来はこちらで対処すべき？
  /// https://stackoverflow.com/questions/56417667/how-to-save-to-web-local-storage-in-flutter-web
  SharedPreferences.setMockInitialValues({});

  /// init firebase
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(RouteApp());
}

class RouteApp extends StatelessWidget {
  RouteApp({super.key});

  final GoRouter _router = GoRouter(
    initialLocation: "/list",
    routes: <RouteBase>[
      ShellRoute(
        builder: (context, state, child) {
          return BaseScreen(
            currentIndex: switch (state.uri.path) {
              var p when p.startsWith('/favorite') => 1,
              _ => 0,
            },
            child: child,
          );
        },
        routes: <RouteBase>[
          GoRoute(
            path: "/list",
            pageBuilder: (context, state) {
              return MaterialPage(
                key: state.pageKey,
                child: const HomePage(),
              );
            },
            routes: <RouteBase>[
              GoRoute(
                path: "detail",
                pageBuilder: (context, state) {
                  return MaterialPage(
                    child: PokemonDetailPage(pokemon: state.extra as Pokemon),
                  );
                },
              )
            ],
          ),
          GoRoute(
            path: "/favorite",
            pageBuilder: (context, state) {
              return MaterialPage(
                key: state.pageKey,
                child: const FavoritePage(),
              );
            },
          )
        ],
      ),
    ],
  );

  @override
  Widget build(BuildContext context) {
    return ProviderScope(
      child: MaterialApp.router(
        title: 'Flutter Demo',
        theme: ThemeData(
          colorSchemeSeed: Colors.pink,
          useMaterial3: true,
        ),
        routerConfig: _router,
        builder: (context, child) {
          return child!;
        },
      ),
    );
  }
}

// class MyApp extends StatelessWidget {
//   const MyApp({super.key});
//
//   // This widget is the root of your application.
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Flutter Demo',
//       debugShowCheckedModeBanner: false,
//       theme: ThemeData(
//         colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
//         useMaterial3: true,
//       ),
//       home: const BaseScreen(),
//     );
//   }
// }
