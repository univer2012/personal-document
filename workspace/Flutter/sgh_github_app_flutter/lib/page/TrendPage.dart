
import 'package:flutter/material.dart';
import 'package:sgh_github_app_flutter/common/dao/ReposDao.dart';
import 'package:sgh_github_app_flutter/widget/GSYPullLoadWidget.dart';
import 'package:sgh_github_app_flutter/widget/ReposItem.dart';

class TrendPage extends StatefulWidget {
  TrendPage({Key key}) : super(key: key);

  @override
  _TrendPageState createState() => _TrendPageState();
}

class _TrendPageState extends State<TrendPage> {
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
    var res = await ReposDao.getTrendDao(since: 'daily');
    if (res != null && res.result && res.data.length > 0) {
      setState(() {
        pullLoadWidgetControl.dataList = res.data;
      });
    }
    setState(() {
      pullLoadWidgetControl.needLoadMore = false;
    });
    isLoading = false;
    return null;
  }

  Future<Null> _onLoadMore() async {
    return null;
  }

  _renderItem(ReposViewModel e) {
    return new ReposItem(e);
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (pullLoadWidgetControl.dataList.length == 0) {
      _handleRefresh();
    }
  }

  @override
  Widget build(BuildContext context) {
    return GSYPullLoadWidget(
      pullLoadWidgetControl, 
      (BuildContext context, int index) => _renderItem(pullLoadWidgetControl.dataList[index]), 
      _handleRefresh, 
      _onLoadMore
    );
  }
}

