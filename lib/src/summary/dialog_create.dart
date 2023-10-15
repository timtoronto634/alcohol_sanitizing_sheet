import 'package:flutter/material.dart';
import 'package:alcohol_sanitizing_sheet/src/helper.dart/db_helper.dart';
import 'package:alcohol_sanitizing_sheet/src/diary/diary.dart';

class MessageForm extends StatefulWidget {
  @override
  _MessageFormState createState() => _MessageFormState();
}

class _MessageFormState extends State<MessageForm> {
  final _messageController = TextEditingController();

  void _onPressed() async {
    Diary newDiary = Diary(
      content: _messageController.text,
      date: DateTime.now(),
    );

    await DBHelper.insertDiary(newDiary);
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: TextField(
            controller: _messageController,
            decoration: const InputDecoration(
              hintText: 'メッセージを入力してください',
              border: OutlineInputBorder(),
            ),
          ),
        ),
        const SizedBox(width: 8),
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color.fromRGBO(219, 171, 188, 1),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(1000),
            ),
          ),
          onPressed: () {
            _onPressed();
            _messageController.clear();
          },
          child: const Text(
            '送信',
            style: TextStyle(
                color: Color.fromRGBO(50, 50, 50, 1),
                fontWeight: FontWeight.bold),
          ),
        ),
      ],
    );
  }
}
