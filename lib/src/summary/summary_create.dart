import 'dart:ffi';

import 'package:alcohol_sanitizing_sheet/src/helper.dart/db_helper.dart';
import 'package:flutter/material.dart';
import 'package:dart_openai/dart_openai.dart';

class Summary extends StatefulWidget {
  @override
  SummaryState createState() => SummaryState();
}

class SummaryState extends State<Summary> {
  String _summary = '';
  bool _isLoading = false;

  void _onPressed() async {
    setState(() {
      _isLoading = true;
    });

    final diaryList = await DBHelper.fetchDiaries();
    final diaryJoinString =
        diaryList.map((diary) => diary.content).toList().join("\n");

    OpenAIChatCompletionModel chatCompletion =
        await OpenAI.instance.chat.create(
      model: "gpt-3.5-turbo",
      messages: [
        const OpenAIChatCompletionChoiceMessageModel(
          content:
              "Please answer the following questions in a cute tone of voice in Japanese.",
          role: OpenAIChatMessageRole.system,
        ),
        OpenAIChatCompletionChoiceMessageModel(
          content:
              "以下の文章は私の1週間分の日記なんだ。日記から読み取れる私のアピールポイントを3~5点教えてね。\n\n$diaryJoinString",
          role: OpenAIChatMessageRole.user,
        ),
      ],
    );
    print(chatCompletion.usage);
    setState(() {
      _summary = chatCompletion.choices.first.message.content;
      _isLoading = false;
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
          _isLoading ? const CircularProgressIndicator() : Text(_summary),
        ],
      ),
    );
  }
}
