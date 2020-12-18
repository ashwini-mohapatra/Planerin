import 'package:custom_splash/custom_splash.dart';
import 'package:flutter/material.dart';
import 'package:planerin/helpers/Control_Helper.dart';
import 'package:planerin/screen/Home.dart';
import 'package:planerin/screen/Walkthrough.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Planerin extends StatelessWidget{

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.purple,
      ),
      home: CustomSplash(
        imagePath: 'assets/images/planerin.png',
        backGroundColor: Colors.purple,
        animationEffect: 'zoom-in',
        logoSize: 200,
        home: Control_Helper(),
        duration: 2500,
        type: CustomSplashType.StaticDuration,
      ),
    );
    throw UnimplementedError();
  }
}