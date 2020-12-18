import 'package:date_time_picker/date_time_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:planerin/helpers/Drawer_Navigation.dart';
import 'package:planerin/model/Category.dart';
import 'package:planerin/model/Event.dart';
import 'package:planerin/services/Uploadservice.dart';

class Home extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _Home();
    throw UnimplementedError();
  }

}
class _Home extends State<Home>{

  Event event=Event();
  Uploadservice uploadservice=Uploadservice();
  TextEditingController t1=TextEditingController();
  TextEditingController t2=TextEditingController();
  TextEditingController _controller3=TextEditingController();
  TextEditingController _controller4=TextEditingController();
  String _valueChanged3='',_valueToValidate3='',_valueSaved3='';
  String _valueChanged4='',_valueToValidate4='',_valueSaved4='';
  var category='Category';
  //to create dialog
  List<Widget> _events=List<Widget>();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  List<String> cat=List<String>();



  @override
  void initState(){
    super.initState();
    getEvents();
    cat.add(category);
    getCategory();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  @override
  void didUpdateWidget(Home oldWidget) {
    super.didUpdateWidget(oldWidget);
  }


  @override
  void dispose() {
    super.dispose();
  }

  getEvents() async{
    event=new Event();
    _events=List<Widget>();
      var ab=await uploadservice.getEvents();
      ab.forEach((even){
        print(even['id']);
        event.id=even['id'];
        print(even['event_name']);
        event.name=even['event_name'];
        print(even['event_desc']);
        event.desc=even['event_desc'];
        print(even['event_cat']);
        event.cat=even['event_cat'];
        print(even['event_date']);
        event.date=even['event_date'];
        print(even['event_time']);
        event.time=even['event_time'];
        setState(() {
          _events.add(Padding(
            padding: EdgeInsets.only(top:8.0, left: 8.0, right: 8.0),
            child: FlatButton(
              child: Card(
                  elevation: 8,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(0)),
                  child: ListTile(
                    title: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text(event.name ?? 'No Name')
                      ],
                    ),
                    subtitle: Text(event.cat ?? 'No Category'),
                    trailing: Text(event.date ?? 'No Date'),
                  )),
              onPressed: (){
                _decisiondialog(context, event.id);
              },
            ),
          )
          );
        });
      });
  }

  getCategory() async{
  var ab=await uploadservice.getCatEvents();
  ab.forEach((element){
    setState((){
      cat.add(element['cat_name'].toString());
    });
  });
  setState(() {
    category=cat[0];
  });
  }
  showEvent(BuildContext context,id ) async{
    var ab= await uploadservice.getEventById(id);
    setState(() {
      t1.text=ab[0]['event_name'] ?? "Event Title";
      t2.text=ab[0]['event_desc'] ?? "Event Description";
      category=ab[0]['event_cat'] ?? cat[0];
      _controller3.text=ab[0]['event_date'] ?? "Event Date";
      _controller4.text=ab[0]['event_time'] ?? "Event Time";
    });
    _showdialog(context);
  }
  editEvent(BuildContext context,id ) async{
    var ab= await uploadservice.getEventById(id);
    setState(() {
      t1.text=ab[0]['event_name'] ?? "Event Title";
      t2.text=ab[0]['event_desc'] ?? "Event Description";
      category=ab[0]['event_cat'] ?? cat[0];
      _controller3.text=ab[0]['event_date'] ?? "Event Date";
      _controller4.text=ab[0]['event_time'] ?? "Event Time";
    });
    _updatedialog(context,id);
  }

  deleteEvent(BuildContext context,id ) async{
    var ab= await uploadservice.getEventById(id);
    setState(() {
      t1.text=ab[0]['event_name'] ?? "Event Title";
      t2.text=ab[0]['event_desc'] ?? "Event Description";
      category=ab[0]['event_cat'] ?? cat[0];
      _controller3.text=ab[0]['event_date'] ?? "Event Date";
      _controller4.text=ab[0]['event_time'] ?? "Event Time";
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
          title: Text('Add New Event'),
          content: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                TextField(
                  controller: t1,
                  decoration: InputDecoration(
                    labelText: "Event Name",
                    hintText: "Event Name",
                  ),
                ),
                TextField(
                  controller: t2,
                  decoration: InputDecoration(
                    labelText: "Event Description",
                    hintText: "Event Description",
                  ),
                ),
                DropdownButton<String>(
                    items: cat.map((String cats) {
                      return DropdownMenuItem<String>(
                          value: cats,
                          child: Text(cats),
                      );
                    }
                    ).toList(),
                    onChanged: (String catale){
                      setState(() {
                        category=catale;
                      });
                    },
                  value: category,
                ),
                DateTimePicker(
                  type: DateTimePickerType.date,
                  dateMask: 'dd MMM, yyyy',
                  controller: _controller3,
                  //initialValue: _initialValue,
                  firstDate: DateTime(1900),
                  lastDate: DateTime(3000),
                  icon: Icon(Icons.event),
                  dateLabelText: 'Date',
                  //locale: Locale('en', 'US'),
                  onChanged: (val) => setState(() => _valueChanged3 = val),
                  validator: (val) {
                    setState(() => _valueToValidate3 = val);
                    return null;
                  },
                  onSaved: (val) => setState(() => _valueSaved3 = val),
                ),
                DateTimePicker(
                  type: DateTimePickerType.time,
                  controller: _controller4,
                  //initialValue: _initialValue,
                  icon: Icon(Icons.access_time),
                  timeLabelText: "Time",
                  //use24HourFormat: false,
                  //locale: Locale('en', 'US'),
                  onChanged: (val) => setState(() => _valueChanged4 = val),
                  validator: (val) {
                    setState(() => _valueToValidate4 = val);
                    return null;
                  },
                  onSaved: (val) => setState(() => _valueSaved4 = val),
                ),
              ],
            ),
          ),
          actions: <Widget>[
              FlatButton(
              child: Text('Save'),
              onPressed: () async{
                setState((){
                  event=new Event();
                  event.name=t1.text;
                  event.desc=t2.text;
                  event.cat=category;
                  event.date=_controller3.text;
                  event.time=_controller4.text;
                  t1.clear();
                  t2.clear();
                  category=cat[0];
                  _controller3.clear();
                  _controller4.clear();
                });
                var result=await uploadservice.saveEvent(event);
                print(result);
                t1.clear();
                t2.clear();
                _controller3.clear();
                _controller4.clear();
                Navigator.of(dialogContext).pop(); // Dismiss alert dialog
                getEvents();
                if(result>0){
                  showSnackBar(Text('Event Added'));
                }else{
                  showSnackBar(Text('Event Added Unsuccessful'));
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
          title: Text('Delete Event'),
          content: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                TextField(
                  controller: t1,
                  decoration: InputDecoration(
                    labelText: "Event Name",
                    hintText: "Event Name",
                  ),
                ),
                TextField(
                  controller: t2,
                  decoration: InputDecoration(
                    labelText: "Event Description",
                    hintText: "Event Description",
                  ),
                ),
                DropdownButton<String>(
                  items: cat.map((String cats) {
                    return DropdownMenuItem<String>(
                      value: cats,
                      child: Text(cats),
                    );
                  }
                  ).toList(),
                  onChanged: (String catale){
                    setState(() {
                      category=catale;
                    });
                  },
                  value: category,
                ),
                DateTimePicker(
                  type: DateTimePickerType.date,
                  dateMask: 'dd MMM, yyyy',
                  controller: _controller3,
                  //initialValue: _initialValue,
                  firstDate: DateTime(1900),
                  lastDate: DateTime(3000),
                  icon: Icon(Icons.event),
                  dateLabelText: 'Date',
                  //locale: Locale('en', 'US'),
                  onChanged: (val) => setState(() => _valueChanged3 = val),
                  validator: (val) {
                    setState(() => _valueToValidate3 = val);
                    return null;
                  },
                  onSaved: (val) => setState(() => _valueSaved3 = val),
                ),
                DateTimePicker(
                  type: DateTimePickerType.time,
                  controller: _controller4,
                  //initialValue: _initialValue,
                  icon: Icon(Icons.access_time),
                  timeLabelText: "Time",
                  //use24HourFormat: false,
                  //locale: Locale('en', 'US'),
                  onChanged: (val) => setState(() => _valueChanged4 = val),
                  validator: (val) {
                    setState(() => _valueToValidate4 = val);
                    return null;
                  },
                  onSaved: (val) => setState(() => _valueSaved4 = val),
                ),
              ],
            ),
          ),
          actions: <Widget>[
            FlatButton(
              child: Text('Delete'),
              onPressed: () async{

                //print('Event Name: ${t1.text}');
                //print('Event Desc: ${t2.text}');
                var result=await uploadservice.deleteEvent(id);
                print(result);
                  t1.clear();
                  t2.clear();
                  category=cat[0];
                  _controller3.clear();
                  _controller4.clear();
                  Navigator.of(dialogContext).pop();
                  getEvents();
                  if(result>0){
                    getEvents();
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
          title: Text('Update Event'),
          content: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                TextField(
                  controller: t1,
                  decoration: InputDecoration(
                    labelText: "Event Name",
                    hintText: "Event Name",
                  ),
                ),
                TextField(
                  controller: t2,
                  decoration: InputDecoration(
                    labelText: "Event Description",
                    hintText: "Event Description",
                  ),
                ),
                DropdownButton<String>(
                  items: cat.map((String cats) {
                    return DropdownMenuItem<String>(
                      value: cats,
                      child: Text(cats),
                    );
                  }
                  ).toList(),
                  onChanged: (String catale){
                    setState(() {
                      category=catale;
                    });
                  },
                  value: category,
                ),
                DateTimePicker(
                  type: DateTimePickerType.date,
                  dateMask: 'dd MMM, yyyy',
                  controller: _controller3,
                  //initialValue: _initialValue,
                  firstDate: DateTime(1900),
                  lastDate: DateTime(3000),
                  icon: Icon(Icons.event),
                  dateLabelText: 'Date',
                  //locale: Locale('en', 'US'),
                  onChanged: (val) => setState(() => _valueChanged3 = val),
                  validator: (val) {
                    setState(() => _valueToValidate3 = val);
                    return null;
                  },
                  onSaved: (val) => setState(() => _valueSaved3 = val),
                ),
                DateTimePicker(
                  type: DateTimePickerType.time,
                  controller: _controller4,
                  //initialValue: _initialValue,
                  icon: Icon(Icons.access_time),
                  timeLabelText: "Time",
                  //use24HourFormat: false,
                  //locale: Locale('en', 'US'),
                  onChanged: (val) => setState(() => _valueChanged4 = val),
                  validator: (val) {
                    setState(() => _valueToValidate4 = val);
                    return null;
                  },
                  onSaved: (val) => setState(() => _valueSaved4 = val),
                ),
              ],
            ),
          ),
          actions: <Widget>[
            FlatButton(
              child: Text('Update'),
              onPressed: () async{
                setState(() {
                  event=new Event();
                  event.id=id;
                  event.name=t1.text;
                  event.desc=t2.text;
                  event.cat=category;
                  event.date=_controller3.text;
                  event.time=_controller4.text;
                  t1.clear();
                  t2.clear();
                  category=cat[0];
                  _controller3.clear();
                  _controller4.clear();

                });
                var result=await uploadservice.updateEvent(event);
                  t1.clear();
                  t2.clear();
                category=cat[0];
                _controller3.clear();
                _controller4.clear();
                getEvents();
                Navigator.of(dialogContext).pop(); // Dismiss alert dialog
                  print(result);
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
          title: Text('Event Details'),
          content: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                Text("Event Name",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 15,height: 3),textAlign: TextAlign.start,),
                Text(t1.text),
                Text("Event Description",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 15,height: 3),textAlign: TextAlign.start,),
                Text(t2.text),
                Text("Event Category",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 15,height: 3),textAlign: TextAlign.start,),
                Text(category),
                Text("Event Date",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 15,height: 3),textAlign: TextAlign.start,),
                Text(_controller3.text),
                Text("Event Time",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 15,height: 3),textAlign: TextAlign.start,),
                Text(_controller4.text),
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

  _decisiondialog(BuildContext context,id){
    return showDialog<void>(
      context: context,
      barrierDismissible: true,
      // false = user must tap button, true = tap outside dialog
      builder: (BuildContext dialogContext) {
        return AlertDialog(
          title: Text('Decide Operation'),
          content: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                Text("Which of the following operation do you wish to perform?"),
              ],
            ),
          ),
          actions: <Widget>[
            FlatButton(
              child: Text('Show'),
              onPressed: (){
                Navigator.of(dialogContext).pop(); // Dismiss alert dialog
                showEvent(context, id);
              },
            ),
            FlatButton(
              child: Text('Update'),
              onPressed: (){
                Navigator.of(dialogContext).pop(); // Dismiss alert dialog
                editEvent(context, id);
                },
            ),
            FlatButton(
              child: Text('Delete'),
              onPressed: (){
                Navigator.of(dialogContext).pop(); // Dismiss alert dialog
                deleteEvent(context, id);
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
         title: Text("Planerin"),
      ),
      drawer: Drawer_Navigation(),
       body: RefreshIndicator(
         child: Stack(
             children: <Widget>[ListView(),Column(
               children: _events ?? Center(child: Text("No Events Yet",textAlign: TextAlign.center,style: TextStyle(color: Colors.grey,fontWeight: FontWeight.bold),),),
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
