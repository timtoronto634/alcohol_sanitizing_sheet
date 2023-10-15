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
      home: MyDiaryHomePage(title: 'MyDiaryHomePage'),
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
  List<Widget> get widgetOptions => [
        DiaryList(
          diaryList: diaryList,
          onReload: _reloadData,
        ),
        Summary(),
      ];

  late Future<List<Diary>> diaryList;

  Future<List<Diary>> fetchDiariesFromDB() async {
    return await DBHelper.fetchDiaries();
  }

  @override
  void initState() {
    super.initState();
    diaryList = fetchDiariesFromDB();
  }

  Future<void> _reloadData() async {
    setState(() {
      diaryList = fetchDiariesFromDB();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Summary(), // This will be the list of diaries
      floatingActionButton: Visibility(
        child: FloatingActionButton(
          onPressed: () async {
            await Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => DiaryCreateEditPage(),
              ),
            );

            _reloadData();
          },
          backgroundColor: Colors.blue[800],
          child: const Icon(Icons.add),
        ),
      ),
    );
  }
}
