import 'package:flutter_example/data/common/AppDatabase.dart';
import 'package:flutter_example/data/verb/Verb.dart';

class VerbsStorage {

  final AppDatabase _appDatabase;

  VerbsStorage(this._appDatabase);

  Future<List<Verb>> findAll() async {
    var database = await _appDatabase.database;
    var rows = await database.rawQuery("SELECT * FROM verbs");
    List<Verb> words = rows.isNotEmpty ? rows.map((row) => Verb.fromMap(row)).toList() : [];
    return words;
  }

  void convert(List<Verb> verbs) async {
    print("convert");
    var database = await _appDatabase.database;
    var reg = RegExp(r"[ \n]\[.*\]");
    for (Verb verb in verbs) {
      print("word ${verb.present} replied ${verb.present.replaceAll(reg, "")}");

      var newVerb = Verb(
        id: verb.id,
        present: verb.present.replaceAll(reg, ""),
        past: verb.past.replaceAll(reg, ""),
        perfect: verb.perfect.replaceAll(reg, ""),
        translate: verb.translate,
      );

      var count = await database.rawUpdate(
          "UPDATE verbs SET present = ?, past = ?, perfect = ? WHERE id = ?",
          [newVerb.present, newVerb.past, newVerb.perfect, newVerb.id]
      );
      print(count);
    }
  }
}