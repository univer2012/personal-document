
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:sgh_github_app_flutter/common/model/User.dart';
import 'package:sgh_github_app_flutter/common/redux/GSYState.dart';
import 'package:sgh_github_app_flutter/common/redux/UserRedux.dart';
import 'package:sgh_github_app_flutter/widget/EventItem.dart';
import 'package:sgh_github_app_flutter/widget/GSYPullLoadWidget.dart';

class DynamicPage extends StatefulWidget {
  DynamicPage({Key key}) : super(key: key);

  @override
  _DynamicPageState createState() => _DynamicPageState();
}

class _DynamicPageState extends State<DynamicPage> {
  final GSYPullLoadWidgetControl pullLoadWidgetControl = new GSYPullLoadWidgetControl();

Future<Null> _handleRefresh() async {
  setState(() {
    pullLoadWidgetControl.count = 5;
  });
  return null;
}

bool _onNotification<Notification>(Notification notify) {
  if (notify is! OverscrollNotification) {
    return true;
  }
  setState(() {
    pullLoadWidgetControl.count += 5;
  });
  return true;
}

  @override
  Widget build(BuildContext context) {
    return new StoreBuilder<GSYState>(
      builder: (context, store) {
        new Future.delayed(const Duration(seconds: 2), (){
          User user = store.state.userInfo;
          user.login = "new login";
          user.name = "new name";
          store.dispatch(new UpdateUserAction(user));
        });
        return GSYPullLoadWidget(
          pullLoadWidgetControl, 
          (BuildContext context, int index) => new EventItem(), 
          _handleRefresh, 
          _onNotification
        );
      }, 
      
    );
  }
}

