import 'package:alcohol_sanitizing_sheet/src/diary/diary.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DBHelper {
  static Future<Database> database() async {
    final dbPath = await getDatabasesPath();
    return openDatabase(join(dbPath, 'myDiary.db'), onCreate: (db, version) {
      return db.execute(
        'CREATE TABLE diaries(id INTEGER PRIMARY KEY AUTOINCREMENT, title TEXT, content TEXT, date TEXT)',
      );
    }, version: 1);
  }
}

// Method to insert a new diary entry
Future<void> insertDiary(Diary diary) async {
  final db = await DBHelper.database();
  db.insert('diaries', diary.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace);
}

// Method to fetch all diaries
Future<List<Diary>> fetchDiaries() async {
  final db = await DBHelper.database();
  final result = await db.query('diaries');
  return result.map((e) => Diary.fromMap(e)).toList();
}

// Update and delete methods go here
