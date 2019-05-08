import 'dart:io';

import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart';

class DbProvider{
  final String _databaseName = 'database.db';
  final int _databaseVersion = 1;
  final String _tableName = 'User_information';

  static final DbProvider _db = DbProvider._();
  static DbProvider get instance => _db;

  DbProvider._();

  static Database _database;

  Future<Database> get database async{
    if(_database != null){
      return _database;
    }

    _database = await initDb();
    return _database;
  }

  initDb() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, _databaseName);
    return await openDatabase(path, version: _databaseVersion, onOpen: (_db) {
    }, onCreate: (Database db, int version) async {
      await db.execute(
          """
          CREATE TABLE $_tableName
            (
              id TEXT,
              exprires TEXT
            )
          """
      );
    });
  }
}