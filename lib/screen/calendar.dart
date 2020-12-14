import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:planerin/helpers/Drawer_Navigation.dart';
import 'package:planerin/model/Event.dart';
import 'package:planerin/services/Uploadservice.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:intl/date_symbol_data_local.dart';

class Calendar extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _Calendar();
    throw UnimplementedError();
  }

}
class _Calendar extends State<Calendar>{

  Uploadservice uploadservice=Uploadservice();
  CalendarController _controller;
  List<Event> event=new List<Event>();
  Map<DateTime, List<dynamic>> _events;

  @override
  void initState() {
    super.initState();
    _controller = CalendarController();
    getEvents();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Map<String, dynamic> encodeMap(Map<DateTime, dynamic> map) {
    Map<String, dynamic> newMap = {};
    map.forEach((key, value) {
      newMap[key.toString()] = map[key];
    });
    return newMap;
  }

  Map<DateTime, dynamic> decodeMap(Map<String, dynamic> map) {
    Map<DateTime, dynamic> newMap = {};
    map.forEach((key, value) {
      newMap[DateTime.parse(key)] = map[key];
    });
    return newMap;
  }
  getEvents() async{
    event=List<Event>();
    var ab=await uploadservice.getEvents();
    ab.forEach((even){
      print(even['id']);
      print(even['event_name']);
      print(even['event_desc']);
      print(even['event_date']);
      print(even['event_time']);
      setState(() {
      event.add(ab);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Planerin"),
      ),
      drawer: Drawer_Navigation(),

      body: TableCalendar(
      calendarStyle: CalendarStyle(
        todayColor: Colors.blue,
        selectedColor: Colors.purple,
        selectedStyle: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 18.0,
          color: Colors.white,
        ),
      ),
        headerStyle: HeaderStyle(
        centerHeaderTitle: true,
          formatButtonDecoration: BoxDecoration(
            color: Colors.blue,
            borderRadius: BorderRadius.circular(20.0),
          ),
          formatButtonShowsNext: false,
          formatButtonTextStyle: TextStyle(
            color:Colors.white,
            fontWeight: FontWeight.bold
          ),
          formatButtonVisible: false,
        ),
        events: _events,
        calendarController: _controller,
        ),
    );
  }

}