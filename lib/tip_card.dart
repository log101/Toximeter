import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

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
        onTap: null,
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


