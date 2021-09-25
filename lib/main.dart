import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:toximeter_shellhacks/settings_tab.dart';
import 'package:toximeter_shellhacks/today_chart.dart';
import 'tip_card.dart';
import 'package:http/http.dart' as http;
import 'summary_bar_chart.dart';

var answerList = List<int>.filled(14,0);

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return CupertinoApp(
      title: 'ToxiMeter',
      home: const MyHomePage(title: 'ToxiMeter'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final _tabs = <Widget>[
    HomeTab(),
    TipsTab(),
    SettingsTab(),
  ];

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        middle: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.grain),
            Text("ToxiMeter"),
          ],
        ),
      ),
      child: CupertinoTabScaffold(
          tabBar: CupertinoTabBar(
            items: [
              BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
              BottomNavigationBarItem(icon: Icon(Icons.health_and_safety), label: 'Tips'),
              BottomNavigationBarItem(
                  icon: Icon(Icons.settings), label: 'Settings')
            ],
          ),
          tabBuilder: (BuildContext context, index) {
            return _tabs[index];
          }),
      );
  }
}

class HomeTab extends StatefulWidget {
  const HomeTab({Key? key}) : super(key: key);

  @override
  State<HomeTab> createState() => _HomeTabState();
}

class _HomeTabState extends State<HomeTab> {
  var saved = false;

  void _toggleSaved() {
    setState(() {
      saved = true;
    });
  }
  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.all(8.0),
        child: ListView(
          children: [
            Text('Today'),
            Center(
                child: Padding(
                  padding: const EdgeInsets.only(top: 10.0, bottom: 10.0),
                  child: (saved == true) ?
                  TodayChart() :
                  CupertinoButton(
                      color: Colors.blueAccent,
                      child: Row(
                        children: [
                          Icon(Icons.add),
                          Text("Add today's toximeter data!"),
                        ],
                      ),
                      onPressed: () => showCupertinoModalBottomSheet(
                        context: context,
                        builder: (context) => QuestionsWidget(_toggleSaved),
                      )),
                )
            ),
            Text('Summary'),
            SummaryBarChart(),
        ]),
    );
  }
}

// Settings Tab

class TipsTab extends StatelessWidget {
  const TipsTab({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        TipCard(),
    ]);
  }
}

class QuestionsWidget extends StatefulWidget {
  QuestionsWidget(this.toggle);
  var toggle;

  final questionList = <Question>[
    Question("How many hours have you spent outside?", ["0","1-4","4-7","7-10"]),
    Question("How many hours have you spent in traffic?", ["0","1-4","4-7", "7-10"]),
    Question("How many cigarettes have you smoked", ["0","1-3","3-5", "5+"]),
    Question("How much alcohol have you consumed?", ["0","100-200", "200-500","500+"]),
    Question("How much time you spent talking on the phone?", ["0","1-3","3-5", "5+"]),
    Question("Did you unplug your home electronics before going to bed?", ["Yes", "No"]),
    Question("Is there overhead power line near you location?", ["Yes", "No"]),
    Question("Have you had any CT scan?", ["Yes", "No"]),
    Question("How many personal care products you use?", ["0", "1-3", "3-5", "5+"]),
    Question("Have you recently ?", ["0", "1-3", "3-5", "5+"]),
    Question("How many fruits/vegetables you consumed today?", ["0", "1-3", "3-5", "5+"]),
    Question("Have you done mild training today? How many hours?", ["0", "1-3", "3-5", "5+"]),
    Question("Have you done moderate training today? How many hours?", ["0", "1-3", "3-5", "5+"]),
    Question("How you consumed at least 2lt of water today?", ["Yes", "No"])
  ];

  @override
  State<QuestionsWidget> createState() => _QuestionsWidgetState();
}

class _QuestionsWidgetState extends State<QuestionsWidget> {
  Question? question;
  int questionIndex = 0;
  int answer = 0;

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        leading: Row(
          children: [
            CupertinoNavigationBarBackButton(),
          ],
        ),
        border: null,
        backgroundColor: Colors.white,
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
          Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(child: Text(answerList.toString())),
            Center(child: Text(widget.questionList[questionIndex].question)),
            SizedBox(
              height: 200,
              child: CupertinoPicker(
                itemExtent: 64,
                children: widget.questionList[questionIndex].items.map((item) => Center(child: Text(item))).toList(),
                onSelectedItemChanged: (index) {
                  if (widget.questionList[questionIndex].items[index] == "Yes") {
                    setState(() => answer = -1);
                  } else if (widget.questionList[questionIndex].items[index] == "No") {
                    setState(() => answer = 1);
                  } else {
                    setState(() =>
                    answer = index);
                  }
                  },
              ),
            ),
          ],
        ),
            CupertinoButton(child: Text("Next"), onPressed: () => setState(() {
              answerList[questionIndex] = answer;
              questionIndex++;
              if (questionIndex >= widget.questionList.length) {
                widget.toggle();
                Navigator.of(context).pop();
              }
              question = widget.questionList[questionIndex];
            })),
          CupertinoButton(child: Text("Skip"), onPressed: () => setState(() {
            questionIndex++;
            if (questionIndex >= widget.questionList.length) {
              Navigator.of(context).pop();
            }
            question = widget.questionList[questionIndex];
          })),
          ],
        ),
      ),
    );
  }
}


class Question extends StatefulWidget {
  Question(this.question, this.items);

  final String question;
  final List<String> items;

  @override
  State<Question> createState() => _QuestionState();
}

class _QuestionState extends State<Question> {
  int index = 0;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Center(child: Text(widget.question)),
        SizedBox(
          height: 200,
          child: CupertinoPicker(
            itemExtent: 64,
            children: widget.items.map((item) => Center(child: Text(item))).toList(),
            onSelectedItemChanged: (index) {
              setState(() => null);
            },
          ),
        ),
      ],
    );
  }
}

class TodayFocused extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
        navigationBar: CupertinoNavigationBar(
          middle: Text("Today"),
          backgroundColor: Colors.white,
        ),
        child: ListView(
          children: [
            TodayChart(),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text("Highlights"),
            ),
            HighlightCard("Sample Title", "Sample Subtitle", Icon(Icons.home)),
          ],
        ));
  }
}

Future<Pollution> fetchPollution() async {
  final response = await http
      .get(Uri.parse('https://jsonplaceholder.typicode.com/albums/1'));

  if (response.statusCode == 200) {
    // If the server did return a 200 OK response,
    // then parse the JSON.
    return Pollution.fromJson(jsonDecode(response.body));
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Failed to load pollution');
  }
}

class Pollution {
  final int uvi;
  final int aqi;

  Pollution({
    required this.uvi,
    required this.aqi,
  });

  factory Pollution.fromJson(Map<String, dynamic> json) {
    return Pollution(
      uvi: json['uvi'],
      aqi: json['forecast']['aqi'],
    );
  }
}