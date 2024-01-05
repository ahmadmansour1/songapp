import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../screens/home_page.dart';
import '../widgets/tab_bar.dart';

class ThemeApp extends StatelessWidget {
  const ThemeApp({super.key});

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
