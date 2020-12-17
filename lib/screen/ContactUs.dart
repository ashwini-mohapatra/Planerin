import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:planerin/helpers/Drawer_Navigation.dart';

class ContactUs extends StatelessWidget{


  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text("Planerin"),
        ),
        drawer: Drawer_Navigation(),
        body: ListView(
          children: <Widget>[
            Center(
              child: Text("Contact Us Page",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20,height: 3.0),textAlign: TextAlign.center,),
            ),
            Center(child: Text("To contact me, \n you can either leave a review on play store \n Or \n mail me at the given email-id - ",style: TextStyle(fontSize: 15,height: 2.0,),textAlign: TextAlign.center,)),
            Center(child: Text("ashwini152066@gmail.com",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20,height: 2.0),)),
            Center(child: Text("I will try to reply to your mail as soon as possible.",style: TextStyle(fontSize: 15,height: 2.0),textAlign: TextAlign.center)),
          ],
        ),
      ),
    );
    throw UnimplementedError();
  }

}