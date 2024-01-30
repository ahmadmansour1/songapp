import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class PodcastPage extends StatelessWidget {
  const PodcastPage({super.key});

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: Center(
        child: Text('Podcasts' , style: TextStyle(color: Colors.white , fontWeight: FontWeight.bold , fontSize: 20),),
      ),
    );
  }
}
