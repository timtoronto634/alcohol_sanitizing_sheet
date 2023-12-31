import 'package:alcohol_sanitizing_sheet/src/diary/diary.dart';
import 'package:alcohol_sanitizing_sheet/src/diary/diary_create.dart';
import 'package:alcohol_sanitizing_sheet/src/helper.dart/db_helper.dart';
import 'package:alcohol_sanitizing_sheet/src/summary/dialog_create.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

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

  Widget noDiaryMessageWidget = const Center(
    child: Padding(
      padding: EdgeInsets.all(8.0),
      child: Text('No diary yet. create diaries!'),
    ),
  );

  final formatter = DateFormat('yyyy年MM月dd日', 'ja_JP');

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Expanded(
          child: RefreshIndicator(
        onRefresh: _reloadData,
        child: FutureBuilder<List<Diary>>(
          future: widget.diaryList, // Use the list passed from the parent
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const CircularProgressIndicator(); // Show a loading spinner
            } else if (snapshot.hasError) {
              return Text('Error: ${snapshot.error}');
            } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
              return noDiaryMessageWidget;
            } else {
              List<Diary> diaries = snapshot.data!;

              return ListView.builder(
                itemCount: diaries.length,
                itemBuilder: (context, index) {
                  final diary = diaries[index];
                  return ListTile(
                    title: Text(formatter.format(diary.date)),
                    subtitle: Text(diary.content),
                    onTap: () {
                      // Navigate to the edit page and pass the diary as an argument
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              DiaryCreateEditPage(diary: diary),
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
      )),
      // Container(
      // padding: EdgeInsets.symmetric(horizontal: 16.0), child: MessageForm())
    ]);
  }
}
