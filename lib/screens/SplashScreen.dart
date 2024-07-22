import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Splashscreen extends StatefulWidget{
  @override
  State<Splashscreen> createState() => _SplashscreenState();

}

class _SplashscreenState extends State<Splashscreen>{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Image(image: AssetImage('assets/Images/'),),
      ),
    );
  }

}