import 'package:flutter/material.dart';

void main() => runApp(MyApp());





class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'TextWidget',
      home: Scaffold(
        appBar: AppBar(
          title:  Text('TextWidget'),
        ),
        body: Center(
          child: Container(
            child: new Image.network(
              'https://img4.mukewang.com/szimg/5d1032ab08719e0906000338-360-202.jpg',
              scale: 2.0, //压缩比例
              repeat: ImageRepeat.repeatY, //repeat：XY重复; repeatX:X重复; repeatY:Y重复
            ),
            width: 400.0,
            height: 300.0,
            color: Colors.lightBlue,
          )
        ),
        
      ),  
    );
  }
}