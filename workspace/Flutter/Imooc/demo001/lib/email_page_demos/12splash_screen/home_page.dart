import 'package:flutter/material.dart';

class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('首页'),
        leading: IconButton(
          icon: Icon(Icons.navigate_before),
          onPressed: (){
            Navigator.pop(context);
          },
        )
      ),
      body: Center(
        child: Text('我是首页'),
      ),
    );
  }
}