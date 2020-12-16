import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:planerin/screen/Home.dart';
import 'package:planerin/screen/Walkthrough.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Control_Helper extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _Control_Helper();
    throw UnimplementedError();
  }

}
class _Control_Helper extends State<Control_Helper>{

  Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  var bc;
  @override
  void initState(){
    super.initState();
    getScreen();
  }

  getScreen() async{
    final SharedPreferences prefs = await _prefs;
    setState(() {
      int status = (prefs.getInt('status') ?? 0);
      if(status==0){
        bc=walkthrough();
      }else{
        bc=Home();
      }
    });
  }


  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      body: bc,
    );

    throw UnimplementedError();
  }

}