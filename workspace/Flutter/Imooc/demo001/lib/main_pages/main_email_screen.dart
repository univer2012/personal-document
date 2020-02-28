import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

import '../email_page_demos/demo1/bottom_navigation_widget.dart';
import '../email_page_demos/demo2/bottom_appBar_demo.dart';
import '../email_page_demos/demo3/pages.dart';


class MainEmailScreen extends StatefulWidget {
  MainEmailScreen({Key key}) : super(key: key);

  @override
  _MainEmailScreenState createState() => _MainEmailScreenState();
}

class _MainEmailScreenState extends State<MainEmailScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('邮件'),
      ),
      body: Center(
          child: new ListView(
            children: <Widget>[
              RaisedButton(
                color: Colors.blue,
                child: Text('1底部导航栏制作',style: TextStyle(color: Colors.white),),
                onPressed: (){
                  navigateTo(context,BottomNavigationWidget());
                }
              ),
              RaisedButton(
                color: Colors.blue,
                child: Text('2不规则底部工具栏制作',style: TextStyle(color: Colors.white),),
                onPressed: (){
                  navigateTo(context,BottomAppBarDemo());
                }
              ),
              RaisedButton(
                color: Colors.blue,
                child: Text('3炫酷的路由动画',style: TextStyle(color: Colors.white),),
                onPressed: (){
                  navigateTo(context,FirstPage());
                }
              ),
                
            ],
          ),
        ),
    );
  }

  navigateTo(BuildContext context, Widget name) {
    Navigator.of(context, rootNavigator: true).push(
      CupertinoPageRoute(
        builder: (BuildContext context){
          return name;
        }
      )
    );
  }

}
