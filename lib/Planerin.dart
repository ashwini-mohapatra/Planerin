import 'package:custom_splash/custom_splash.dart';
import 'package:flutter/material.dart';
import 'package:planerin/screen/Home.dart';

class Planerin extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.purple,
      ),
      home: CustomSplash(
        imagePath: 'assets/images/planerin.png',
        backGroundColor: Colors.purple,
        animationEffect: 'zoom-in',
        logoSize: 200,
        home: Home(),
        duration: 2500,
        type: CustomSplashType.StaticDuration,
      ),
    );
    throw UnimplementedError();
  }
  
}