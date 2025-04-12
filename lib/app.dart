import 'package:flicknest/core/providers/movie_provider.dart';
import 'package:flicknest/core/providers/them_provider.dart';
import 'package:flicknest/core/utils/app_them.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'core/routes/routes.dart';
import 'core/utils/context_utility.dart';

/// Main App Widget
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ThemProvider()),
        ChangeNotifierProvider(create: (_) => MoviesProvider()),
      ],
      child: Selector<ThemProvider, bool>(
        selector: (p0, p1) => p1.isDark,
        builder:
            (context, value, child) => MaterialApp.router(
              title: 'Flick Nest',
              key: Ctx.navigatorKey,
              debugShowCheckedModeBanner: false,
              theme: appLightTheme,
              darkTheme: appTheme,
              themeMode: context.watch<ThemProvider>().isDark ? ThemeMode.dark : ThemeMode.light,
              routerConfig: Routes.router,
            ),
      ),
    );
  }
}
