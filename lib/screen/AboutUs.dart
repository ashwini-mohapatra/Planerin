import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:planerin/helpers/Drawer_Navigation.dart';

class AboutUs extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text("Planerin"),
      ),
      drawer: Drawer_Navigation(),
      body: ListView(
        children: <Widget>[
          Center(
            child: Text("About Us Page",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20,height: 3.0),textAlign: TextAlign.center,),
          ),
          Center(child: Text("Hello Guys, I am Ashwini Mohapatra.\n I am a B.Tech CSE 3rd Year student at the time of release of this app.\n I have been working in mobile app development for last 2 years. \n This is my first android app made in flutter and dart. \n Regarding this app, I would like to clear few things. \n This app doesn't uses any permission so if this app asks for any permission from you then you have downloaded it from an unreliable source. \n Please download this from Play Store Only. \n Also this app stores your data such as events and categories on your phone only and once the app is uninstalled, the data gets deleted.\n Thank You",textAlign: TextAlign.center,style: TextStyle(fontSize: 15,height: 3.0))),
        ],
      ),
    );
    throw UnimplementedError();
  }

}