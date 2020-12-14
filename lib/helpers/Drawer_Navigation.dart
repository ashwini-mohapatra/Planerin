import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:planerin/screen/AboutUs.dart';
import 'package:planerin/screen/ContactUs.dart';
import 'package:planerin/screen/Home.dart';
import 'package:planerin/screen/Profile.dart';
import 'package:planerin/screen/calendar.dart';

class Drawer_Navigation extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _Drawer_Navigation();
    throw UnimplementedError();
  }
  
}
class _Drawer_Navigation extends State<Drawer_Navigation>{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      child: Drawer(
        child: ListView(
          children: <Widget>[
            UserAccountsDrawerHeader(
              accountName: Text("Welcome to Planerin"),
              accountEmail: Text(""),
              currentAccountPicture: GestureDetector(
                child: CircleAvatar(
                    child: Image.asset('assets/images/planerin.png'),
                  // child: Icon(Icons.person,color: Colors.white,size: 50.0,),
                  // backgroundColor: Colors.purple.shade700,
                ),
              ),
              decoration: BoxDecoration(
                color: Colors.purple,
              ),

            ),
            ListTile(
              title: Text("Home"),
              leading: Icon(Icons.home),
              onTap: (){
                Navigator.of(context).push(new MaterialPageRoute(builder: (context)=> Calendar()));
              },
            ),
            ListTile(
              title: Text("Events List"),
              leading: Icon(Icons.home),
              onTap: (){
                Navigator.of(context).push(new MaterialPageRoute(builder: (context)=> Home()));
              },
            ),
            ListTile(
              title: Text("Contact Us"),
              leading: Icon(Icons.contact_mail),
              onTap: (){
                Navigator.of(context).push(new MaterialPageRoute(builder: (context)=> ContactUs()));
              },
            ),
            ListTile(
              title: Text("About Us"),
              leading: Icon(Icons.info),
              onTap: (){
                Navigator.of(context).push(new MaterialPageRoute(builder: (context)=> AboutUs()));
              },
            ),
          ],
        ),
      ),
    );
    throw UnimplementedError();
  }
  
}