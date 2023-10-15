import 'dart:ffi';

import 'package:alcohol_sanitizing_sheet/src/helper.dart/db_helper.dart';
import 'package:flutter/material.dart';
import 'package:dart_openai/dart_openai.dart';
import 'package:just_audio/just_audio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

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
    final messageContent = chatCompletion.choices.first.message.content;
    talk(messageContent, speakerName: "aoi_emo", speed: 3.0);
    setState(() {
      _summary = messageContent;
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
    return Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/images/onsen_background.jpeg'),
          fit: BoxFit.cover,
        ),
      ),
      child: Center(
        child: Column(
          children: [
            ElevatedButton(
                onPressed: _onPressed,
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color.fromRGBO(219, 171, 188, 1),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(1000),
                  ),
                ),
                child: const Text(
                  '僕の強みを聞いてみる',
                  style: TextStyle(
                      color: Color.fromRGBO(50, 50, 50, 1),
                      fontWeight: FontWeight.bold),
                )),
            // Text(_summary),
            Container(
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/images/fuuka_arima.png'),
                  // fit: BoxFit.cover,
                ),
              ),
              constraints: const BoxConstraints(
                minHeight: 650,
              ),
              child: Container(
                width: 450,
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('assets/images/box.png'),
                    alignment: Alignment.bottomCenter,
                  ),
                ),
                padding: const EdgeInsets.only(
                    top: 260, bottom: 18, left: 32, right: 32),
                constraints: const BoxConstraints(),
                child: Container(
                  height: 300,
                  child: SingleChildScrollView(
                    scrollDirection: Axis.vertical,
                    child: _isLoading
                        ? const CircularProgressIndicator()
                        : Text(_summary),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
