import 'package:flutter/material.dart';
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
        new Icon(Icons.directions_car),
        Icon(Icons.directions_transit),
        new Icon(Icons.directions_bike),
      ],
      backgroundColor: Colors.deepOrange,
      indicatorColor: Colors.white,
      title: 'Title',
    );
  }
}