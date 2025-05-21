import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  var animoApi =
      "https://raw.githubusercontent.com/Biuni/Pokemon.Go-Pokedex/master/pokedex.json";
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ElevatedButton(onPressed: () {}, child: Text('button')),
      ),
    );
  }

  void fetchdata() {
    var url = Uri.https(
      "raw.githubusercontent.com",
      "Biuni/Pokemon.Go-Pokedex/master/pokedex.json",
    );
  }
}
