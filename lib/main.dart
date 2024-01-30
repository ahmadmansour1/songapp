import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:songapp/provider/provider.dart';
import 'package:songapp/utils/theme_data.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => SongsProvider(),
      child: const SongApp(),
    ),
  );
}

class SongApp extends StatelessWidget {
  const SongApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ThemeApp();
  }
}
