import 'package:alcohol_sanitizing_sheet/src/diary/diary_create.dart';
import 'package:alcohol_sanitizing_sheet/src/diary/diary_list.dart';
import 'package:alcohol_sanitizing_sheet/src/summary/summary_create.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'settings/settings_controller.dart';
import 'settings/settings_view.dart';

import 'package:flutter_dotenv/flutter_dotenv.dart';

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
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
  int _selectedIndex = 0;
  static final List<Widget> _widgetOptions = <Widget>[
    DiaryList(),
    Summary(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Container(
          width: 144,
          child: Image.asset(
            'assets/images/logotype.png',
            fit: BoxFit.scaleDown,
          ),
        ),
        backgroundColor: Color(0xFFFFFFFF),
      ),
      body: _widgetOptions
          .elementAt(_selectedIndex), // This will be the list of diaries
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => DiaryCreatePage()),
          );
        },
        child: Icon(Icons.add),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.business),
            label: 'Business',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.amber[800],
        onTap: _onItemTapped,
      ),
    );
  }
}
