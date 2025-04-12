import 'package:flicknest/core/models/movie_model.dart';
import 'package:flicknest/view/00_splash_screen/splash_screen.dart';
import 'package:flicknest/view/01_onboarding_screen/onboardin_screen.dart';
import 'package:flicknest/view/02_home_screen/home_screen.dart';
import 'package:flicknest/view/03_favorite_screen/favorite_screen.dart';
import 'package:flicknest/view/04_movie_details_screen/movie_details.dart';
// ignore: implementation_imports
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/widgets.dart' show Offset, SlideTransition, Tween;
import 'package:go_router/go_router.dart';

class Routes {
  static final GoRouter router = GoRouter(
    routes: [
      GoRoute(
        path: SplashScreen.routePath,
        name: SplashScreen.routeName,
        builder: (context, state) => const SplashScreen(),
      ),

      GoRoute(
        path: OnboardingScreen.path,
        name: OnboardingScreen.name,
        pageBuilder: (context, state) {
          return CustomTransitionPage(
            key: state.pageKey,
            child: const OnboardingScreen(),
            transitionsBuilder: slideTransition,
          );
        },
      ),
      GoRoute(
        path: HomeScreen.path,
        name: HomeScreen.name,
        pageBuilder: (context, state) {
          return CustomTransitionPage(
            key: state.pageKey,
            child: const HomeScreen(),
            transitionsBuilder: slideTransition,
          );
        },
      ),
      GoRoute(
        path: FavoriteMoviesScreen.path,
        name: FavoriteMoviesScreen.name,
        pageBuilder: (context, state) {
          return CustomTransitionPage(
            key: state.pageKey,
            child: const FavoriteMoviesScreen(),
            transitionsBuilder: slideTransition,
          );
        },
      ),
      GoRoute(
        path: MovieDetailsScreen.path,
        name: MovieDetailsScreen.name,
        pageBuilder: (context, state) {
          final movie = state.extra as Movie;
          return CustomTransitionPage(
            key: state.pageKey,
            child: MovieDetailsScreen(movie: movie),
            transitionsBuilder: slideTransition,
          );
        },
      ),
    ],
  );

  static Widget slideTransition(context, animation, secondaryAnimation, child) {
    return SlideTransition(
      position: Tween<Offset>(begin: const Offset(1, 0), end: Offset.zero).animate(animation),
      child: child,
    );
  }
}
