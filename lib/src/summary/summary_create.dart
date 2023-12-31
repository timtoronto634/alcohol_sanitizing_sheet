import 'dart:ffi';

import 'package:alcohol_sanitizing_sheet/src/diary/diary.dart';
import 'package:alcohol_sanitizing_sheet/src/helper.dart/db_helper.dart';
import 'package:alcohol_sanitizing_sheet/src/summary/dialog_create.dart';
import 'package:alcohol_sanitizing_sheet/src/summary/reply_message_box.dart';
import 'package:alcohol_sanitizing_sheet/src/summary/summary_button.dart';
import 'package:flutter/material.dart';
import 'package:dart_openai/dart_openai.dart';
import 'package:just_audio/just_audio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class Summary extends StatefulWidget {
  @override
  SummaryState createState() => SummaryState();
}

class SummaryState extends State<Summary> {
  String _message = '仕事お疲れ様、今日はどんな感じだった？';
  bool _isLoading = false;

  void changeMessage(String message) {
    setState(() {
      _message = message;
    });
  }

  void _onChat(Diary diary) async {
    setState(() {
      _isLoading = true;
    });

    OpenAIChatCompletionModel chatCompletion =
        await OpenAI.instance.chat.create(
      model: "gpt-3.5-turbo",
      messages: [
        const OpenAIChatCompletionChoiceMessageModel(
          content:
              "最終的に質問者の強みに気づかせるようなコーチとして返答してください。返答は短く、頷きや、さらに良さを引き出すような質問にしてください。口調は可愛い女の子風にしてください。",
          role: OpenAIChatMessageRole.system,
        ),
        OpenAIChatCompletionChoiceMessageModel(
          content: diary.content,
          role: OpenAIChatMessageRole.user,
        ),
      ],
    );
    print(chatCompletion.usage);
    final messageContent = chatCompletion.choices.first.message.content;
    diary.content = diary.content + messageContent;
    await DBHelper.insertDiary(diary);
    talk(messageContent, speakerName: "aoi_emo", speed: 3.0);
    setState(() {
      changeMessage(messageContent);
      _isLoading = false;
    });
  }

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
              "次に与えられたメッセージの記録から、読み取れるアピールポイントや強みについて3~5点返答してください。返答は口調は可愛い女の子風にしてください。",
          role: OpenAIChatMessageRole.system,
        ),
        OpenAIChatCompletionChoiceMessageModel(
          content: diaryJoinString,
          role: OpenAIChatMessageRole.user,
        ),
      ],
    );
    print(chatCompletion.usage);
    final messageContent = chatCompletion.choices.first.message.content;
    talk(messageContent, speakerName: "aoi_emo", speed: 3.0);
    setState(() {
      changeMessage(messageContent);
      _isLoading = false;
    });
  }

  void talk(String message,
      {String speakerName = "akane_west_emo", double speed = 1.0}) async {
    const baseUrl = 'https://webapi.aitalk.jp/webapi/v5/ttsget.php';
    const ext = 'mp3';
    final username = dotenv.get('AITALK_USERNAME');
    final password = dotenv.get('AITALK_PASSWORD');

    var speakerName = 'akane_west_emo';
    var text = message;
    var speedStr = speed.toString();

    var url =
        "$baseUrl?username=$username&password=$password&ext=$ext&speaker_name=$speakerName&speed=$speedStr&text=$text";
    final player = AudioPlayer();
    await player.setUrl(url);
    player.play();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        SizedBox.expand(
            child: FittedBox(
          fit: BoxFit.cover,
          child: Image.asset('assets/images/onsen_background.png'),
        )),
        SizedBox.expand(
            child: FittedBox(
          fit: BoxFit.contain,
          child: Image.asset('assets/images/fuuka_arima.png'),
        )),
        Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                ReplyMessageBox(isLoading: _isLoading, message: _message),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [DoSummaryButton(onPressed: _onPressed)],
                ),
              ],
            ),
            const SizedBox(height: 32),
            Padding(
              padding: const EdgeInsets.only(
                top: 8,
                bottom: 48.0,
                left: 8,
                right: 8,
              ),
              child: MessageForm(onMessageSend: _onChat),
            ),
            SizedBox(
              height: MediaQuery.of(context).viewInsets.bottom,
            ),
          ],
        ),
      ],
    );
  }
}
