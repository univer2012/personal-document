import 'package:flutter/material.dart';

class Lay4BaseColumnPage extends StatelessWidget {
  const Lay4BaseColumnPage({Key key}) : super(key: key);

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
        title: Text('水平布局Row'),
      ),
      //你会发现文字是以最长的一段文字居中对齐的，看起来很别扭。那如果想让文字以左边开始对齐，只需要加入一个对齐属性。
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text('I am JSPang'),
          Text('my website is jspang.com'),
          Text('I love coding'),
        ],
      ),
    );
  }
}