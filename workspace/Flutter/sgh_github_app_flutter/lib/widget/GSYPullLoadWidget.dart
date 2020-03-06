import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:sgh_github_app_flutter/common/model/User.dart';
import 'package:sgh_github_app_flutter/common/redux/GSYState.dart';
import 'package:sgh_github_app_flutter/common/redux/UserRedux.dart';
import 'package:sgh_github_app_flutter/common/style/GSYStyle.dart';

class GSYPullLoadWidget extends StatefulWidget {
  final IndexedWidgetBuilder itemBuilder;

  final RefreshCallback onLoadMore;

  final RefreshCallback onRrefresh;

  GSYPullLoadWidgetControl control;
  
  GSYPullLoadWidget(this.control, this.itemBuilder, this.onRrefresh, this.onLoadMore);

  @override
  _GSYPullLoadWidgetState createState() => _GSYPullLoadWidgetState(this.control, this.itemBuilder, this.onRrefresh, this.onLoadMore);
}

class _GSYPullLoadWidgetState extends State<GSYPullLoadWidget> {
  final IndexedWidgetBuilder itemBuilder;

  final RefreshCallback onLoadMore;

  final RefreshCallback onRrefresh;

  GSYPullLoadWidgetControl control;

  _GSYPullLoadWidgetState(this.control, this.itemBuilder, this.onRrefresh, this.onLoadMore);

  final ScrollController _scrollController = new ScrollController();

  @override
  void initState() {
    _scrollController.addListener((){
      if (_scrollController.position.pixels == _scrollController.position.maxScrollExtent) {
        if (this.onLoadMore != null && this.control.needLoadMore) {
          this.onLoadMore();
        }
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return new RefreshIndicator(
      onRefresh: onRrefresh,
      child: new ListView.builder(
        physics: const AlwaysScrollableScrollPhysics(),
        itemBuilder: (context, index) {
          if (index == control.dataList.length && control.dataList.length != 0) {
            return _buildProgressIndicator(); 
          } else {
            return itemBuilder(context, index);
          }
        },
        itemCount: (control.dataList.length > 0) ? control.dataList.length + 1 : control.dataList.length,
        controller: _scrollController,
      ), 
    );
  }


  Widget _buildProgressIndicator() {
    Widget bottomWidget = (control.needLoadMore) ? new CircularProgressIndicator() : new Text(GSYStrings.load_more_not);
    print(bottomWidget);
    return new Padding(
      padding: const EdgeInsets.all(20.0),
      child: new Center(
        child: bottomWidget,
      ),
    );
  }

}

class GSYPullLoadWidgetControl {
  List dataList = new List();
  bool needLoadMore = true;
}
