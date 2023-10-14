import 'package:flutter/material.dart';
import 'package:dart_openai/dart_openai.dart';

class Summary extends StatelessWidget {
  void _onPressed() async {
    OpenAIChatCompletionModel chatCompletion =
        await OpenAI.instance.chat.create(
      model: "gpt-3.5-turbo",
      messages: [
        OpenAIChatCompletionChoiceMessageModel(
          content: "hello, what is Flutter and Dart ?",
          role: OpenAIChatMessageRole.user,
        ),
      ],
    );
    print(chatCompletion.choices.first.message);
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ElevatedButton(
        onPressed: _onPressed,
        child: Text('要約する'),
      ),
    );
  }
}
