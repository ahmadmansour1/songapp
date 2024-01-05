import 'package:flutter/material.dart';
import 'package:songapp/presentation_layer/screens/home_page.dart';
import 'package:songapp/presentation_layer/utils/theme_data.dart';

void main() {
  runApp(const SongApp());
}

class SongApp extends StatelessWidget {
  const SongApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return const ThemeApp(
    );
  }
}

