import 'package:alcohol_sanitizing_sheet/src/diary/diary.dart';
import 'package:alcohol_sanitizing_sheet/src/helper.dart/db_helper.dart';
import 'package:flutter/material.dart';

class DiaryList extends StatefulWidget {
  @override
  _DiaryListState createState() => _DiaryListState();
}

class _DiaryListState extends State<DiaryList> {
  late Future<List<Diary>> diaryList;

  Future<List<Diary>> fetchDiariesFromDB() async {
    // DBHelper dbHelper = DBHelper();
    return await DBHelper.fetchDiaries();
  }

  @override
  void initState() {
    super.initState();
    diaryList = fetchDiariesFromDB();
  }

  Future<void> _reloadData() async {
    setState(() {
      diaryList = fetchDiariesFromDB();
    });
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: _reloadData,
      child: FutureBuilder<List<Diary>>(
        future: fetchDiariesFromDB(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return CircularProgressIndicator(); // show a loading spinner
          } else if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Text('No diaries found');
          } else {
            List<Diary> diaries = snapshot.data!;

            return ListView.builder(
              itemCount: diaries.length,
              itemBuilder: (context, index) {
                final diary = diaries[index];
                return ListTile(
                  title: Text(diary.title),
                  subtitle: Text(diary.date.toIso8601String()),
                  onTap: () {
                    // Navigate to diary details page
                  },
                );
              },
            );
          }
        },
      ),
    );
  }
}
