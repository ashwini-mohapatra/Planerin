
import 'package:planerin/database/db_connection.dart';
import 'package:sqflite/sqflite.dart';

class db_operations{
DatabaseConnection _db;

  db_operations(){
    _db=DatabaseConnection();
  }
  static Database _database;

  Future<Database> get database1 async{
    if(_database!=null) return _database;
    _database=await _db.setDatabase();
    return _database;

  }
  save(table,data) async{
    var conn=await database1;
     return await conn.insert(table, data);
  }

  getall(table) async{
    var conn = await database1;
    return await conn.query(table);
  }

  delete(table,id) async{
    var conn=await database1;
    return await conn.delete(table,where: 'id=?',whereArgs: [id]);
  }

  getById(table, id) async{
    var conn=await database1;
    return await conn.query(table, where: 'id=?',whereArgs: [id]);
  }

  update(table,data) async{
    var conn=await database1;
    return await conn.update(table, data,where: 'id=?',whereArgs: [data['id']]);
  }
}