import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'IMooc Flutter Demo',
      home: Scaffold(
        appBar:  new AppBar(
          title:  new Text('ListVew Widget'),
        ),
        body: new ListView(
          children: <Widget>[
            new ListTile(
              leading: new Icon(Icons.border_right),
              title: new Text('border_right'),
            ),
          ],
        ),

      ),
    );
  }
}