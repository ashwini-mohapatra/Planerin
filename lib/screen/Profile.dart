import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:planerin/screen/Home.dart';

class Profile extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _Profile();
    throw UnimplementedError();
  }
  
}
class _Profile extends State<Profile>{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text("Planerin"),
        leading: RaisedButton(
          elevation: 0.0,
          child: Icon(Icons.arrow_back,color:Colors.white),
          color: Colors.purple,
          onPressed: (){
            Navigator.of(context).push(MaterialPageRoute(builder: (context)=>Home()));
          },
        ),
      ),
      body: Center(child: Text("Welcome to Profile"),),
    );
    throw UnimplementedError();
  }
  
}