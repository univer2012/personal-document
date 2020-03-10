
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:sgh_github_app_flutter/common/config/Config.dart';
import 'package:sgh_github_app_flutter/common/dao/EventDao.dart';
import 'package:sgh_github_app_flutter/common/redux/GSYState.dart';
import 'package:sgh_github_app_flutter/widget/EventItem.dart';
import 'package:sgh_github_app_flutter/widget/GSYPullLoadWidget.dart';
import 'package:redux/redux.dart';

/**
 * 动态
 */
class DynamicPage extends StatefulWidget {
  DynamicPage({Key key}) : super(key: key);

  @override
  _DynamicPageState createState() => _DynamicPageState();
}

class _DynamicPageState extends State<DynamicPage> {
  bool isLoading = false;

  int page = 1;

  final List dataList = new List();

  final GSYPullLoadWidgetControl pullLoadWidgetControl = new GSYPullLoadWidgetControl();

Future<Null> _handleRefresh() async {
  if (isLoading) {
    return null;
  }
  isLoading = true;
  page = 1;
  var result = await EventDao.getEventReceived(_getStore(), page: page);
  setState(() {
    pullLoadWidgetControl.needLoadMore = (result != null && result.length == Config.PAGE_SIZE);
  });
  isLoading = false;
  return null;
}

Future<Null> _onLoadMore() async {
  if (isLoading) {
    return null;
  }
  isLoading = true;
  page ++;
  var result = await EventDao.getEventReceived(_getStore(), page: page);
  setState(() {
    pullLoadWidgetControl.needLoadMore = (result != null);
  });
  isLoading = false;
  return null;
}

_renderEventItem(EventViewModel e) {
  return new EventItem(e);
}

Store<GSYState> _getStore() {
  return StoreProvider.of(context);
}

@override
  void initState() {
    super.initState();
  }

@override
  void didChangeDependencies() {
    pullLoadWidgetControl.dataList = _getStore().state.eventList;
    if (pullLoadWidgetControl.dataList.length == 0) {
      _handleRefresh();
    }
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return new StoreBuilder<GSYState>(
      builder: (context, store) {
        
        return GSYPullLoadWidget(
          pullLoadWidgetControl, 
          (BuildContext context, int index) => _renderEventItem(pullLoadWidgetControl.dataList[index]), 
          _handleRefresh, 
          _onLoadMore
        );
      }, 
      
    );
  }
}

