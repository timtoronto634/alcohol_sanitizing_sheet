import 'package:alcohol_sanitizing_sheet/src/helper.dart/db_helper.dart';
import 'package:flutter/material.dart';
import 'diary.dart'; // Import your Diary model

class DiaryCreateEditPage extends StatefulWidget {
  final Diary? diary;

  DiaryCreateEditPage({this.diary});

  @override
  _DiaryCreateEditPageState createState() => _DiaryCreateEditPageState();
}

class _DiaryCreateEditPageState extends State<DiaryCreateEditPage> {
  TextEditingController titleController = TextEditingController();
  TextEditingController contentController = TextEditingController();

  @override
  void initState() {
    super.initState();
    if (widget.diary != null) {
      titleController.text = widget.diary!.title;
      contentController.text = widget.diary!.content;
    }
  }

  void saveDiary() async {
    if (widget.diary == null) {
      // Create new Diary
      Diary newDiary = Diary(
        title: titleController.text,
        content: contentController.text,
        date: DateTime.now(),
      );
      await DBHelper.insertDiary(newDiary);
    } else {
      // Update existing Diary
      Diary updatedDiary = Diary(
        id: widget.diary!.id,
        title: titleController.text,
        content: contentController.text,
        date: widget.diary!.date,
      );
      await DBHelper.updateDiary(updatedDiary);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.diary == null ? 'Create Diary' : 'Edit Diary'),
      ),
      body: Column(
        children: [
          TextField(
            controller: titleController,
            decoration: InputDecoration(labelText: 'Title'),
          ),
          TextField(
            controller: contentController,
            decoration: InputDecoration(labelText: 'Content'),
          ),
          ElevatedButton(
            onPressed: () {
              saveDiary();
              Navigator.pop(context);
            },
            child: Text('Save'),
          ),
        ],
      ),
    );
  }
}
