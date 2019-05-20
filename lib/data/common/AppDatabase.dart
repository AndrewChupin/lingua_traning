
import 'dart:async';
import 'dart:io';

import 'package:flutter/services.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite/sqlite_api.dart';

class AppDatabase {

  static const EXIST_DATABASE_NAME = "leo.db";
  static const DATABASE_NAME = "app_leo.db";
  static const DATABASE_VERSION = 1;

  static final AppDatabase shared = AppDatabase._internal();
  static Database _database;

  AppDatabase._internal();

  Future<Database> get database async {
    if (_database != null)
      return _database;

    // if _database is null we instantiate it
    await initFolder();
    _database = await initDB();
    return _database;
  }

  initDB() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, DATABASE_NAME);

    return await openDatabase(path, version: DATABASE_VERSION);
  }

  initFolder() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, DATABASE_NAME);

    // Only copy if the database doesn't exist
    if (FileSystemEntity.typeSync(path) == FileSystemEntityType.notFound){
      // Load database from asset and copy
      ByteData data = await rootBundle.load(join('assets', EXIST_DATABASE_NAME));
      List<int> bytes = data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes);

      // Save copied asset to documents
      await new File(path).writeAsBytes(bytes);
    }
  }
}


