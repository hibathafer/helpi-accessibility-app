import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'app.dart';
import 'core/di/app_container.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final prefs = await SharedPreferences.getInstance();

  // Composition root: repositories are wired once and handed to the widget tree.
  final container = AppContainer(prefs);
  await container.initialize();

  runApp(HelpIApp(container: container));
}
