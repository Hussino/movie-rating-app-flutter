import 'dart:io';

import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart' as p;

class DbTables{
  static const String Users = "Users";
  static const String Movies = "Movies";
  static const String Reviews = "Reviews";
}
String _usersTbl = 'CREATE TABLE ${DbTables.Users} (Id INTEGER PRIMARY KEY AUTOINCREMENT, Name TEXT,  Email TEXT, Password TEXT)';
String _moviesTbl = 'CREATE TABLE ${DbTables.Movies} (Id INTEGER PRIMARY KEY AUTOINCREMENT, Name TEXT, Img TEXT NULL, Details TEXT NULL)';
String _reviewsTbl = 'CREATE TABLE ${DbTables.Reviews} (Id INTEGER PRIMARY KEY AUTOINCREMENT, ReviewerName TEXT, Review TEXT NULL, Score INTEGER NULL, movieId INTEGER, FOREIGN KEY (movieId) REFERENCES Movies(Id))';



class DbHelper
{
  static DbHelper? dbHelper;
  static Database? _database;

  DbHelper._createInstance();
  factory DbHelper()
  {
    dbHelper ??=DbHelper._createInstance();
    return dbHelper as DbHelper;
  }

  Future<Database> get database async {
    _database ??= await _initializeDatabase();
    return _database as Database;
  }

  Future<Database> _initializeDatabase() async {
    int dbVersion =3;
    //var path = getDatabasesPath();
    final dbFolder = await getExternalStorageDirectory();
    final dbPath = p.join(dbFolder!.path, "Database");
    Directory dbFolderDir = await Directory(dbPath).create(recursive: true);

    final file = File(p.join(dbFolderDir.path, 'moviesapp.db'));
    var productDb = await openDatabase(
        file.path,
        version: dbVersion,
        onCreate: (db, version){
          db.execute(_usersTbl);
          db.execute(_moviesTbl);
          db.execute(_reviewsTbl);
        },
        onDowngrade: onDatabaseDowngradeDelete,
       onUpgrade: (Database db, int oldVersion, int newVersion) {
      if (oldVersion < newVersion) {

        db.execute("ALTER TABLE ${DbTables.Users} ADD COLUMN Img TEXT NULL;");
      }
        }

    );
    return productDb;
  }

  Future<List<Map<String, dynamic>>?> getAll(String tbl) async{
    try {
      Database db = await database;
      var res = await db.query(tbl);
      return res;
    } on Exception catch (e) {
      print("Exception in getAll: $e");
      return null;
    }
  }

  Future<Map<String, dynamic>?> getById(String tbl, int id, {String pkName = "Id"}) async{
    try {
      Database db = await database;
      var result= await db.query(tbl,where: "$pkName = ?", whereArgs: [id]);
      return result.isNotEmpty ? result.first : null;
    } on Exception catch (e) {
      print("Exception in getById: ${e}");
      return null;
    }

  }

  Future<List<Map<String, dynamic>>?> getListById(String tbl, int id, {String pkName = "Id"}) async {
    try{
      Database db = await database;
      var result = await db.query(tbl, where: "$pkName = ?", whereArgs: [id]);
      return result.isNotEmpty ? result : null;
    } on Exception catch(e) {
      print("Exception in getListById: ${e}");
      return null;
    }
  }

  Future<int> add(String tbl, Map<String, dynamic> obj)async{
    try {
      Database db = await database;
      var res = await db.insert(tbl, obj, conflictAlgorithm: ConflictAlgorithm.ignore );
      return res;
    } on Exception catch (e) {
      print("EXP in Insert : ${e}");
      return 0;
    }
  }

  Future<int> update(String tbl, Map<String, dynamic> obj, id)async{
    try{
      Database db = await database;
      var res = await db.update(tbl, obj, where: "Id = ?", whereArgs: [id]);
      return res;
    } on Exception catch(e){
      print("EXP in updating: ${e}");
      return 0;
    }
  }

  Future<int> delete(String tbl,Object pkValue, {String pkName = 'Id'})async{
    try {
      Database db = await database;
      if(pkValue != null){
        var res = await db.delete(tbl, where: '$pkName = ?', whereArgs: [pkValue]);
        return res;
      }
      return 0;
    } on Exception catch (e) {
      print("EXP in delete : ${e}");
      return 0;
    }
  }


}