import 'package:alcohol_sanitizing_sheet/src/diary/diary.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DBHelper {
  static List<Diary> initialData = [
    Diary(
        content: '仕事お疲れ様、今日はどんな感じだった？ 今日は新しいプロジェクトが始まって大変だったよ。',
        date: DateTime.now()),
    Diary(
        content: 'どんなプロジェクトなの？ 複数の会社でゲームを作ることになったんだけど、先方のエンジニアがコミュニケーションが下手で',
        date: DateTime.now()),
    Diary(
        content:
            'あなたはどうしたの？ 相手に寄り添って話を聞いて、信頼を勝ち取ったんだ。そこからはスムーズに意見を交わし合えるようになった',
        date: DateTime.now()),
  ];

  static Future<Database> database() async {
    print("database");
    final dbPath = await getDatabasesPath();
    return openDatabase(join(dbPath, 'myDiary.db'), onCreate: (db, version) {
      return db.execute(
          'CREATE TABLE diaries(id INTEGER PRIMARY KEY AUTOINCREMENT, content TEXT, date TEXT);');
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
    var result = await db.query('diaries');
    if (result.isEmpty) {
      for (var diary in initialData) {
        await insertDiary(diary);
      }
      result = await db.query('diaries');
    }
    return result.map((e) => Diary.fromMap(e)).toList();
  }
}
