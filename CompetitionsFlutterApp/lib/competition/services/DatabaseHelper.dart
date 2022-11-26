import 'package:fluttercrud/competition/models/competition_model.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHelper {
  static const int _version = 1;
  static const String _databaseName = "Competitions.db";
  static Future<Database> _getDatabase() async {
    return openDatabase(
      join(await getDatabasesPath(), _databaseName),
      onCreate: (db, version) async =>
        await db.execute("CREATE TABLE Competitions("
            "id INTEGER PRIMARY KEY,"
            "title TEXT NOT NULL,"
            "judgeId INTEGER NOT NULL,"
            "category TEXT NOT NULL,"
            "maxPoints INTEGER NOT NULL,"
            "firstPlacePrize TEXT NOT NULL,"
            "description TEXT NOT NULL,"
            "submissionDeadline TEXT NOT NULL,"
            "isFinished INTEGER NOT NULL DEFAULT false);"
        ),
        version: _version
    );
  }

  static Future<int> add(Competition competition) async {
    final db = await _getDatabase();
    return await db.insert(
        "Competitions",
        competition.toJson(),
        conflictAlgorithm: ConflictAlgorithm.replace
    );
  }

  static Future<int> update(Competition competition) async {
    final db = await _getDatabase();
    return await db.update(
        "Competitions",
        competition.toJson(),
        where: 'id = ?',
        whereArgs: [competition.id],
        conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  static Future<int> delete(int id) async {
    final db = await _getDatabase();
    return await db.delete(
      "Competitions",
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  static Future<List<Competition>?> getAll() async {
    final db = await _getDatabase();
    final List<Map<String, dynamic>> maps = await db.query("Competitions");
    if (maps.isEmpty) {
      return null;
    }
    return List.generate(
        maps.length, (index) => Competition.fromJson(maps[index])
    );
  }
}