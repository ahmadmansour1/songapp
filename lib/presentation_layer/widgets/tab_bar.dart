import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:songapp/presentation_layer/screens/home_page.dart';
import 'package:songapp/presentation_layer/screens/podcast_page.dart';

class TabBarApp extends StatefulWidget {
  const TabBarApp({super.key});

  @override
  State<TabBarApp> createState() => _TabBarAppState();
}

class _TabBarAppState extends State<TabBarApp> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {

    return Scaffold(bottomNavigationBar: BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      currentIndex: _currentIndex,
      onTap: (index) {
        setState(() {
          _currentIndex = index;
        });
      },

        items:  const [
    BottomNavigationBarItem(icon:Icon(Icons.home_rounded,),label: "home",),
          BottomNavigationBarItem(icon:Icon(Icons.search),label: "search"),
          BottomNavigationBarItem(icon: Icon(Icons.library_music), label: "Podcast"),
          BottomNavigationBarItem(icon:Icon(Icons.settings),label: "settings"),] ,


    ) , body: _buildTabBarView(_currentIndex),);
  }
  Widget _buildTabBarView(_currentIndex) {
    switch (_currentIndex) {
      case 0:
        return const HomePage();
      case 1:
        return HomePage();
      case 2:
        return PodcastPage();
      default:
        return HomePage();
    }
  }
}


