import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'texts.dart';

class HighlightCardList extends StatelessWidget {
  HighlightCardList(this.answers);

  var answers;
  var cardList = <Widget>[];
  @override
  Widget build(BuildContext context) {
    if (answers[0] > 1 || answers[1] == 1) {
      cardList.add(
        HighlightCard("Sun Exposure Warning", Icon(Icons.wb_sunny))
      );
    }
    if (answers[2] > 1) {
      cardList.add(
          HighlightCard("Traffic Warning", Icon(Icons.wb_sunny))
      );
    }
    return Column(
      children: cardList,
    );
  }

}

class HighlightCard extends StatelessWidget {
  HighlightCard(this.title, this.icon);

  final String title;
  final Icon icon;

  @override
  Widget build(BuildContext context) {
    return Container (
        height: 200,
        child: Card(
          child: ListTile(
            title: Text(title),
            leading: icon,
          ),
          shadowColor: Colors.black,
          margin: EdgeInsets.all(12),
          shape:  OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(color: Colors.grey)
          ),

        ));
  }
}

class TipCardNew extends StatelessWidget {
  TipCardNew(this.title, this.subtitle, this.image);

  final String title;
  final String subtitle;
  final String image;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () => showCupertinoModalBottomSheet(
          context: context,
          builder: (context) => CupertinoPageScaffold(
            navigationBar: CupertinoNavigationBar(),
            child: ListView(
              children: [
                Image.asset(
                  image,
                  height: 240,
                  width: 380,
                  fit: BoxFit.fill,
                ),
                Divider(),
                Padding(
                  padding: const EdgeInsets.fromLTRB(0,16,8,0),
                  child: Text(title,
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 24.0,
                          letterSpacing: 0.15,
                          color:Colors.black,
                          fontWeight: FontWeight.bold)),
                ),
                Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Text(texts[title] ?? "Couldn't find text",
                  textAlign: TextAlign.justify),
                ),
                Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Text(references[title] ?? "Couldn't find text",
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.blue),),
                ),
              ],
            ),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.only(top: 8.0, left: 8.0, right: 8.0),
          child: Padding(
            padding: const EdgeInsets.only(left: 20, right: 20.0, top: 8.0),
            child: Card(
                clipBehavior: Clip.antiAlias,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                    side: BorderSide(color: Colors.grey, width: 0.5)
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Stack(
                      children: [
                        Image.asset(
                          image,
                          height: 240,
                          width: 380,
                          fit: BoxFit.fill,
                        ),
                      ],
                    ),
                    Divider(),
                    Padding(
                      padding: const EdgeInsets.only(top: 4.0, left: 10.0),
                      child: Text(
                        title,
                        textAlign: TextAlign.left,
                        style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(10),
                      child: Text(
                        subtitle,
                        style: TextStyle(fontSize: 16),
                      ),
                    ),
                  ],
                )),
          ),
        ));
  }
}


