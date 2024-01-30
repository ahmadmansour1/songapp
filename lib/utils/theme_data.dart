import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../view/widgets/tab_bar.dart';

class ThemeApp extends StatelessWidget {
   ThemeApp({super.key});
   Color mainColor  = Color(0xFF222932);
   static const TextTheme myTextStyle = TextTheme(
     titleMedium:  TextStyle(
      fontSize: 20,
      color: Colors.white,
      fontWeight: FontWeight.bold,
    ),
    titleSmall: TextStyle(
      fontSize: 20,
      color: Colors.white,
    ),
  );

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme:  ThemeData(

        bottomNavigationBarTheme: const BottomNavigationBarThemeData(
          backgroundColor: Color(0xFF3B3B3B),
          selectedItemColor: Colors.white,
          // Customize the selected item color

          unselectedItemColor: Colors
              .white38, // Customize the unselected item color
        ),
        textTheme: myTextStyle,


        appBarTheme:  AppBarTheme(
            color: mainColor,
            elevation: 0.0
        ),
        scaffoldBackgroundColor:  mainColor,


      ),
      home: TabBarApp(),
    );
  }
}
