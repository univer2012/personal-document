import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

///========= demo 文件
import '../home_page_demos/demo/text_demo.dart';
import '../home_page_demos/demo/container_demo.dart';
import '../home_page_demos/demo/image_demo.dart';
import '../home_page_demos/demo/listView_demo.dart';
import '../home_page_demos/demo/dynamic_listview_demo.dart';
import '../home_page_demos/demo/gridview_demo.dart';

//========= 布局 demo
import '../home_page_demos/layout_demo/layout_row_demo.dart';
import '../home_page_demos/layout_demo/layout_column_demo.dart';
import '../home_page_demos/layout_demo/layout_stack_demo.dart';
import '../home_page_demos/layout_demo/layout_stack_positioned_demo.dart';
import '../home_page_demos/layout_demo/layout_card_component_demo.dart';

//========= 导航与其他
import '../navigator_demo/navi1_common_demo.dart';
import '../navigator_demo/navi2_params_demo.dart';
import '../navigator_demo/navi4_back_with_params_demo.dart';



class MainHomeScreen extends StatefulWidget {
  final String title;
  MainHomeScreen({Key key, this.title}) : super(key: key);

  @override
  _MainHomeScreenState createState() => _MainHomeScreenState();
}

class _MainHomeScreenState extends State<MainHomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Demo'),
      ),
       body: Center(
           child: new ListView(
             children: <Widget>[
               RaisedButton(
                 color: Colors.blue,
                 child: Text('Text Demo',style: TextStyle(color: Colors.white),),
                 onPressed: (){
                   navigateTo(TextPage());
                 }
                ),
                RaisedButton(
                 color: Colors.blue,
                 child: Text('Container Demo',style: TextStyle(color: Colors.white),),
                 onPressed: (){
                   navigateTo(ContainerPage());
                 }
                ),
                RaisedButton(
                 color: Colors.blue,
                 child: Text('Image Demo',style: TextStyle(color: Colors.white),),
                 onPressed: (){
                   navigateTo(ImagePage());
                 }
                ),
                RaisedButton(
                 color: Colors.blue,
                 child: Text('ListView Demo',style: TextStyle(color: Colors.white),),
                 onPressed: (){
                   navigateTo(ListViewPage());
                 }
                ),
                RaisedButton(
                 color: Colors.blue,
                 child: Text('动态ListView Demo',style: TextStyle(color: Colors.white),),
                 onPressed: (){
                   navigateTo(DynamicListViewPage(
                     items:new List<String>.generate(1000, (i) => "Item $i"))
                    );
                 }
                ),
                RaisedButton(
                 color: Colors.blue,
                 child: Text('GridView Demo',style: TextStyle(color: Colors.white),),
                 onPressed: (){
                   navigateTo(GridViewPage());
                 }
                ),
                RaisedButton(
                 color: Colors.blue,
                 child: Text('1水平布局Row Demo',style: TextStyle(color: Colors.white),),
                 onPressed: (){
                   navigateTo(LayoutRowPage());
                 }
                ),
                RaisedButton(
                 color: Colors.blue,
                 child: Text('2垂直布局Column Demo',style: TextStyle(color: Colors.white),),
                 onPressed: (){
                   navigateTo(LayoutColumnPage());
                 }
                ),
                RaisedButton(
                 color: Colors.blue,
                 child: Text('3Stack层叠布局 Demo',style: TextStyle(color: Colors.white),),
                 onPressed: (){
                   navigateTo(LayoutStackPage());
                 }
                ),
                RaisedButton(
                 color: Colors.blue,
                 child: Text('4Stack的Positioned属性 Demo',style: TextStyle(color: Colors.white),),
                 onPressed: (){
                   navigateTo(LayoutStackPositionedPage());
                 }
                ),

                RaisedButton(
                 color: Colors.blue,
                 child: Text('5卡片组件布局',style: TextStyle(color: Colors.white),),
                 onPressed: (){
                   navigateTo(LayoutCardComponentPage());
                 }
                ),

                RaisedButton(
                 color: Colors.blue,
                 child: Text('1一般页面导航和返回',style: TextStyle(color: Colors.white),),
                 onPressed: (){
                   navigateTo(Navi1CommonPage());
                 }
                ),
                RaisedButton(
                 color: Colors.blue,
                 child: Text('2导航参数的传递和接收',style: TextStyle(color: Colors.white),),
                 onPressed: (){
                   navigateTo(Navi2ParamsPage(
                      products: List.generate(20, 
                        (i)=>Product('商品 $i', '这是一个商品详情，编号为：$i') 
                      )
                    )
                   );
                 }
                ),
                RaisedButton(
                 color: Colors.blue,
                 child: Text('4页面跳转并返回数据',style: TextStyle(color: Colors.white),),
                 onPressed: (){
                   navigateTo(Navi4BackWithParamsPage());
                 }
                ),
             ],
           ),
         ),
    );
  }

  navigateTo(name) {

    Navigator.of(context, rootNavigator: true).push(
      CupertinoPageRoute(
        builder: (BuildContext context){
          return name;
        }
      )
    );
  }


}