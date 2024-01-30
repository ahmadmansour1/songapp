import 'package:flutter/material.dart';
import 'package:songapp/view/screens/home_page.dart';
import 'package:songapp/view/screens/search_page.dart';
import 'package:songapp/view/screens/setting_page.dart';

import '../screens/podcast_page.dart';

class TabBarApp extends StatefulWidget {
  const TabBarApp({Key? key}) : super(key: key);

  @override
  State<TabBarApp> createState() => _TabBarAppState();
}

class _TabBarAppState extends State<TabBarApp> {
  int _currentIndex = 0;
  double _dashWidth = 18.0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: Stack(
        children: [
          BottomNavigationBar(
            type: BottomNavigationBarType.fixed,
            currentIndex: _currentIndex,
            onTap: (index) {
              setState(() {
                _currentIndex = index;
              });
            },
            showSelectedLabels: false, // Hide labels
            showUnselectedLabels: false, // Hide labels
            items:  [
              BottomNavigationBarItem(icon: Icon(Icons.home_rounded), label: ""),
              BottomNavigationBarItem(icon: Icon(Icons.search), label: ""),
              BottomNavigationBarItem(
                icon: Container(
                  width: 40.0,
                  height: 40.0,
                  child: GestureDetector(
                    onTap: () {
                      // Handle onTap for headphones button
                    },
                    child: CircleAvatar(

                      backgroundColor: Colors.pinkAccent,
                      child: Icon(Icons.headphones, color: Colors.white , ),
                    ),
                  ),
                ),
                label: "",
              ),

              BottomNavigationBarItem(icon: Icon(Icons.podcasts), label: ""),
              BottomNavigationBarItem(icon: Icon(Icons.settings), label: ""),

            ],

          ),
          _buildDashIndicator(),
        ],
      ),
      body: _buildTabBarView(_currentIndex),
    );
  }

  Widget _buildTabBarView(int currentIndex) {
    switch (currentIndex) {
      case 0:
        return HomePage();
      case 1:
        return SearchPage();
      case 3:
        return PodcastPage();
      case 4:
        return SettingPage();
      default:
        return HomePage();
    }
  }

  Widget _buildDashIndicator() {
    double itemWidth = MediaQuery.of(context).size.width / 5;
    double dashPosition = _currentIndex * itemWidth + (itemWidth - _dashWidth) / 2;

    return AnimatedPositioned(
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInSine,
      left: dashPosition,
      bottom: 40,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        width: _dashWidth,
        height: 2,
        color: Colors.pinkAccent, // Adjust the color based on your design
      ),
    );
  }

}
