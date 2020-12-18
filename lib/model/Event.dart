import 'package:flutter/material.dart';
class Event{

  int id;
  String name;
  String desc;
  String cat;
  String date;
  String time;

  eventMap(){
    var map=Map<String,dynamic>();
    map['id']=id;
    map['event_name']=name;
    map['event_desc']=desc;
    map['event_cat']=cat;
    map['event_date']=date;
    map['event_time']=time;
    return map;
  }
}