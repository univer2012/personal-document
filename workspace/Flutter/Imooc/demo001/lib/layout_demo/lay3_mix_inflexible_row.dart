import 'package:flutter/material.dart';

class Lay3MixInflexibleRowPage extends StatelessWidget {
  const Lay3MixInflexibleRowPage({Key key}) : super(key: key);

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
        title: Text('灵活和不灵活的混用'),
      ),
      body: Row(
        children: <Widget>[
          RaisedButton(
            color: Colors.redAccent,
            child: Text('红色按钮'),
            onPressed: (){

          }),
          Expanded(
            child: RaisedButton(
              color: Colors.orangeAccent,
              child: Text('黄色按钮'),
              onPressed: (){

            }),
          ),
          RaisedButton(
            color: Colors.pinkAccent,
            child: Text('粉色按钮'),
            onPressed: (){

          }),
        ],
      ),
    );
  }
}