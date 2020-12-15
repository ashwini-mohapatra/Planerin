
import 'package:planerin/database/db_connection.dart';
import 'package:sqflite/sqflite.dart';

class db_operations{
DatabaseConnection _db;

  db_operations(){
    _db=DatabaseConnection();
  }
  static Database _database;

  Future<Database> get database async{
    if(_database!=null) return _database;
    _database=await _db.setDatabase();
    return _database;

  }
  save(table,data) async{
    var conn=await database;
     return await conn.insert(table, data);
  }

  getall(table) async{
    var conn = await database;
    return await conn.query(table);
  }

  delete(table,id) async{
    var conn=await database;
    return await conn.delete(table,where: 'id=?',whereArgs: [id]);
  }

  getById(table, id) async{
    var conn=await database;
    return await conn.query(table, where: 'id=?',whereArgs: [id]);
  }

  update(table,data) async{
    var conn=await database;
    return await conn.update(table, data,where: 'id=?',whereArgs: [data['id']]);
  }

saveCat(table,data) async{
  var conn1=await database;
  return await conn1.insert(table, data);
}

getallCat(table) async{
  var conn1 = await database;
  return await conn1.query(table);
}

deleteCat(table,id) async{
  var conn1=await database;
  return await conn1.delete(table,where: 'id=?',whereArgs: [id]);
}

getByIdCat(table, id) async{
  var conn1=await database;
  return await conn1.query(table, where: 'id=?',whereArgs: [id]);
}

updateCat(table,data) async{
  var conn1=await database;
  return await conn1.update(table, data,where: 'id=?',whereArgs: [data['id']]);
}
}