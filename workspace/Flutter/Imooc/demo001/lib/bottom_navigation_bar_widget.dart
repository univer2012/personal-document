import 'package:flutter/material.dart';

import './main_pages/main_home_screen.dart';
import './main_pages/main_airplay_screen.dart';
import './main_pages/main_alarm_screen.dart';
import './main_pages/main_email_screen.dart';

class BottomNavigationBarWidget extends StatefulWidget {
  BottomNavigationBarWidget({Key key}) : super(key: key);

  @override
  _BottomNavigationBarWidgetState createState() => _BottomNavigationBarWidgetState();
}

class _BottomNavigationBarWidgetState extends State<BottomNavigationBarWidget> {
  final _bottomNavigatorColor = Colors.blue;
  int _currentIndex = 0;

  List<Widget> list = List();
  @override
  void initState() {
    list
    ..add(MainHomeScreen())
    ..add(MainEmailScreen())
    ..add(MainAlarmScreen())
    ..add(MainAirplayScreen());
    super.initState();
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
       body: list[_currentIndex],
       bottomNavigationBar: BottomNavigationBar(
         items: [
           BottomNavigationBarItem(
              icon: Icon(
                Icons.home,
                color: _bottomNavigatorColor,
              ),
              title: Text(
                '首页',
                style: TextStyle(color: _bottomNavigatorColor),
              ),
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.email,
                color: _bottomNavigatorColor,
              ),
              title: Text(
                '邮件',
                style: TextStyle(color: _bottomNavigatorColor),
              ),
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.alarm,
                color: _bottomNavigatorColor,
              ),
              title: Text(
                '相册',
                style: TextStyle(color: _bottomNavigatorColor),
              ),
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.airplay,
                color: _bottomNavigatorColor,
              ),
              title: Text(
                '投屏',
                style: TextStyle(color: _bottomNavigatorColor),
              ),
            ),
         ],
         onTap: (int index){
           setState(() {
             _currentIndex = index;
           });
         },
         currentIndex: _currentIndex,
         type: BottomNavigationBarType.fixed,
       ),
    );
  }
}



