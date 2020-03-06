import 'package:flutter/material.dart';

class Lay5MainCrossColumnPage extends StatelessWidget {
  const Lay5MainCrossColumnPage({Key key}) : super(key: key);

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
        title: Text('主轴和副轴的辨识'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center, //主轴
        crossAxisAlignment: CrossAxisAlignment.start,//副轴
        children: <Widget>[
          Text('I am JSPang'),
          Text('my website is jspang.com'),
          Text('I love coding'),
        ],
      ),
    );
  }
}