import 'package:flutter/material.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:planerin/screen/Home.dart';
import 'package:shared_preferences/shared_preferences.dart';

class walkthrough extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _walkthrough();
    throw UnimplementedError();
  }
}

class _walkthrough extends State<walkthrough>{
  final List<PageViewModel> list = [
    PageViewModel(
      image: Image.asset('assets/images/wkl1.jpeg'),
      title: "Add Events",
      body: "To add events, click on '+' button at bottom right position of screen.",
    ),
    PageViewModel(
      image: Image.asset('assets/images/wkl2.jpeg'),
      title: "Update,Show & Delete Event",
      body: "To update, show or delete event, simple click on event. It will show a dialog box which can then be used to perform these operations",
    ),
    PageViewModel(
      image: Image.asset('assets/images/wkl3.jpeg'),
      title: "Add Category",
      body: "You can also add categories for your events. Go to categories page from side navigation bar to add categories",
    ),
    PageViewModel(
      image: Image.asset('assets/images/wkl4.jpeg'),
      title: "Update, Delete Category",
      body: "To Update/Delete Category, click on the pencil/dustbin icon at front and trailing of category item list.",
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

    return Scaffold(
      body: IntroductionScreen(
        done: Text("Done",style: TextStyle(color: Colors.purple),),
        onDone: (){
          Navigator.of(context).push(
            MaterialPageRoute(builder: (_) => Home()),
          );
        },
        pages: list,
      ),
    );
    //   return IntroScreen(
  //     list,
  //     MaterialPageRoute(builder: (context) => Home()),
  //   );
  //   throw UnimplementedError();
   }

}