import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    var stack = new Stack(
      alignment: const FractionalOffset(0.5, 0.8),
      children: <Widget>[
        new CircleAvatar(
          backgroundImage: new NetworkImage(''),
          radius: 100.0,
        ),

        new Container(
          decoration: new BoxDecoration(
            color: Colors.lightBlue,
          ),
          padding: EdgeInsets.all(5.0),
          child: new Text('univer的头像'),
        )
      ],
    )

    return MaterialApp(
      title:  'ListView widget',
      home: new Scaffold(
        appBar: new AppBar(
          title: Text('垂直方向布局'),
        ),
        body: Center(child: ),
      ),
    );
  }
}