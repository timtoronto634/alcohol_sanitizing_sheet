import 'package:alcohol_sanitizing_sheet/src/diary/diary.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DBHelper {
  static Future<Database> database() async {
    print("database");
    final dbPath = await getDatabasesPath();
    return openDatabase(join(dbPath, 'myDiary.db'), onCreate: (db, version) {
      return db.execute(
        'CREATE TABLE diaries(id INTEGER PRIMARY KEY AUTOINCREMENT, content TEXT, date TEXT)',
      );
    }, version: 1);
  }

  // Method to insert a new diary entry
  static Future<void> insertDiary(Diary diary) async {
    print("insertDiary");
    final db = await DBHelper.database();
    await db.insert('diaries', diary.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  // Method to update an existing diary entry
  static Future<void> updateDiary(Diary diary) async {
    print("updateDiary");
    final db = await DBHelper.database();

    await db.update(
      'diaries',
      diary.toMap(),
      where: 'id = ?',
      whereArgs: [diary.id],
    );
  }

  // Method to fetch all diaries
  static Future<List<Diary>> fetchDiaries() async {
    print("fetchDiaries");
    final db = await DBHelper.database();
    final result = await db.query('diaries');
    return result.map((e) => Diary.fromMap(e)).toList();
  }
}
