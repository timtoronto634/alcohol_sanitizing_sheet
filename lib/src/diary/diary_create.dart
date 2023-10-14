import 'package:alcohol_sanitizing_sheet/src/helper.dart/db_helper.dart';
import 'package:flutter/material.dart';
import 'diary.dart'; // Import your Diary model

class DiaryCreatePage extends StatefulWidget {
  @override
  _DiaryCreatePageState createState() => _DiaryCreatePageState();
}

class _DiaryCreatePageState extends State<DiaryCreatePage> {
  final _formKey = GlobalKey<FormState>();
  String _title = '';
  String _content = '';
  DateTime _date = DateTime.now();

  void _saveDiary() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();

      // Create a new Diary object and save it to the database
      final newDiary = Diary(title: _title, content: _content, date: _date);
      await DBHelper.insertDiary(newDiary);

      // Navigate back to the home page
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Create Diary'),
        actions: [
          IconButton(
            icon: Icon(Icons.save),
            onPressed: _saveDiary,
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                decoration: InputDecoration(labelText: 'Title'),
                onSaved: (value) => _title = value ?? '',
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a title';
                  }
                  return null;
                },
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Content'),
                maxLines: 4,
                onSaved: (value) => _content = value ?? '',
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter content';
                  }
                  return null;
                },
              ),
              SizedBox(height: 16.0),
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
                child: Text('Pick date'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
