import 'package:flutter/cupertino.dart';

class Ctx {
  static final GlobalKey<NavigatorState> _navigatorKey = GlobalKey<NavigatorState>();
  static GlobalKey<NavigatorState> get navigatorKey => _navigatorKey;

  static NavigatorState? get navigator => navigatorKey.currentState;

  static BuildContext? get context => navigator?.overlay?.context;

  /// Get the screen height
  static double get sheight {
    if (context != null) {
      return MediaQuery.of(context!).size.height;
    }

    throw Exception("Context is null. Ensure the navigator key is set up correctly.");
  }

  /// Get the screen width
  static double get swidth {
    if (context != null) {
      return MediaQuery.of(context!).size.width;
    }
    throw Exception("Context is null. Ensure the navigator key is set up correctly.");
  }
}
