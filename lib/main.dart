import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gallery/screens/home_screen.dart';

final theme = ThemeData.dark().copyWith(
  colorScheme: ColorScheme.fromSeed(
    seedColor: Colors.lightBlueAccent,
    brightness: Brightness.dark,
    surface: Colors.blueGrey.shade800,
  ),
  scaffoldBackgroundColor: Color.fromARGB(255, 50, 58, 60),
);

void main() {
  runApp(ProviderScope(child: GalleryApp()));
}

class GalleryApp extends StatelessWidget {
  const GalleryApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(theme: theme, home: HomeScreen());
  }
}
