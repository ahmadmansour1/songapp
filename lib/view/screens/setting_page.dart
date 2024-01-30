import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SettingPage extends StatelessWidget {
  const SettingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: Center(
        child: Text('settings' , style: TextStyle(color: Colors.white , fontWeight: FontWeight.bold , fontSize: 20),),
      ),
    );
  }
}
