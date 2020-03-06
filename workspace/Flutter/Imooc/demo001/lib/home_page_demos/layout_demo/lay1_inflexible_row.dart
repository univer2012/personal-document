import 'package:flutter/material.dart';

class Lay1InflexibleRowPage extends StatelessWidget {
  const Lay1InflexibleRowPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios),
          onPressed: (){
            Navigator.pop(context);
          },
        ),
        title: Text('不灵水平布局'),
      ),
      body: new Row(
        children: <Widget>[
          new RaisedButton(
            color: Colors.redAccent,
            child: new Text('红色按钮'),
            onPressed: (){

          }),
          new RaisedButton(
            color: Colors.orangeAccent,
            child: new Text('黄色按钮'),
            onPressed: (){

          }),
          new RaisedButton(
            color: Colors.pinkAccent,
            child: new Text('粉色按钮'),
            onPressed: (){

          }),
        ],
      ),
    );
  }
}