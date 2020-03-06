import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:sgh_github_app_flutter/common/dao/UserDao.dart';
import 'package:sgh_github_app_flutter/common/redux/GSYState.dart';
import 'package:sgh_github_app_flutter/common/utils/NavigatorUtils.dart';
import 'package:redux/redux.dart';

class WelcomePage extends StatelessWidget {
  static final String sName = "/";

  const WelcomePage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    Store<GSYState> store = StoreProvider.of(context);
    new Future.delayed(const Duration(seconds: 2), (){
      UserDao.initUserInfo(store).then((res){
        if (res != null && res.result) {
          NavigatorUtils.goHome(context);
        } else {
          NavigatorUtils.goLogin(context);
        }
      });
    });

    return StoreBuilder<GSYState>(
      builder: (context, store) {
        return new Container(
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
    );
  }
}