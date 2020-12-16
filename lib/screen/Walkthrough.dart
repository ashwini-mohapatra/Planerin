import 'package:flutter/material.dart';
import 'package:planerin/screen/Home.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:walkthrough/flutterwalkthrough.dart';
import 'package:walkthrough/walkthrough.dart';

class walkthrough extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _walkthrough();
    throw UnimplementedError();
  }
}

class _walkthrough extends State<walkthrough>{
  final List<Walkthrough> list = [
    Walkthrough(
      title: "Title 1",
      content: "Content 1",
      imageIcon: Icons.restaurant_menu,
    ),
    Walkthrough(
      title: "Title 2",
      content: "Content 2",
      imageIcon: Icons.search,
    ),
    Walkthrough(
      title: "Title 3",
      content: "Content 3",
      imageIcon: Icons.shopping_cart,
    ),
    Walkthrough(
      title: "Title 4",
      content: "Content 4",
      imageIcon: Icons.verified_user,
    ),
  ];

  Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  @override
  void initState(){
    super.initState();
    setPrefs();
  }

  setPrefs()async{
    final SharedPreferences prefs = await _prefs;
    setState(() {
      prefs.setInt('status', 1);
    });
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return IntroScreen(
      list,
      MaterialPageRoute(builder: (context) => Home()),
    );
    throw UnimplementedError();
  }

}