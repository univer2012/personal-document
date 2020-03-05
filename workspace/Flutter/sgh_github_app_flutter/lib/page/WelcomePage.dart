import 'dart:async';

import 'package:flutter/material.dart';
import 'package:sgh_github_app_flutter/common/dao/UserDao.dart';
import 'package:sgh_github_app_flutter/page/HomePage.dart';
import 'package:sgh_github_app_flutter/page/LoginPage.dart';

class WelcomePage extends StatelessWidget {
  const WelcomePage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    toNext(res) {
      Widget widget;
      if (res != null && res.result) {
        widget = new HomePage();
      } else {
        widget = new LoginPage();
      }
      Navigator.of(context).pushReplacement(new MaterialPageRoute(builder: (context) {
        //判断是去登录还是主页
        return widget;
      }));
    }

    
    new Future.delayed(const Duration(seconds: 2), (){
      UserDao.initUserInfo().then((res) {
        print('Fffffffffffff');
        print(res);
        toNext(res);
      });
    });

    return Container(
      color: Colors.white,
      child: new Center(
        child: new Text(
          "Welcome",
          style: new TextStyle(
            color: Colors.black, 
            fontSize: 22.0,
          ),
        )
      ),
    );
  }
}