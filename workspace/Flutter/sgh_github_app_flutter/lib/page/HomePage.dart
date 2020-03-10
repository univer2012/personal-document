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
        new Tab(icon: new Icon(GSYIcons.MAIN_DT),),
        new Tab(icon: new Icon(GSYIcons.MAIN_QS),),
        new Tab(icon: new Icon(GSYIcons.MAIN_MY),),
      ],
      tabViews: <Widget>[
        new DynamicPage(),
        new TrendPage(),
        new MyPage()
      ],
      backgroundColor: GSYColors.primarySwatch,
      indicatorColor: Colors.white,
      title: GSYStrings.app_name,
    );
  }
}