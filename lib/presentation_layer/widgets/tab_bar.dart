import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:songapp/presentation_layer/screens/home_page.dart';

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
      currentIndex: _currentIndex,
      onTap: (index) {
        setState(() {
          _currentIndex = index;
        });
      },

        items: const [
    BottomNavigationBarItem(icon:Icon(Icons.home, color: Colors.white10,),label: "home"),
          BottomNavigationBarItem(icon:Icon(Icons.search),label: "search"),
          BottomNavigationBarItem(icon:Icon(Icons.podcasts),label: "podcast"),
          BottomNavigationBarItem(icon:Icon(Icons.settings),label: "settings"),] ,


    ) , body: _buildTabBarView(_currentIndex),);
  }
  Widget _buildTabBarView(_currentIndex) {
    switch (_currentIndex) {
      case 0:
        return const HomePage();
      default:
        return const SizedBox.shrink();
    }
  }
}


