import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class SettingsTab extends StatefulWidget {
  const SettingsTab({Key? key}) : super(key: key);

  @override
  State<SettingsTab> createState() => _SettingsTabState();
}

class _SettingsTabState extends State<SettingsTab> {
  bool status1 = false;
  bool status2 = false;
  bool status3 = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Stack(
              children: <Widget>[
                Card(
                  margin: const EdgeInsets.only(top: 20.0),
                  child: SizedBox(
                      height: 120.0,
                      width: double.infinity,
                      child: Padding(
                        padding: const EdgeInsets.only(top: 45.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            Text(
                              "Talha Asan",
                              style: Theme.of(context).textTheme.subtitle1,
                            ),
                            Text("kullanıcı1")
                          ],
                        ),
                      )),
                  //elevation: 8,
                  //shadowColor: Colors.black,
                  shape: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.black45, width: 0.2)),
                ),
                Positioned(
                  top: 50,
                  left: .0,
                  right: 275,
                  child: Center(
                    child: CircleAvatar(
                      radius: 30.0,
                      child: Text("D"),
                    ),
                  ),
                )
              ],
            ),
            SizedBox(height: 50),
            Divider(color: Colors.black45),
            ListTile(
              title: const Text('Dark Mode'),
              trailing: CupertinoSwitch(
                value: status1,
                onChanged: (bool value) {
                  setState(() {
                    status1 = value;
                  });
                },
              ),
              onTap: () {
                setState(() {
                  status1 = !status1;
                });
              },
            ),
            Divider(color: Colors.black45),
            ListTile(
              title: const Text('Using Tobacco'),
              trailing: CupertinoSwitch(
                value: status2,
                onChanged: (bool value) {
                  setState(() {
                    status2 = value;
                  });
                },
              ),
              onTap: () {
                setState(() {
                  status2 = !status2;
                });
              },
            ),
            Divider(color: Colors.black45),
            ListTile(
              title: const Text('Using Alcohol'),
              trailing: CupertinoSwitch(
                value: status3,
                onChanged: (bool value) {
                  setState(() {
                    status3 = value;
                  });
                },
              ),
              onTap: () {
                setState(() {
                  status3 = !status3;
                });
              },
            ),
            Divider(color: Colors.black45),
          ],
        ),
      ),
    );
  }
}