import 'package:flicknest/core/utils/error_handler.dart';
import 'package:flicknest/core/utils/system_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

/// Handles application-level bootstrapping
class AppInitializer {
  static Future<void> initialize() async {
    debugPrint('[AppInitializer] Starting initialization...');

    await _lockOrientation();
    debugPrint('[AppInitializer] Orientation locked.');

    SystemUI.setupOverlayStyle();
    debugPrint('[AppInitializer] System UI configured.');

    _setupErrorHandling();
    debugPrint('[AppInitializer] Error handling set.');

    debugPrint('[AppInitializer] Initialization complete.');
  }

  static Future<void> _lockOrientation() async {
    await SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
  }

  static void _setupErrorHandling() {
    setupErrorWidget();
  }
}
