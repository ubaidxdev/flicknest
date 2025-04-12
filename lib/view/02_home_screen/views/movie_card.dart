import 'package:cached_network_image_plus/flutter_cached_network_image_plus.dart';
import 'package:flicknest/core/models/movie_model.dart';
import 'package:flicknest/core/providers/movie_provider.dart';
import 'package:flicknest/core/utils/app_colors.dart';
import 'package:flicknest/core/utils/extension.dart';
import 'package:flicknest/view/04_movie_details_screen/movie_details.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class MovieCard extends StatelessWidget {
  final Movie movie;

  const MovieCard({super.key, required this.movie});

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<MoviesProvider>();
    final isFavorite = provider.isFavorite(movie);

    return MaterialButton(
      onPressed: () {
        context.pushNamed(MovieDetailsScreen.name, extra: movie);
      },
      padding: EdgeInsets.zero,
      child: Card(
        color: Colors.black.withValues(alpha: .5),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        margin: const EdgeInsets.symmetric(vertical: 10),
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Poster Image with CachedNetworkImagePlus
              ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: CacheNetworkImagePlus(
                  imageUrl: 'https://image.tmdb.org/t/p/w300${movie.posterPath}',
                  width: 90,
                  height: 130,

                  errorWidget: const Icon(Icons.broken_image, size: 90, color: Colors.white),
                ),
              ),
              12.pw,
              // Title, Overview, Rating
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(movie.title, style: context.title.copyWith(color: Colors.white)),
                    6.ph,
                    Text(
                      movie.overview,
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                      style: context.body.copyWith(color: Colors.white70),
                    ),
                    8.ph,
                    RatingBarIndicator(
                      rating: movie.voteAverage / 2,
                      itemBuilder: (context, _) => const Icon(Icons.star, color: Colors.amber),
                      itemCount: 5,
                      itemSize: 18,
                      direction: Axis.horizontal,
                    ),
                  ],
                ),
              ),
              IconButton(
                icon: Icon(
                  isFavorite ? Icons.favorite : Icons.favorite_border,
                  color: AppColors.secondaryColor,
                ),
                onPressed: () => provider.toggleFavorite(movie),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
