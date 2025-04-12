import 'dart:async';

import 'package:flicknest/core/providers/movie_provider.dart';
import 'package:flicknest/core/providers/them_provider.dart';
import 'package:flicknest/core/utils/app_colors.dart';
import 'package:flicknest/core/utils/extension.dart';
import 'package:flicknest/core/utils/files_path.dart';
import 'package:flicknest/core/widgets/app_background.dart';
import 'package:flicknest/core/widgets/themed_searchbar.dart';
import 'package:flicknest/view/02_home_screen/views/movie_card.dart';
import 'package:flicknest/view/03_favorite_screen/favorite_screen.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';

class HomeScreen extends StatefulWidget {
  static String name = 'HomeScreen'.toLowerCase();
  static String path = '/HomeScreen'.toLowerCase();

  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late final ScrollController _scrollController;
  Timer? _debounce;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController()..addListener(_onScroll);

    _debounce?.cancel();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<MoviesProvider>().loadInitialMovies();
    });
  }

  void _onSearchChanged(String query) {
    _debounce?.cancel();
    _debounce = Timer(const Duration(milliseconds: 500), () {
      if (query.isEmpty) {
        context.read<MoviesProvider>().clearSearch();
      } else {
        context.read<MoviesProvider>().searchMovies(query);
      }
    });
  }

  void _onScroll() {
    final provider = context.read<MoviesProvider>();
    if (_scrollController.position.pixels >= _scrollController.position.maxScrollExtent - 300 &&
        !provider.isPaginating &&
        provider.hasMore) {
      provider.loadMoreMovies();
    }
  }

  @override
  void dispose() {
    _scrollController.removeListener(_onScroll);
    _scrollController.dispose();
    super.dispose();
  }

  Widget _buildShimmerBox({double width = double.infinity, double height = 100}) {
    return Shimmer.fromColors(
      baseColor: Colors.grey[800]!,
      highlightColor: Colors.grey[600]!,
      child: Container(
        width: width,
        height: height,
        decoration: BoxDecoration(color: Colors.grey[700], borderRadius: BorderRadius.circular(12)),
      ),
    );
  }

  Widget _buildShimmerListItem() {
    return Card(
      color: Colors.black.withValues(alpha: .5),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      margin: const EdgeInsets.symmetric(vertical: 10),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Row(
          children: [
            _buildShimmerBox(width: 90, height: 130),
            12.pw,
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildShimmerBox(height: 18),
                  8.ph,
                  _buildShimmerBox(height: 14),
                  6.ph,
                  _buildShimmerBox(height: 14, width: 200),
                  10.ph,
                  _buildShimmerBox(height: 12, width: 120),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBody(MoviesProvider provider) {
    if (provider.isLoading && provider.popularMovies.isEmpty) {
      return ListView.builder(
        itemCount: 5,
        padding: const EdgeInsets.only(top: 10),
        itemBuilder: (_, __) => _buildShimmerListItem(),
      );
    }

    return RefreshIndicator(
      onRefresh: provider.loadInitialMovies,
      child: ListView.builder(
        controller: _scrollController,
        itemCount: provider.popularMovies.length + (provider.isPaginating ? 5 : 0),
        padding: const EdgeInsets.only(bottom: 20),
        itemBuilder: (context, index) {
          if (index < provider.popularMovies.length) {
            final movie = provider.popularMovies[index];
            return MovieCard(movie: movie);
          } else {
            return _buildShimmerListItem();
          }
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<MoviesProvider>();
    final themeprovider = context.watch<ThemProvider>();

    return AppBackGround(
      child: Scaffold(
        appBar: AppBar(
          title: Row(
            children: [
              Hero(
                tag: AppFiles.logo,
                child: Image.asset(AppFiles.logo, height: 50, color: Colors.white),
              ),
              Hero(
                tag: AppFiles.logoName,
                child: Image.asset(AppFiles.logoName, width: 100, color: Colors.white),
              ),
            ],
          ),
          actions: [
            IconButton(
              icon: Icon(
                themeprovider.isDark ? Icons.dark_mode : Icons.light_mode,
                color: AppColors.secondaryColor,
              ),
              onPressed: () {
                themeprovider.toggleTheme();
              },
            ),
            IconButton(
              icon: Icon(Icons.favorite_border, color: AppColors.secondaryColor),
              onPressed: () {
                context.pushNamed(FavoriteMoviesScreen.name);
              },
            ),
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            children: [
              Align(
                alignment: const Alignment(-0.8, 0.8),
                child: Text(
                  'Popular Movies',
                  style: context.heading.copyWith(color: AppColors.secondaryColor),
                ),
              ),
              10.ph,
              ThemedSearchBar(onChanged: _onSearchChanged),

              10.ph,
              Expanded(child: _buildBody(provider)),
            ],
          ),
        ),
      ),
    );
  }
}
