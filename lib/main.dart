import 'package:flutter/material.dart';
import 'package:songapp/presentation_layer/utils/theme_data.dart';
import 'package:provider/provider.dart';
import 'package:songapp/service/provider.dart';

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
