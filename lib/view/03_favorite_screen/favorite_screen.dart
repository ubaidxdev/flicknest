import 'package:flicknest/core/models/movie_model.dart';
import 'package:flicknest/core/providers/movie_provider.dart';
import 'package:flicknest/core/widgets/app_background.dart';
import 'package:flicknest/view/02_home_screen/views/movie_card.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

/// A screen to display the list of favorite movies.
class FavoriteMoviesScreen extends StatelessWidget {
  static String name = 'FavoriteMoviesScreen'.toLowerCase();
  static String path = '/FavoriteMoviesScreen'.toLowerCase();
  const FavoriteMoviesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Access the MoviesProvider instance.
    final moviesProvider = Provider.of<MoviesProvider>(context);
    final List<Movie> favoriteMovies = moviesProvider.favorites;

    return AppBackGround(
      child: Scaffold(
        appBar: AppBar(title: const Text('Favorite Movies')),
        body:
            favoriteMovies.isEmpty
                ? const Center(
                  child: Text('No favorites added yet.', style: TextStyle(fontSize: 16)),
                )
                : ListView.builder(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  itemCount: favoriteMovies.length,
                  itemBuilder: (context, index) {
                    final movie = favoriteMovies[index];
                    return MovieCard(movie: movie);
                  },
                ),
      ),
    );
  }
}
