import 'package:flutter_example/data/common/AppDatabase.dart';
import 'package:flutter_example/data/word/Word.dart';

class WordStorage {

  final AppDatabase _appDatabase;

  WordStorage(this._appDatabase);

  Future<List<Word>> findStudy() async {
    var database = await _appDatabase.database;
    var rows = await database.rawQuery("SELECT * FROM words WHERE ic_completed = 0");
    List<Word> words = rows.isNotEmpty ? rows.map((row) => Word.fromMap(row)).toList() : [];
    return words;
  }

  Future<List<Word>> findCompleted() async {
    var database = await _appDatabase.database;
    var rows = await database.rawQuery("SELECT * FROM words WHERE ic_completed = 1");
    List<Word> words = rows.isNotEmpty ? rows.map((row) => Word.fromMap(row)).toList() : [];
    return words;
  }

  Future<List<Word>> findAll() async {
    var database = await _appDatabase.database;
    var rows = await database.rawQuery("SELECT * FROM words");
    List<Word> words = rows.isNotEmpty ? rows.map((row) => Word.fromMap(row)).toList() : [];
    return words;
  }

  void updateIsCompleted(int id, bool isCompleted) async {
    var completed = isCompleted ? 1 : 0;
    var database = await _appDatabase.database;
    await database.rawUpdate("UPDATE words SET ic_completed = ? WHERE _id = ?", [completed, id]);
  }
}
