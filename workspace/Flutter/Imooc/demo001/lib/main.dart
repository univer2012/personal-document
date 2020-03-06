import 'package:demo001/home_page_demos/redux/d2003count_state.dart';
import 'package:flutter/material.dart';

import 'bottom_navigation_bar_widget.dart';

import 'home_page_demos/redux/d2003count_state.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';


void main() => runApp(MyApp());


double screenWidth;

class MyApp extends StatelessWidget {
  final Store<CountState> store = new Store<CountState>(reducer,initialState: CountState.initState());

  MyApp({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StoreProvider(
      store: store, 
      child: new MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: BottomNavigationBarWidget(),
      )
    );
  }
}


//======================================= 直接用routes来路由页面的代码 start
// import 'package:flutter/material.dart';

// ///========= demo 文件
// import './demo/text_demo.dart';
// import './demo/container_demo.dart';
// import './demo/image_demo.dart';
// import './demo/listView_demo.dart';
// import './demo/dynamic_listview_demo.dart';
// import './demo/gridview_demo.dart';

// //========= 布局 demo
// import './layout_demo/layout_row_demo.dart';
// import './layout_demo/layout_column_demo.dart';
// import './layout_demo/layout_stack_demo.dart';
// import './layout_demo/layout_stack_positioned_demo.dart';
// import './layout_demo/layout_card_component_demo.dart';

// //========= 导航与其他
// import './navigator_demo/navi1_common_demo.dart';
// import './navigator_demo/navi2_params_demo.dart';
// import './navigator_demo/navi4_back_with_params_demo.dart';

// void main() => runApp(MyApp());

// double screenWidth;

// class MyApp extends StatelessWidget {
//   const MyApp({Key key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       debugShowCheckedModeBanner: false,
//       title: 'Flutter Demo',
//       theme: ThemeData(
//         primarySwatch: Colors.blue,
//       ),
//       home: MyHomePage(title: 'Flutter Demo Home Page'),
//       routes: {
//         'TextDemo': (context) => TextPage(),
//         'ContainerDemo': (context) => ContainerPage(),
//         'ImageDemo': (context) => ImagePage(),
//         'ListViewDemo': (context) => ListViewPage(),
//         'DynamicListViewDemo': (context) => DynamicListViewPage(items:new List<String>.generate(1000, (i) => "Item $i")),
//         'GridViewDemo': (context) => GridViewPage(),
//         'LayoutRowDemo': (context) => LayoutRowPage(),
//         'LayoutColumnDemo': (context) => LayoutColumnPage(),
//         'LayoutStackDemo': (context) => LayoutStackPage(),
//         'LayoutStackPositionedDemo': (context) => LayoutStackPositionedPage(),
//         'LayoutCardComponentDemo': (context) => LayoutCardComponentPage(),
//         'CommonNavigatorDemo': (context) => Navi1CommonPage(),
//         'NavigatorParamsDemo': (context) => Navi2ParamsPage(
//           products: List.generate(20, 
//             (i)=>Product('商品 $i', '这是一个商品详情，编号为：$i') 
//           )
//         ),
//         'NaviBackWithParamsDemo': (context) => Navi4BackWithParamsPage(),
//       },
//     );
//   }
// }

// class MyHomePage extends StatefulWidget {
//   final String title;
//   MyHomePage({Key key, this.title}) : super(key: key);

//   @override
//   _MyHomePageState createState() => _MyHomePageState();
// }

// class _MyHomePageState extends State<MyHomePage> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         centerTitle: true,
//         title: Text('Demo'),
//       ),
//        body: SafeArea(
//          child: Center(
//            child: new ListView(
//              children: <Widget>[
//                RaisedButton(
//                  color: Colors.blue,
//                  child: Text('Text Demo',style: TextStyle(color: Colors.white),),
//                  onPressed: (){
//                    navigateTo('TextDemo');
//                  }
//                 ),
//                 RaisedButton(
//                  color: Colors.blue,
//                  child: Text('Container Demo',style: TextStyle(color: Colors.white),),
//                  onPressed: (){
//                    navigateTo('ContainerDemo');
//                  }
//                 ),
//                 RaisedButton(
//                  color: Colors.blue,
//                  child: Text('Image Demo',style: TextStyle(color: Colors.white),),
//                  onPressed: (){
//                    navigateTo('ImageDemo');
//                  }
//                 ),
//                 RaisedButton(
//                  color: Colors.blue,
//                  child: Text('ListView Demo',style: TextStyle(color: Colors.white),),
//                  onPressed: (){
//                    navigateTo('ListViewDemo');
//                  }
//                 ),
//                 RaisedButton(
//                  color: Colors.blue,
//                  child: Text('动态ListView Demo',style: TextStyle(color: Colors.white),),
//                  onPressed: (){
//                    navigateTo('DynamicListViewDemo');
//                  }
//                 ),
//                 RaisedButton(
//                  color: Colors.blue,
//                  child: Text('GridView Demo',style: TextStyle(color: Colors.white),),
//                  onPressed: (){
//                    navigateTo('GridViewDemo');
//                  }
//                 ),
//                 RaisedButton(
//                  color: Colors.blue,
//                  child: Text('1水平布局Row Demo',style: TextStyle(color: Colors.white),),
//                  onPressed: (){
//                    navigateTo('LayoutRowDemo');
//                  }
//                 ),
//                 RaisedButton(
//                  color: Colors.blue,
//                  child: Text('2垂直布局Column Demo',style: TextStyle(color: Colors.white),),
//                  onPressed: (){
//                    navigateTo('LayoutColumnDemo');
//                  }
//                 ),
//                 RaisedButton(
//                  color: Colors.blue,
//                  child: Text('3Stack层叠布局 Demo',style: TextStyle(color: Colors.white),),
//                  onPressed: (){
//                    navigateTo('LayoutStackDemo');
//                  }
//                 ),
//                 RaisedButton(
//                  color: Colors.blue,
//                  child: Text('4Stack的Positioned属性 Demo',style: TextStyle(color: Colors.white),),
//                  onPressed: (){
//                    navigateTo('LayoutStackPositionedDemo');
//                  }
//                 ),

//                 RaisedButton(
//                  color: Colors.blue,
//                  child: Text('5卡片组件布局',style: TextStyle(color: Colors.white),),
//                  onPressed: (){
//                    navigateTo('LayoutCardComponentDemo');
//                  }
//                 ),

//                 RaisedButton(
//                  color: Colors.blue,
//                  child: Text('1一般页面导航和返回',style: TextStyle(color: Colors.white),),
//                  onPressed: (){
//                    navigateTo('CommonNavigatorDemo');
//                  }
//                 ),
//                 RaisedButton(
//                  color: Colors.blue,
//                  child: Text('2导航参数的传递和接收',style: TextStyle(color: Colors.white),),
//                  onPressed: (){
//                    navigateTo('NavigatorParamsDemo');
//                  }
//                 ),
//                 RaisedButton(
//                  color: Colors.blue,
//                  child: Text('4页面跳转并返回数据',style: TextStyle(color: Colors.white),),
//                  onPressed: (){
//                    navigateTo('NaviBackWithParamsDemo');
//                  }
//                 ),
//              ],
//            ),
//          ),
//         ),
//     );
//   }

//   navigateTo(name) {
//     Navigator.of(context).pushNamed(name);
//   }


// }
//======================================= 直接用routes来路由页面的代码 end



