import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart';

class DatabaseConnection{

  setDatabase() async{
    var directory=await getApplicationDocumentsDirectory();
    var path = join(directory.path,'db_planerin');
    var db = openDatabase(path,version: 1,onCreate: _createDatabase);
    return db;
  }

  _createDatabase(Database db,int version) async{
    await db.execute("CREATE TABLE planerin(id INTEGER PRIMARY KEY, event_name TEXT, event_desc TEXT, event_cat TEXT, event_date TEXT, event_time TEXT)");
    await db.execute("CREATE TABLE planerin_cat(id INTEGER PRIMARY KEY, cat_name TEXT, cat_desc TEXT)");
  }
}