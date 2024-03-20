import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:lab7_exercise/model/movie.dart';
import 'package:http/http.dart' as http;

class FetchMovie extends StatefulWidget {
  const FetchMovie({super.key});

  @override
  State<FetchMovie> createState() => _FetchMovieState();
}

class _FetchMovieState extends State<FetchMovie> {
  List<Movie> _movies = [];

  @override
  void initState() {
    super.initState();
    _populateMovies();
  }

  Future<void> _populateMovies() async {
    final movies = await _fetchAllMovie();
    setState(() {
      _movies = movies;
    });
  }

  Future<List<Movie>> _fetchAllMovie() async {
    final response = await http.get(
        Uri.parse('https://www.omdbapi.com/?s=Batman&page=1&apikey=9bc69b16'));
    if (response.statusCode == 200) {
      final result = jsonDecode(response.body);
      Iterable list = result["Search"];
      return list.map((movie) => Movie.fromJson(movie)).toList();
    } else {
      throw Exception('Failed to load movies');
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Movies",
      home: Scaffold(
        appBar: AppBar(
          title: const Text("Movies"),
        ),
        body: MovieListing(
          movies: _movies,
        ),
      ),
    );
  }
}

class MovieListing extends StatelessWidget {
  final List<Movie> movies;
  const MovieListing({super.key, required this.movies});
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: movies.length,
      itemBuilder: (context, index) {
        final item = movies[index];
        return ListTile(
          title: Row(
            children: [
              SizedBox(
                width: 100,
                child: ClipRRect(
                  child: Image.network(item.poster),
                ),
              ),
              Flexible(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(item.title),
                      Text(item.type),
                      Text(item.year),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
