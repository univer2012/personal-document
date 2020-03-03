import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

import '../email_page_demos/demo1/bottom_navigation_widget.dart';
import '../email_page_demos/demo2/bottom_appBar_demo.dart';
import '../email_page_demos/demo3/pages.dart';
import '../email_page_demos/demo4/frosted_glass_demo.dart';
import '../email_page_demos/demo5/keep_alive_demo.dart';
import '../email_page_demos/demo6/keep_alive_demo2.dart';
import '../email_page_demos/demo7/search_bar_demo.dart';
import '../email_page_demos/8warp_waterfall/warp_demo.dart';
import '../email_page_demos/9expansion_tile/expansion_tile.dart';
import '../email_page_demos/10expansion_panel_list/expansion_panel_list.dart';
import '../email_page_demos/11bessel_curve/custom_clipper.dart';
import '../email_page_demos/12splash_screen/splash_screen.dart';
import '../email_page_demos/13slip_right_back/right_back_demo.dart';
import '../email_page_demos/14tool_tips/tool_tips_demo.dart';
import '../email_page_demos/15draggable_widget/draggable_demo.dart';

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
              RaisedButton(
                color: Colors.blue,
                child: Text('4毛玻璃效果的制作',style: TextStyle(color: Colors.white),),
                onPressed: (){
                  navigateTo(context,FrostedGlassDemo());
                }
              ),
              RaisedButton(
                color: Colors.blue,
                child: Text('5保持页面状态1',style: TextStyle(color: Colors.white),),
                onPressed: (){
                  navigateTo(context,KeepAliveDemo());
                }
              ),
              RaisedButton(
                color: Colors.blue,
                child: Text('6保持页面状态2',style: TextStyle(color: Colors.white),),
                onPressed: (){
                  navigateTo(context,KeepAliveDemo2());
                }
              ),
              RaisedButton(
                color: Colors.blue,
                child: Text('7一个不简单的搜索条',style: TextStyle(color: Colors.white),),
                onPressed: (){
                  navigateTo(context,SearchBarDemo());
                }
              ),
              RaisedButton(
                color: Colors.blue,
                child: Text('8流式布局_模拟添加照片效果',style: TextStyle(color: Colors.white),),
                onPressed: (){
                  navigateTo(context,WarpDemo());
                }
              ),
              RaisedButton(
                color: Colors.blue,
                child: Text('9展开闭合',style: TextStyle(color: Colors.white),),
                onPressed: (){
                  navigateTo(context,ExpansionTileDemo());
                }
              ),
              RaisedButton(
                color: Colors.blue,
                child: Text('10展开闭合列表',style: TextStyle(color: Colors.white),),
                onPressed: (){
                  navigateTo(context,ExpansionPanelListDemo());
                }
              ),
              RaisedButton(
                color: Colors.blue,
                child: Text('11贝塞尔曲线切割',style: TextStyle(color: Colors.white),),
                onPressed: (){
                  navigateTo(context,BesselCurveDemo());
                }
              ),
              RaisedButton(
                color: Colors.blue,
                child: Text('12打开应用的闪屏动画',style: TextStyle(color: Colors.white),),
                onPressed: (){
                  navigateTo(context,SplashScreen());
                }
              ),
              RaisedButton(
                color: Colors.blue,
                child: Text('13右滑返回上一页',style: TextStyle(color: Colors.white),),
                onPressed: (){
                  navigateTo(context,RightBackDemo());
                }
              ),
              RaisedButton(
                color: Colors.blue,
                child: Text('14Tooltip控件案例',style: TextStyle(color: Colors.white),),
                onPressed: (){
                  navigateTo(context,ToolTipDemo());
                }
              ),
              RaisedButton(
                color: Colors.blue,
                child: Text('15Draggable控件案例',style: TextStyle(color: Colors.white),),
                onPressed: (){
                  navigateTo(context,DraggableDemo());
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
