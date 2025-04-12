import 'package:cached_network_image_plus/flutter_cached_network_image_plus.dart';
import 'package:flicknest/core/models/movie_model.dart';
import 'package:flicknest/core/providers/movie_provider.dart';
import 'package:flicknest/core/utils/extension.dart';
import 'package:flicknest/core/widgets/app_background.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';

class MovieDetailsScreen extends StatelessWidget {
  static String name = 'moviedetailsscreen'.toLowerCase();
  static String path = '/moviedetailsscreen'.toLowerCase();
  final Movie movie;

  const MovieDetailsScreen({super.key, required this.movie});

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<MoviesProvider>();
    final isFavorite = provider.isFavorite(movie);
    return AppBackGround(
      child: Scaffold(
        appBar: AppBar(title: Text(movie.title)),
        floatingActionButton: FloatingActionButton.extended(
          onPressed: () {
            provider.toggleFavorite(movie);
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(isFavorite ? 'Removed from favorites' : 'Added to favorites'),
                duration: const Duration(seconds: 2),
              ),
            );
          },
          label: Text(isFavorite ? 'Remove from favorites' : 'Add to favorites'),
          icon: const Icon(Icons.favorite),
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: CacheNetworkImagePlus(
                  imageUrl: 'https://image.tmdb.org/t/p/w500${movie.posterPath}',
                  width: 200,
                  height: 400,
                  boxFit: BoxFit.contain,
                  shimmerDirection: ShimmerDirection.ltr,
                  errorWidget: const Icon(Icons.error, size: 100),
                ),
              ),
              const SizedBox(height: 16),
              Text(movie.title, style: Theme.of(context).textTheme.headlineSmall),
              const SizedBox(height: 8),
              Row(
                children: [
                  RatingBarIndicator(
                    rating: movie.voteAverage / 2,
                    itemBuilder: (context, index) => const Icon(Icons.star, color: Colors.amber),
                    itemCount: 5,
                    itemSize: 24.0,
                    unratedColor: Colors.grey.shade300,
                    direction: Axis.horizontal,
                  ),
                  const SizedBox(width: 8),
                  Text('${movie.voteAverage.toString()}/10'),
                  const SizedBox(width: 10),
                  Text('(${movie.voteCount} votes)'),
                ],
              ),
              const SizedBox(height: 16),
              Text('Overview', style: Theme.of(context).textTheme.titleLarge),
              const SizedBox(height: 8),
              Text(movie.overview),
              const SizedBox(height: 16),
              Text('Release Date: ${movie.releaseDate}'),
              const SizedBox(height: 8),
              Text('Language: ${movie.originalLanguage}'),
              const SizedBox(height: 8),
              Text('Popularity: ${movie.popularity}'),
              100.ph,
            ],
          ),
        ),
      ),
    );
  }
}
