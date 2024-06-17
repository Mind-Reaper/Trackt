import 'package:flutter/material.dart';
import 'package:trackt/features/todo/external/presentation/pages/project_page.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Trackt',
      theme:
          ThemeData(useMaterial3: true, colorSchemeSeed: Colors.blue),
      home: const ProjectPage(),
    );
  }
}
