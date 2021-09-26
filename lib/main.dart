import 'dart:convert';
import 'package:vertical_card_pager/vertical_card_pager.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:toximeter_shellhacks/settings_tab.dart';
import 'package:toximeter_shellhacks/today_chart.dart';
import 'tip_card.dart';
import 'package:http/http.dart' as http;
import 'summary_bar_chart.dart';

var answerList = List<int>.filled(12,0);
int total = 0;

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return CupertinoApp(
      debugShowCheckedModeBanner: false,
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
        backgroundColor: Colors.deepPurple,
        middle: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
                "images/beher.png",
            height: 24,
            width: 24),
            SizedBox(width: 5),
            Text("ToxiMeter", style: TextStyle(fontSize: 24.0, color: Colors.white)),
          ],
        ),
      ),
      child: CupertinoTabScaffold(
          tabBar: CupertinoTabBar(
            activeColor: Colors.indigoAccent,
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
            //Text('Today', style: TextStyle(fontSize: 24.0, letterSpacing: 0.15,color:Colors.black,fontWeight: FontWeight.bold)),
            Center(
                child: Padding(
                  padding: const EdgeInsets.only(top: 10.0, bottom: 20.0),
                  child: (saved == true) ?
                  TodayChart(total) :
                  CupertinoButton(
                      color: Colors.indigoAccent,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center ,
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
            /*Padding(
              padding: const EdgeInsets.only(left: 4.0, bottom: 10.0),
              child: Text('Summary', style: TextStyle(fontSize: 24.0, letterSpacing: 0.15,color:Colors.black,fontWeight: FontWeight.bold)),
            ),*/
            SummaryBarChart(total),
        ]),
    );
  }
}

// Settings Tab

class TipsTab extends StatelessWidget {
  TipsTab({Key? key}) : super(key: key);

  final List<String> titles = [
    "Better Food, Better Mood",
    "Sun Exposure and our Health",
    "Diesel Emissions",
  ];

  final List<Widget> images = [
    Image.asset(
      'images/sun.jpeg',
      height: 240,
      width: 380,
      fit: BoxFit.fill,
    ),
    Image.asset(
      'images/elma.jpeg',
      height: 240,
      width: 380,
      fit: BoxFit.fill,
    ),
    Image.asset(
      'images/arabalar1.jpeg',
      height: 240,
      width: 380,
      fit: BoxFit.fill,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        TipCardNew("Better Food, Better Mood", "Learn how to switch to a healthy diet", "images/elma.jpeg"),
        TipCardNew("Sun Exposure and our Health", "Here are the some potential risks of excessive sunlight", "images/sun.jpeg"),
        TipCardNew("Diesel Emissions", "Have you ever wondered how the exhaust gases effect our health? Let's take a look!", "images/arabalar1.jpeg"),
    ]);
  }
}

class QuestionsWidget extends StatefulWidget {
  QuestionsWidget(this.toggle);
  var toggle;

  final questionList = <Question>[
    Question("How many hours have you spent outside today?", ["0","1-4","4-7","7-10"], "negative"),
    Question("Did you cover or skin or used sunscreen?", ["Yes", "No"], "positive"),
    Question("How many hours have you spent in traffic?", ["0","1-4","4-7", "7-10"], "negative"),
    Question("How many standard alcoholic drinks did you have today?", ["0","1-3","3-5", "5+"], "negative"),
    Question("How much time you spent talking on the phone?", ["0","1-3","3-5", "5+"], "negative"),
    Question("Did you unplug your home electronics before going to bed?", ["Yes", "No"], "positive"),
    Question("Is there overhead power line near you location?", ["Yes", "No"], "negative"),
    Question("Have you had any CT scan today?", ["Yes", "No"], "negative"),
    Question("How many personal care products you use?", ["0", "1-3", "3-5", "5+"], "negative"),
    Question("How many serves of fruit did you eat today?", ["0", "1-3", "3-5", "5+"], "positive"),
    Question("Have you minutes did you spent training today?", ["0", "0-30", "30-60", "60-90", "90+"], "positive"),
    Question("Did you drink at least 2lt of water today?", ["Yes", "No"], "positive")
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
            Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: CupertinoNavigationBarBackButton(color: Colors.deepPurpleAccent),
            ),
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
            Center(child:
              Padding(
                padding: const EdgeInsets.only(top: 16.0),
                child: Text(widget.questionList[questionIndex].question,
                style: TextStyle(fontSize: 22.0, letterSpacing: 0.15,color:Colors.black),
                textAlign: TextAlign.center),
              )),
            SizedBox(
              height: 200,
              child: CupertinoPicker(
                itemExtent: 64,
                children: widget.questionList[questionIndex].items.map((item) => Center(child: Text(item))).toList(),
                onSelectedItemChanged: (index) {
                  if (widget.questionList[questionIndex].items[index] == "Yes") {
                    if (widget.questionList[questionIndex].side == "positive") {
                      setState(() => answer = -1);
                    } else {
                      setState(() => answer = 1);
                    }
                  } else if (widget.questionList[questionIndex].items[index] == "No") {
                    if (widget.questionList[questionIndex].side == "positive") {
                      setState(() => answer = 1);
                    } else {
                      setState(() => answer = -1);
                    }
                  } else {
                    if (widget.questionList[questionIndex].side == "positive") {
                      setState(() => answer = -index);
                    } else {
                      setState(() => answer = index);
                    }
                  }
                  },
              ),
            ),
          ],
        ),
            SizedBox(height: 20),
            CupertinoButton(
                child: Text("Next"), color: Colors.indigoAccent, onPressed: () => setState(() {
              answerList[questionIndex] = answer;
              if (questionIndex == widget.questionList.length - 1) {
                widget.toggle();
                total = answerList.reduce((value, element) => value + element);
                Navigator.of(context).pop();
              } else {
                questionIndex++;
                question = widget.questionList[questionIndex];
              }
            })),
          SizedBox(height: 10),
          CupertinoButton(child: Text("Skip"), color: Colors.grey, onPressed: () => setState(() {
            questionIndex++;
            if (questionIndex >= widget.questionList.length) {
              Navigator.of(context).pop();
            } else {
              question = widget.questionList[questionIndex];
            }
          })),
          ],
        ),
      ),
    );
  }
}


class Question extends StatefulWidget {
  Question(this.question, this.items, this.side);

  final String question;
  final List<String> items;
  final String side;

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
          leading: GestureDetector(
            onTap: () => Navigator.of(context).pop(),
            child: Icon(Icons.chevron_left, color: Colors.white),
          ),
          middle: Text("Today", style: TextStyle(color: Colors.white)),
          backgroundColor: Colors.deepPurple,
        ),
        child: ListView(
          children: [
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: TodayChart(total),
            ),
            /*Padding(
              padding: const EdgeInsets.only(left: 12.0, right: 12.0, top: 22.0, bottom: 2.0),
              child: Text("Highlights", style: TextStyle(fontSize: 24.0, letterSpacing: 0.15,color:Colors.black,fontWeight: FontWeight.bold)),
            ),*/
            HighlightCardList(answerList),
          ],
        ));
  }
}

Future<Pollution> fetchPollution() async {
  final response = await http
      .get(Uri.parse('https://api.waqi.info/feed/here/?token=cdf534b0637649d86ae27a4c568cb7bdbff22af7'));

  if (response.statusCode == 200) {
    // If the server did return a 200 OK response,
    // then parse the JSON.
    print("200");
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
      aqi: json['data']['aqi'],
      uvi: json['data']['forecast']['daily']['uvi'][0]['avg'],
    );
  }
}