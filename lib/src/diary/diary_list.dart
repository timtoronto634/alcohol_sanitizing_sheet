import 'package:alcohol_sanitizing_sheet/src/diary/diary.dart';
import 'package:alcohol_sanitizing_sheet/src/diary/diary_create.dart';
import 'package:alcohol_sanitizing_sheet/src/helper.dart/db_helper.dart';
import 'package:flutter/material.dart';

class DiaryList extends StatefulWidget {
  final Future<List<Diary>> diaryList;
  final Function() onReload;

  DiaryList({required this.diaryList, required this.onReload});

  @override
  _DiaryListState createState() => _DiaryListState();
}

class _DiaryListState extends State<DiaryList> {
  Future<void> _reloadData() async {
    // Call the parent's reload function
    widget.onReload();
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: _reloadData,
      child: FutureBuilder<List<Diary>>(
        future: widget.diaryList, // Use the list passed from the parent
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return CircularProgressIndicator(); // Show a loading spinner
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
                    // Navigate to the edit page and pass the diary as an argument
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => DiaryCreateEditPage(diary: diary),
                      ),
                    ).then((value) {
                      // Reload the data when coming back to this page
                      if (value == true) {
                        _reloadData();
                      }
                    });
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
