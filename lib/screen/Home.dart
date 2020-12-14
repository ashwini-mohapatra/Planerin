import 'package:date_time_picker/date_time_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:planerin/helpers/Drawer_Navigation.dart';
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
  //to create dialog
  List<Widget> _events=List<Widget>();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState(){
    super.initState();
    getEvents();
  }

  getEvents() async{
    _events=List<Widget>();
      var ab=await uploadservice.getEvents();
      ab.forEach((even){
        print(even['id']);
        print(even['event_name']);
        print(even['event_desc']);
        print(even['event_date']);
        print(even['event_time']);
        setState(() {
          _events.add(FlatButton(
            child: Card(
                child: ListTile(
                  leading: IconButton(icon:Icon(Icons.edit),onPressed: (){
                  editEvent(context, even['id']);
                  },),
                  title: Text(even['event_name'].toString()),
                  subtitle: Text(even['event_desc'].toString()),
                  trailing: IconButton(icon:Icon(Icons.delete),onPressed: (){
                    deleteEvent(context,even['id']);
                  }),
                ),
            ),
            onPressed: (){
              showEvent(context, even['id']);
            },
          ));
        });
      });
  }


  showEvent(BuildContext context,id ) async{
    var ab= await uploadservice.getEventById(id);
    setState(() {
      t1.text=ab[0]['event_name'] ?? "Event Title";
      t2.text=ab[0]['event_desc'] ?? "Event Description";
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
                  event.name=t1.text;
                  event.desc=t2.text;
                  event.date=_controller3.text;
                  event.time=_controller4.text;
                });
                //print('Event Name: ${t1.text}');
                //print('Event Desc: ${t2.text}');
                var result=await uploadservice.saveEvent(event);
                print(result);
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
                if(result>0){
                  Navigator.of(dialogContext).pop();
                  getEvents();
                  if(result>0){
                    showSnackBar(Text('Delete Successful'));
                  }else{
                    showSnackBar(Text("Delete UnSuccessful"));// Dismiss alert dialog
                  }
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
                  event.id=id;
                  event.name=t1.text;
                  event.desc=t2.text;
                  event.date=_controller3.text;
                  event.time=_controller4.text;

                });
                var result=await uploadservice.updateEvent(event);
                if(result>0){
                  Navigator.of(dialogContext).pop(); // Dismiss alert dialog
                  print(result);
                  getEvents();
                  if(result>0){
                    showSnackBar(Text("Update Success"));
                  }else{
                    showSnackBar(Text("Update UnSuccess"));
                  }
                }
                //print('Event Name: ${t1.text}');
                //print('Event Desc: ${t2.text}');
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

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
   return Scaffold(
     key: _scaffoldKey,
       appBar: AppBar(
       title: Text("Planerin"),
    ),
    drawer: Drawer_Navigation(),
     body: Column(
       children: _events,
     ),

     floatingActionButton: FloatingActionButton(
       onPressed: (){
        _insertdialog(context);
       },
       child: Icon(Icons.add),
     ),
   );
    throw UnimplementedError();
  }

}
