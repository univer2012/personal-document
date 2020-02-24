import 'package:flutter/material.dart';

class Lay2FlexibleRowPage extends StatelessWidget {
  const Lay2FlexibleRowPage({Key key}) : super(key: key);

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
        title: Text('灵活水平布局'),
      ),
      body: Row(
        children: <Widget>[
          Expanded(
            child: new RaisedButton(
              color: Colors.redAccent,
              child: new Text('红色按钮'),
              onPressed: (){

              }
            )
          ),
          Expanded(
            child: new RaisedButton(
              color: Colors.orangeAccent,
              child: new Text('黄色按钮'),
              onPressed: (){

              }
            )
          ),
          Expanded(
            child: new RaisedButton(
              color: Colors.pinkAccent,
              child: new Text('粉色按钮'),
              onPressed: (){

              }
            )
          ),

        ],
      ),
    );
  }
}