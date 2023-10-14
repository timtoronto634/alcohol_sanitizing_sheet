import 'package:alcohol_sanitizing_sheet/src/helper.dart/db_helper.dart';
import 'package:flutter/material.dart';
import 'diary.dart'; // Import your Diary model
import 'package:intl/intl.dart';

class DiaryCreateEditPage extends StatefulWidget {
  final Diary? diary;

  DiaryCreateEditPage({this.diary});

  @override
  _DiaryCreateEditPageState createState() => _DiaryCreateEditPageState();
}

class _DiaryCreateEditPageState extends State<DiaryCreateEditPage> {
  TextEditingController contentController = TextEditingController();
  DateTime _date = DateTime.now();
  final formatter = DateFormat('yyyy年MM月dd日', 'ja_JP');

  @override
  void initState() {
    super.initState();
    if (widget.diary != null) {
      contentController.text = widget.diary!.content;
      _date = widget.diary!.date;
    }
  }

  void saveDiary() async {
    if (widget.diary == null) {
      // Create new Diary
      Diary newDiary = Diary(
        content: contentController.text,
        date: _date,
      );

      await DBHelper.insertDiary(newDiary);
    } else {
      // Update existing Diary
      Diary updatedDiary = Diary(
        id: widget.diary!.id,
        content: contentController.text,
        date: _date,
      );
      await DBHelper.updateDiary(updatedDiary);
    }
  }

  void _selectDate() async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: _date,
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (pickedDate != null && pickedDate != _date) {
      setState(() {
        _date = pickedDate;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.diary == null ? '日記を書く' : '日記を編集する'),
        backgroundColor: Color(0xFFFFFFFF),
        titleTextStyle: TextStyle(
          color: Colors.blue[900],
          fontSize: 20,
        ),
        iconTheme: IconThemeData(
          color: Colors.blue[900],
        ),
      ),
      body: Column(
        children: [
          ElevatedButton(
            onPressed: () async {
              final DateTime? pickedDate = await showDatePicker(
                context: context,
                initialDate: _date,
                firstDate: DateTime(2000),
                lastDate: DateTime(2101),
              );
              if (pickedDate != null && pickedDate != _date) {
                setState(() {
                  _date = pickedDate;
                });
              }
            },
            child: Text('日付を選択する'),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.blue[800],
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 16.0),
            child: TextField(
              controller: contentController,
              decoration: InputDecoration(labelText: 'Content'),
              keyboardType: TextInputType.multiline,
              maxLines: null,
            ),
          ),
          ElevatedButton(
            onPressed: () {
              saveDiary();
              Navigator.pop(context);
            },
            child: Text('保存する'),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.blue[800],
            ),
          ),
        ],
      ),
    );
  }
}
