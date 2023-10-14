import 'package:alcohol_sanitizing_sheet/src/diary/diary.dart';
import 'package:flutter/material.dart';

class DiaryList extends StatelessWidget {
  // This data would usually come from your database
  final List<Diary> diaryEntries = [
    // Mocked data or fetch from the database
  ];

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: diaryEntries.length,
      itemBuilder: (context, index) {
        final diary = diaryEntries[index];
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
}
