import 'package:flicknest/core/services/storage_service.dart';
import 'package:flutter/material.dart';

import 'app.dart';
import 'core/bootstrap/app_initializer.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await StorageService.instance.init();
  await AppInitializer.initialize();
  runApp(const MyApp());
}
