import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:fl_chart/fl_chart.dart';

import 'summary_bar_chart.dart';

var answerList = List<int>.filled(4,0);

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
        padding: EdgeInsets.only(top: 120.0, left: 10.0, right: 10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Today'),
            Center(
                child: Padding(
                  padding: const EdgeInsets.only(top: 10.0, bottom: 10.0),
                  child: (saved == true) ? SummaryBarChart() : CupertinoButton(
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
class SettingsTab extends StatelessWidget {
  const SettingsTab({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text('Tips'),
    );
  }
}

class TipsTab extends StatelessWidget {
  const TipsTab({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text('Settings'),
    );
  }
}

class QuestionsWidget extends StatefulWidget {
  QuestionsWidget(this.toggle);
  var toggle;

  final questionList = <Question>[
    Question("Sample Question 1", ["0","1","2","3"]),
    Question("Sample Question 2", ["0","1","2","3"]),
    Question("Sample Question 3", ["0","1","2","3"]),
    Question("Sample Question 4", ["0","1","2","3"]),
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
                  setState(() => answer = int.parse(widget.questionList[questionIndex].items[index]));
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