import 'package:planerin/database/db_operation.dart';
import 'package:planerin/model/Category.dart';
import 'package:planerin/model/Event.dart';

class Uploadservice{

  db_operations _dbo;

  Uploadservice(){
    _dbo=db_operations();
  }
  saveEvent(Event event) async{
    print(event.name);
    print(event.desc);
    print(event.cat);
    print(event.date);
    print(event.time);
    return await _dbo.save('planerin', event.eventMap());
  }

  getEvents() async{
    return await _dbo.getall('planerin');
  }

  getEventById(id) async{
    return await _dbo.getById('planerin',id);
  }
  updateEvent(Event event) async{
    print(event.id);
    print(event.name);
    print(event.desc);
    print(event.cat);
    print(event.date);
    print(event.time);
    return await _dbo.update('planerin', event.eventMap());
  }
  deleteEvent(id) async{
    return await _dbo.delete('planerin',id);
  }
  saveCatEvent(Category event) async{
    print(event.id);
    print(event.name);
    print(event.desc);
    return await _dbo.saveCat('planerin_cat', event.categoryMap());
  }

  getCatEvents() async{
    return await _dbo.getallCat('planerin_cat');
  }

  getCatEventById(id) async{
    return await _dbo.getByIdCat('planerin_cat',id);
  }
  updateCatEvent(Category event) async{
    print(event.id);
    print(event.name);
    print(event.desc);
    return await _dbo.updateCat('planerin_cat', event.categoryMap());
  }
  deleteCatEvent(id) async{
    return await _dbo.deleteCat('planerin_cat',id);
  }
}