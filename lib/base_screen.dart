import 'package:flutter/material.dart';
import 'package:pokemon_library/views/favorite_page.dart';
import 'package:pokemon_library/views/home_page.dart';

class BaseScreen extends StatefulWidget {
  const BaseScreen({Key? key}) : super(key: key);

  @override
  State<BaseScreen> createState() => _BaseScreenState();
}

class _BaseScreenState extends State<BaseScreen> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Pokemon Library")),
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
            onDestinationSelected: (index){
              setState(() {
                _selectedIndex = index;
              });
            },
            selectedIndex: _selectedIndex,
          ),
          Expanded(child: _selectedIndex == 0 ? HomePage() : FavoritePage()),
        ],
      ),
    );
  }
}
