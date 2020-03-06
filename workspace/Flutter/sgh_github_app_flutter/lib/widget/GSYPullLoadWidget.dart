import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:sgh_github_app_flutter/common/model/User.dart';
import 'package:sgh_github_app_flutter/common/redux/GSYState.dart';
import 'package:sgh_github_app_flutter/common/redux/UserRedux.dart';

class GSYPullLoadWidget extends StatefulWidget {
  final IndexedWidgetBuilder itemBuilder;

  final NotificationListenerCallback<Notification> onNotification;

  final RefreshCallback onRrefresh;

  GSYPullLoadWidgetControl control;
  
  GSYPullLoadWidget(this.control, this.itemBuilder, this.onRrefresh, this.onNotification);

  @override
  _GSYPullLoadWidgetState createState() => _GSYPullLoadWidgetState(this.control, this.itemBuilder, this.onRrefresh, this.onNotification);
}

class _GSYPullLoadWidgetState extends State<GSYPullLoadWidget> {
  final IndexedWidgetBuilder itemBuilder;

  final NotificationListenerCallback<Notification> onNotification;

  final RefreshCallback onRrefresh;

  GSYPullLoadWidgetControl control;

  _GSYPullLoadWidgetState(this.control, this.itemBuilder, this.onRrefresh, this.onNotification);

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
        return new NotificationListener(
          onNotification: onNotification,
          child: new RefreshIndicator(
            onRefresh: onRrefresh,
            child: new ListView.builder(
              physics: const AlwaysScrollableScrollPhysics(),
              itemBuilder: itemBuilder,
              itemCount: control.count,
            ), 
          )
        );
      }
    );
  }
}

class GSYPullLoadWidgetControl {
  int count = 5;
}
