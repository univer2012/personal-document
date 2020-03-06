import 'package:flutter/material.dart';
import 'package:sgh_github_app_flutter/common/style/GSYStyle.dart';
import 'package:sgh_github_app_flutter/page/DynamicPage.dart';
import 'package:sgh_github_app_flutter/page/MyPage.dart';
import 'package:sgh_github_app_flutter/page/TrendPage.dart';
import 'package:sgh_github_app_flutter/widget/GSYTabBarWidget.dart';

class HomePage extends StatelessWidget {

  static final String sName = "home";
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
        new DynamicPage(),
        new TrendPage(),
        new MyPage()
      ],
      backgroundColor: GSYColors.primarySwatch,
      indicatorColor: Colors.white,
      title: 'Title',
    );
  }
}