import 'package:date_time_picker/date_time_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:planerin/helpers/Drawer_Navigation.dart';
import 'package:planerin/model/Category.dart';
import 'package:planerin/services/Uploadservice.dart';

class Categories extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _Categories();
    throw UnimplementedError();
  }

}
class _Categories extends State<Categories>{

  Category event=Category();
  Uploadservice uploadservice=Uploadservice();
  TextEditingController t1=TextEditingController();
  TextEditingController t2=TextEditingController();
  List<Widget> _events=List<Widget>();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState(){
    super.initState();
    getEvents();
  }

  @override
  void didUpdateWidget(Categories oldWidget) {
    super.didUpdateWidget(oldWidget);
  }


  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    super.dispose();
  }
  getEvents() async{
    _events=List<Widget>();
    var ab=await uploadservice.getCatEvents();
    ab.forEach((even){
      print(even['cat_id']);
      print(even['cat_name']);
      print(even['cat_desc']);
      setState(() {
        _events.add(FlatButton(
          child: Card(
            child: ListTile(
              leading: IconButton(icon:Icon(Icons.edit),onPressed: (){
                editEvent(context, even['cat_id']);
              },),
              title: Text(even['cat_name'].toString()),
              subtitle: Text(even['cat_desc'].toString()),
              trailing: IconButton(icon:Icon(Icons.delete),onPressed: (){
                deleteEvent(context,even['cat_id']);
              }),
            ),
          ),
          onPressed: (){
            showEvent(context, even['cat_id']);
          },
        ));
      });
    });
  }


  showEvent(BuildContext context,id ) async{
    var ab= await uploadservice.getCatEventById(id);
    setState(() {
      t1.text=ab[0]['cat_name'] ?? "Category Title";
      t2.text=ab[0]['cat_desc'] ?? "Category Description";
    });
    _showdialog(context);
  }
  editEvent(BuildContext context,id ) async{
    var ab= await uploadservice.getCatEventById(id);
    setState(() {
      t1.text=ab[0]['cat_name'] ?? "Category Title";
      t2.text=ab[0]['cat_desc'] ?? "Category Description";
    });
    _updatedialog(context,id);
  }

  deleteEvent(BuildContext context,id ) async{
    var ab= await uploadservice.getCatEventById(id);
    setState(() {
      t1.text=ab[0]['cat_name'] ?? "Category Title";
      t2.text=ab[0]['cat_desc'] ?? "Category Description";
    });
    _deletedialog(context,id);
  }
  showSnackBar(message){
    var sn=SnackBar(content: message);
    _scaffoldKey.currentState.showSnackBar(sn);
  }

  _insertdialog(BuildContext context){
    return showDialog<void>(
      context: context,
      barrierDismissible: true,
      // false = user must tap button, true = tap outside dialog
      builder: (BuildContext dialogContext) {
        return AlertDialog(
          title: Text('Add New Category'),
          content: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                TextField(
                  controller: t1,
                  decoration: InputDecoration(
                    labelText: "Category Name",
                    hintText: "Category Name",
                  ),
                ),
                TextField(
                  controller: t2,
                  decoration: InputDecoration(
                    labelText: "Category Description",
                    hintText: "Category Description",
                  ),
                ),
              ],
            ),
          ),
          actions: <Widget>[
            FlatButton(
              child: Text('Save'),
              onPressed: () async{
                setState((){
                  event=new Category();
                  event.name=t1.text;
                  event.desc=t2.text;
                  t1.clear();
                  t2.clear();
                });
                //print('Event Name: ${t1.text}');
                //print('Event Desc: ${t2.text}');
                var result=await uploadservice.saveCatEvent(event);
                print(result);
                Navigator.of(dialogContext).pop(); // Dismiss alert dialog
                getEvents();
                if(result>0){
                  showSnackBar(Text('Category Added'));
                }else{
                  showSnackBar(Text('Category Add Unsuccessful'));
                }
              },
            ),
            FlatButton(
              child: Text('Cancel'),
              onPressed: () {
                Navigator.of(dialogContext).pop(); // Dismiss alert dialog
              },
            ),
          ],
        );
      },
    );
  }

  _deletedialog(BuildContext context,id){
    return showDialog<void>(
      context: context,
      barrierDismissible: true,
      // false = user must tap button, true = tap outside dialog
      builder: (BuildContext dialogContext) {
        return AlertDialog(
          title: Text('Delete Category'),
          content: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                TextField(
                  controller: t1,
                  decoration: InputDecoration(
                    labelText: "Category Name",
                    hintText: "Category Name",
                  ),
                ),
                TextField(
                  controller: t2,
                  decoration: InputDecoration(
                    labelText: "Category Description",
                    hintText: "Category Description",
                  ),
                ),
              ],
            ),
          ),
          actions: <Widget>[
            FlatButton(
              child: Text('Delete'),
              onPressed: () async{
                var result=await uploadservice.deleteCatEvent(id);
                print(result);
                t1.clear();
                t2.clear();
                Navigator.of(dialogContext).pop();
                getEvents();
                if(result>0){
                  showSnackBar(Text('Delete Successful'));
                }else{
                  showSnackBar(Text("Delete UnSuccessful"));// Dismiss alert dialog
                }
              },
            ),
            FlatButton(
              child: Text('Cancel'),
              onPressed: () {
                Navigator.of(dialogContext).pop(); // Dismiss alert dialog
              },
            ),
          ],
        );
      },
    );
  }
  _updatedialog(BuildContext context,id){
    return showDialog<void>(
      context: context,
      barrierDismissible: true,
      // false = user must tap button, true = tap outside dialog
      builder: (BuildContext dialogContext) {
        return AlertDialog(
          title: Text('Update Category'),
          content: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                TextField(
                  controller: t1,
                  decoration: InputDecoration(
                    labelText: "Category Name",
                    hintText: "Category Name",
                  ),
                ),
                TextField(
                  controller: t2,
                  decoration: InputDecoration(
                    labelText: "Category Description",
                    hintText: "Category Description",
                  ),
                ),
              ],
            ),
          ),
          actions: <Widget>[
            FlatButton(
              child: Text('Update'),
              onPressed: () async{
                setState(() {
                  event=new Category();
                  event.id=id;
                  event.name=t1.text;
                  event.desc=t2.text;
                  t1.clear();
                  t2.clear();

                });
                var result=await uploadservice.updateCatEvent(event);
                t1.clear();
                t2.clear();
                Navigator.of(dialogContext).pop(); // Dismiss alert dialog
                print(result);
                getEvents();
                if(result>0){
                  showSnackBar(Text("Update Success"));
                }else{
                  showSnackBar(Text("Update UnSuccess"));
                }
              },
            ),
            FlatButton(
              child: Text('Cancel'),
              onPressed: () {
                Navigator.of(dialogContext).pop(); // Dismiss alert dialog
              },
            ),
          ],
        );
      },
    );
  }

  _showdialog(BuildContext context){
    return showDialog<void>(
      context: context,
      barrierDismissible: true,
      // false = user must tap button, true = tap outside dialog
      builder: (BuildContext dialogContext) {
        return AlertDialog(
          title: Text('Category Details'),
          content: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                Text("Category Name",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 15,height: 3),textAlign: TextAlign.start,),
                Text(t1.text),
                Text("Category Description",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 15,height: 3),textAlign: TextAlign.start,),
                Text(t2.text),
              ],
            ),
          ),
          actions: <Widget>[
            FlatButton(
              child: Text('Close'),
              onPressed: () {
                Navigator.of(dialogContext).pop(); // Dismiss alert dialog
              },
            ),
          ],
        );
      },
    );
  }
  Future<Null> refreshEvents()async{
    await Future.delayed(Duration(seconds: 1));
    setState(() {
      getEvents();
    });
    return null;
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return SafeArea(
      child: Scaffold(
        key: _scaffoldKey,
        appBar: AppBar(
          title: Text("Category List"),
        ),
        drawer: Drawer_Navigation(),
        body: RefreshIndicator(
          child: Stack(
            children: <Widget>[ListView(),Column(
              children: _events ?? Center(child: Text("No Categories Added Yet",textAlign: TextAlign.center,style: TextStyle(color: Colors.grey,fontWeight: FontWeight.bold),),),
            ),
            ],
          ),
          onRefresh: refreshEvents,
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: (){
            _insertdialog(context);
          },
          child: Icon(Icons.add),
        ),
      ),
    );
    throw UnimplementedError();
  }

}
