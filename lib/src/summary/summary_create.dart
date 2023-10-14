import 'dart:ffi';

import 'package:alcohol_sanitizing_sheet/src/helper.dart/db_helper.dart';
import 'package:flutter/material.dart';
import 'package:dart_openai/dart_openai.dart';

class Summary extends StatefulWidget {
  @override
  SummaryState createState() => SummaryState();
}

class SummaryState extends State<Summary> {
  String _summary =
      '可愛い声で答えるね！私の視点で日記を読んでみると、私の強みやアピールポイントは次の3点だと思うよ〜：1. プロジェクトの進行管理力：新機能の実装やプレゼンの準備など、さまざまな仕事を同時に進める能力があるんだ。プロジェクト全体の進捗状況を把握しながら、着実に目標に向かって進んでいるよ！2. チームワークとコミュニケーション能力：チームメンバーとの連携を強化するためのアイデアを探求したり、効率的なコミュニケーションの重要性を感じているんだ。みんなと協力しながら、プロジェクトを成功させることができるよ！3. 最終段階における注意力：細部まで気を配りながら、コードの調整やデバッグ作業などを行っているんだ。全体の完成度に満足しつつも、細かい修正や見直しを怠らない努力を大切にしているよ！次のプロジェクトでも同様の姿勢で頑張るつもりだよ〜可愛い声で答えるね！私の視点で日記を読んでみると、私の強みやアピールポイントは次の3点だと思うよ〜：1. プロジェクトの進行管理力：新機能の実装やプレゼンの準備など、さまざまな仕事を同時に進める能力があるんだ。プロジェクト全体の進捗状況を把握しながら、着実に目標に向かって進んでいるよ！2. チームワークとコミュニケーション能力：チームメンバーとの連携を強化するためのアイデアを探求したり、効率的なコミュニケーションの重要性を感じているんだ。みんなと協力しながら、プロジェクトを成功させることができるよ！3. 最終段階における注意力：細部まで気を配りながら、コードの調整やデバッグ作業などを行っているんだ。全体の完成度に満足しつつも、細かい修正や見直しを怠らない努力を大切にしているよ！次のプロジェクトでも同様の姿勢で頑張るつもりだよ〜';
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
<<<<<<< HEAD
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
                  child: Text(_summary),
                ),
              ),
            ),
          ),
=======
          _isLoading ? const CircularProgressIndicator() : Text(_summary),
>>>>>>> origin/main
        ],
      ),
    );
  }
}
