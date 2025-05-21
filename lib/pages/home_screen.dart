import 'dart:convert';

import 'package:animo/pages/details.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  List animo = [];
  @override
  void initState() {
    if (mounted) {
      fetchdata();
    }
    super.initState();
  }

  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Stack(
        children: [
          Positioned(
            top: -50,
            right: -50,
            child: Image.asset(
              'assets/animation/sari-removebg-preview.png',
              height: 250,
              width: 250,
              fit: BoxFit.fitHeight,
            ),
          ),
          Positioned(
            left: 20,
            top: 100,
            child: Text(
              "Poke'dex",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.red,
                fontSize: 35,
              ),
            ),
          ),
          Positioned(
            top: 200,
            bottom: 0,
            width: width,
            child: Column(
              children: [
                animo != null
                    ? Expanded(
                      child: GridView.builder(
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          childAspectRatio: 1.4,
                        ),
                        itemCount: animo.length,
                        itemBuilder: (context, index) {
                          var type = animo[index]['type'][0];
                          return Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: InkWell(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder:
                                        (_) => Details(
                                          colr:
                                              type == 'Grass'
                                                  ? Colors.green
                                                  : type == 'Fire'
                                                  ? Colors.red
                                                  : type == 'Water'
                                                  ? Colors.blue
                                                  : type == 'Electric'
                                                  ? Colors.yellow
                                                  : type == 'Rock'
                                                  ? Colors.brown
                                                  : Colors.pink,
                                          taq: index,
                                          animedet: animo[index],
                                        ),
                                  ),
                                );
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  color:
                                      type == 'Grass'
                                          ? Colors.green
                                          : type == 'Fire'
                                          ? Colors.red
                                          : type == 'Water'
                                          ? Colors.blue
                                          : type == 'Electric'
                                          ? Colors.yellow
                                          : type == 'Rock'
                                          ? Colors.brown
                                          : Colors.pink,
                                ),

                                child: Stack(
                                  children: [
                                    Positioned(
                                      right: -50,
                                      bottom: 0,
                                      child: Image.asset(
                                        'assets/animation/sari-removebg-preview.png',
                                        height: 100,
                                        width: 100,
                                        fit: BoxFit.fitHeight,
                                      ),
                                    ),
                                    Positioned(
                                      top: 15,
                                      left: 10,
                                      child: Text(
                                        animo[index]['name'],
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white,
                                          fontSize: 25,
                                        ),
                                      ),
                                    ),
                                    Positioned(
                                      bottom: 2,
                                      left: 2,
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Container(
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(
                                              20,
                                            ),
                                            color: Colors.white.withOpacity(
                                              0.2,
                                            ),
                                          ),
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Text(
                                              type,
                                              style: TextStyle(
                                                color: Colors.white,
                                                fontWeight: FontWeight.bold,
                                                fontSize: 15,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                    Positioned(
                                      bottom: 10,
                                      right: 10,
                                      child: Container(
                                        child: CachedNetworkImage(
                                          imageUrl: animo[index]['img'],
                                          height: 100,
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    )
                    : Center(child: CircularProgressIndicator()),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void fetchdata() {
    var url = Uri.https(
      "raw.githubusercontent.com",
      "Biuni/PokemonGo-Pokedex/master/pokedex.json",
    );
    http.get(url).then((value) {
      if (value.statusCode == 200) {
        var decodedata = jsonDecode(value.body);
        animo = decodedata["pokemon"];
        print(animo);
        setState(() {});
      }
    });
  }
}
