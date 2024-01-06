import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../screens/home_page.dart';
import '../widgets/tab_bar.dart';

class ThemeApp extends StatelessWidget {
  const ThemeApp({super.key});
  static final TextTheme myTextStyle = TextTheme(
    titleMedium: TextStyle(
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
      title: 'Flutter Demo',
      theme: ThemeData(

          bottomNavigationBarTheme: BottomNavigationBarThemeData(
            backgroundColor:Color(0xFF3B3B3B) ,
            selectedItemColor: Colors.white, // Customize the selected item color

            unselectedItemColor: Colors.white38, // Customize the unselected item color
          ),
        textTheme: myTextStyle,



        appBarTheme:const  AppBarTheme(
            color: Color(0xFF3B3B3B),
            elevation: 0.0
        ) ,
        scaffoldBackgroundColor: const Color(0xFF3B3B3B),


      ),
      home:TabBarApp(),
    );
  }
}
