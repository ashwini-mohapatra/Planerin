import 'package:planerin/database/db_operation.dart';
import 'package:planerin/model/Event.dart';

class Uploadservice{

  db_operations _dbo;

  Uploadservice(){
    _dbo=db_operations();
  }
  saveEvent(Event event) async{
    print(event.id);
    print(event.name);
    print(event.desc);
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
    print(event.date);
    print(event.time);
    return await _dbo.update('planerin', event.eventMap());
  }
  deleteEvent(id) async{
    return await _dbo.delete('planerin',id);
  }
}