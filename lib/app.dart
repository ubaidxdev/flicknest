import 'package:flicknest/core/providers/movie_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'core/routes/routes.dart';
import 'core/utils/app_them.dart';
import 'core/utils/context_utility.dart';

/// Main App Widget
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [ChangeNotifierProvider(create: (_) => MoviesProvider())],
      child: MaterialApp.router(
        title: 'Flick Nest',
        key: Ctx.navigatorKey,
        debugShowCheckedModeBanner: false,
        theme: appTheme,
        routerConfig: Routes.router,
      ),
    );
  }
}
