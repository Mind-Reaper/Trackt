import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:trackt/app.dart';
import 'package:trackt/core/dependencies/service_locator.dart' as di;

void main() async {
   WidgetsFlutterBinding.ensureInitialized();
   await di.configureDependencies();
  runApp(const ProviderScope(child: MyApp()));
}
