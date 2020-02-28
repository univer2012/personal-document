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

  final List<BottomNavigationBarItem> bottomNavItems = [
    BottomNavigationBarItem(
      backgroundColor: Colors.blue,
      icon: Icon(Icons.home),
      title: Text('首页'),
    ),
    BottomNavigationBarItem(
      backgroundColor: Colors.green,
      icon: Icon(Icons.email),
      title: Text('邮件'),
    ),
    BottomNavigationBarItem(
      backgroundColor: Colors.amber,
      icon: Icon(Icons.alarm),
      title: Text('报警'),
    ),
    BottomNavigationBarItem(
      backgroundColor: Colors.red,
      icon: Icon(Icons.airplay),
      title: Text('投屏'),
      
    ),
  ];

  int currentIndex = 0;

  List<Widget> pages = List();
  @override
  void initState() {
    pages
    ..add(MainHomeScreen())
    ..add(MainEmailScreen())
    ..add(MainAlarmScreen())
    ..add(MainAirplayScreen());
    super.initState();
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
       body: pages[currentIndex],
       bottomNavigationBar: BottomNavigationBar(
         backgroundColor: Colors.lightGreen, //背景色
         selectedItemColor: Colors.red, //选中颜色
         unselectedItemColor: Colors.blueGrey,//未选中颜色
         items: bottomNavItems,
         onTap: (int index){
           setState(() {
             _changePage(index);
           });
         },
         currentIndex: currentIndex,
         type: BottomNavigationBarType.fixed,
         //type: BottomNavigationBarType.shifting,
         ///一般情况下，我们底部导航栏不会弄得这么花哨，
         ///所以一般都是使用fixed模式，此时，导航栏的图标和标题颜色会使用fixedColor指定的颜色，如果没有指定fixedColor，则使用默认的主题色primaryColor
         //fixedColor: Colors.red,
       ),
    );
  }

  /*切换页面*/
  void _changePage(int index) {
    /*如果点击的导航项不是当前项  切换 */
    if (index != currentIndex) {
      setState(() {
        currentIndex = index;
      });
    }
  }
}



