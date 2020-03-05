import 'dart:async';

import 'package:flutter/material.dart';
import 'package:sgh_github_app_flutter/page/HomePage.dart';

class WelcomePage extends StatelessWidget {
  const WelcomePage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // 一秒以后偶将任务添加至event队列
    new Future.delayed(const Duration(seconds: 2), (){
      Navigator.of(context).pushReplacement(new MaterialPageRoute(builder: (context) {
        return new HomePage();
      }));
    });

    return Container(
      color: Colors.white,
      child: new Center(
        child: new Text(
          "李彦宏传闻辟谣",
          style: new TextStyle(
            color: Colors.black, 
            fontSize: 22.0,
          ),
        )
      ),
    );
  }
}