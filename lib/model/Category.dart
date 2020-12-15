import 'package:flutter/material.dart';
class Category{

  int id;
  String name;
  String desc;

  categoryMap(){
    var map=Map<String,dynamic>();
    map['id']=id;
    map['cat_name']=name;
    map['cat_desc']=desc;
    return map;
  }
}