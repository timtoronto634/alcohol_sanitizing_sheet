import 'package:alcohol_sanitizing_sheet/src/helper.dart/db_helper.dart';
import 'package:flutter/material.dart';
import 'package:dart_openai/dart_openai.dart';

class Summary extends StatefulWidget {
  @override
  SummaryState createState() => SummaryState();
}

class SummaryState extends State<Summary> {
  String _summary = '';

  void _onPressed() async {
    final diaryList = await DBHelper.fetchDiaries();
    final diaryJoinString =
        diaryList.map((diary) => diary.content).toList().join("\n");

    // OpenAIChatCompletionModel chatCompletion =
    //     await OpenAI.instance.chat.create(
    //   model: "gpt-3.5-turbo",
    //   messages: [
    //     OpenAIChatCompletionChoiceMessageModel(
    //       content:
    //           "以下の文章は1週間分の日記です。日記から筆者の強みやアピールポイントを推測してください\n\n$diaryJoinString",
    //       role: OpenAIChatMessageRole.user,
    //     ),
    //   ],
    // );
    // return chatCompletion.choices.first.message.content;
    setState(() {
      _summary = diaryJoinString;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          ElevatedButton(
              onPressed: _onPressed,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue[800],
              ),
              child: const Text('要約する')),
          Text(_summary),
        ],
      ),
    );
  }
}
