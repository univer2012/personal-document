import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:sgh_github_app_flutter/common/model/User.dart';
import 'package:sgh_github_app_flutter/common/redux/GSYState.dart';
import 'package:sgh_github_app_flutter/common/redux/UserRedux.dart';
import 'package:sgh_github_app_flutter/common/style/GSYStyle.dart';
import 'package:sgh_github_app_flutter/widget/GSYTabBarWidget.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return new GSYTabBarWidget(
      type: GSYTabBarWidget.BOTTOM_TAB,
      tabItems: <Widget>[
        new Tab(icon: new Icon(Icons.directions_car),),
        new Tab(icon: new Icon(Icons.directions_transit),),
        new Tab(icon: new Icon(Icons.directions_bike),),
      ],
      tabViews: <Widget>[
        new StoreBuilder<GSYState>(
          builder: (context, store) {
            new Future.delayed(const Duration(seconds: 2),(){//2秒后重新赋值
              User user = store.state.userInfo;
              user.login = 'new login';
              user.name = 'new name';
              store.dispatch(new UpdateUserAction(user));
            });
            return new Text(
              store.state.userInfo.login,
              style: Theme.of(context).textTheme.display1,
            );
          }
        ),
        new StoreConnector<GSYState, String>(
          converter: (store) => store.state.userInfo.name,
          builder: (context, count) {
            return new Text(
              count,
              style: Theme.of(context).textTheme.display1,
            );
          }
        ),
        new Icon(Icons.directions_bike),
      ],
      backgroundColor: GSYColors.primarySwatch,
      indicatorColor: Colors.white,
      title: 'Title',
    );
  }
}