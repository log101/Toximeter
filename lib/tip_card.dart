import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

Widget TipCard() => GestureDetector(
    onTap: () {
      print("Click event on Container");
    },
    child: Card(
    clipBehavior: Clip.antiAlias,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(24),
    ),
    child: Column(
      children: [
        Stack(
          children: [
            Ink.image(
              image: NetworkImage(
                'https://images.unsplash.com/photo-1514888286974-6c03e2ca1dba?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1327&q=80',
              ),
              height: 240,
              fit: BoxFit.cover,
            ),
            SizedBox(height: 40),
          ],
        ),
        SizedBox(height:10),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            'Diesel Exhaust Gases and its toxic effects',

            style: TextStyle(fontSize: 20),
          ),
        ),
        Padding(
          padding: EdgeInsets.all(16).copyWith(bottom: 0),
          child: Text(
            'Alt başlık',
            style: TextStyle(fontSize: 16),
          ),
        ),
      ],
    )));

/*
Widget HighlightCard(String title,String subtitle,Icon icon,Function ?function) {
  return Container (
    height: 200,
    child: Card(
      child: ListTile(
        title: Text(title),
        leading: icon,
        //contentPadding: EdgeInsets.symmetric(horizontal: 10,vertical: 1),
        onTap: ()=> function,
        subtitle: Text(subtitle),
      ),

      elevation: 8,
      shadowColor: Colors.black,
      margin: EdgeInsets.all(20),
      shape:  OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(color: Colors.black, width: 3)
      ),

    ));
}
*/
class HighlightCard extends StatelessWidget {
  HighlightCard(this.title, this.subtitle, this.icon);

  final String title;
  final String subtitle;
  final Icon icon;

  @override
  Widget build(BuildContext context) {
    return Container (
        height: 200,
        child: Card(
          child: ListTile(
            title: Text(title),
            leading: icon,
            subtitle: Text(subtitle),
          ),

          elevation: 8,
          shadowColor: Colors.black,
          margin: EdgeInsets.all(20),
          shape:  OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(color: Colors.black, width: 3)
          ),

        ));
  }
}