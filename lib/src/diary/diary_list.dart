import 'package:alcohol_sanitizing_sheet/src/diary/diary.dart';
import 'package:flutter/material.dart';

class DiaryList extends StatelessWidget {
  final List<Diary> diaryEntries = [
    Diary(
        id: 1,
        title: 'Day at the Beach',
        content: 'Had an amazing time at the beach with friends.',
        date: DateTime(2023, 1, 1)),
    Diary(
        id: 2,
        title: 'Flutter Study',
        content: 'Learned a lot about state management today.',
        date: DateTime(2023, 1, 2)),
    Diary(
        id: 3,
        title: 'Grocery Shopping',
        content: 'Bought vegetables, fruits, and some snacks.',
        date: DateTime(2023, 1, 3)),
    Diary(
        id: 4,
        title: 'Workout',
        content: 'Did a 30-minute cardio session.',
        date: DateTime(2023, 1, 4)),
    Diary(
        id: 5,
        title: 'Reading',
        content: 'Read a few chapters of a new novel.',
        date: DateTime(2023, 1, 5)),
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
