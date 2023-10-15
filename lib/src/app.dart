import 'package:alcohol_sanitizing_sheet/src/diary/diary.dart';
import 'package:alcohol_sanitizing_sheet/src/diary/diary_create.dart';
import 'package:alcohol_sanitizing_sheet/src/diary/diary_list.dart';
import 'package:alcohol_sanitizing_sheet/src/summary/summary_create.dart';
import 'package:alcohol_sanitizing_sheet/src/helper.dart/db_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primaryColor: Colors.blue[800],
      ),
      localizationsDelegates: GlobalMaterialLocalizations.delegates,
      supportedLocales: const [
        Locale('ja', 'JP'),
      ],
      home: MyDiaryHomePage(title: 'DiaP'),
    );
  }
}

class MyDiaryHomePage extends StatefulWidget {
  MyDiaryHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _MyDiaryHomePageState createState() => _MyDiaryHomePageState();
}

class _MyDiaryHomePageState extends State<MyDiaryHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/images/fuuka_arima.png'),
        ),
      ),
      constraints: const BoxConstraints(
        minHeight: 650,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Column(
            children: <Widget>[
              Center(
                child: Container(
                  padding: const EdgeInsets.all(16),
                  color: Colors.white.withOpacity(0.5),
                  child: const Text(
                    'The girl in the background is talking',
                    style: TextStyle(fontSize: 16),
                  ),
                ),
              ),
              // Buttons below the rectangle
              Align(
                alignment: const Alignment(0, 0.7),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    ElevatedButton(
                      onPressed: () {},
                      child: Text('Button 1'),
                    ),
                    ElevatedButton(
                      onPressed: () {},
                      child: Text('Button 2'),
                    ),
                  ],
                ),
              ),
            ],
          ),
          // Chat editor at the bottom
          const Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: EdgeInsets.all(8.0),
              child: TextField(
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Type yoddur message',
                ),
              ),
            ),
          ),
        ],
      ),
    ));
  }
}
