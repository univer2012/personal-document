
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:sgh_github_app_flutter/common/dao/ReposDao.dart';
import 'package:sgh_github_app_flutter/common/redux/GSYState.dart';
import 'package:sgh_github_app_flutter/widget/ReposItem.dart';

class TrendPage extends StatefulWidget {
  TrendPage({Key key}) : super(key: key);

  @override
  _TrendPageState createState() => _TrendPageState();
}

class _TrendPageState extends State<TrendPage> {

  @override
  void didChangeDependencies() {
    ReposDao.getTrendDao();
    super.didChangeDependencies();
    
  }

  @override
  Widget build(BuildContext context) {
    return new ReposItem(new ReposViewModel());
  }
}

