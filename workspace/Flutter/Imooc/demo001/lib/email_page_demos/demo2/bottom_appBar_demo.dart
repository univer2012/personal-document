import 'package:flutter/material.dart';
import 'each_view.dart';

class BottomAppBarDemo extends StatefulWidget {
  @override
  _BottomAppBarDemoState createState() => _BottomAppBarDemoState();
}



// ==================== 点击中间的「+」号按钮切换页面，不是push，导航栏不会隐藏 start
class _BottomAppBarDemoState extends State<BottomAppBarDemo> {

  List<Widget> _eachView; //创建视图数组
  int _index = 0;         //数组索引，通过改变索引值改变视图

  @override
  void initState() {
    super.initState();
    _eachView = List();
    _eachView
      ..add(EachView('Home'))
      ..add(EachView('New Page'))
      ..add(EachView('Me'));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _eachView[_index],
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          setState(() {
            _index = 1;
          });
        },
        tooltip: 'Increment',
        child: Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,

      bottomNavigationBar: BottomAppBar(
        color: Colors.lightBlue,
        shape: CircularNotchedRectangle(),
        child: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            IconButton(
              icon: Icon(Icons.home),
              color: Colors.white,
              onPressed: (){
                setState(() {
                  _index = 0;
                });
              },
            ),
            IconButton(
              icon: Icon(Icons.airport_shuttle),
              color: Colors.white,
              onPressed: (){
                setState(() {
                  _index = 2;
                });
              },
            ),
          ],
        ),
      ),
    );
  }
}
// ==================== 点击中间的「+」号按钮切换页面，不是push，导航栏不会隐藏 end










// ==================== 点击中间的「+」号按钮，是push进另一个页面，导航栏会隐藏 start
// class _BottomAppBarDemoState extends State<BottomAppBarDemo> {

//   List<Widget> _eachView; //创建视图数组
//   int _index = 0;         //数组索引，通过改变索引值改变视图

//   @override
//   void initState() {
//     super.initState();
//     _eachView = List();
//     _eachView
//       ..add(EachView('Home'))
//       ..add(EachView('Me'));
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: _eachView[_index],
//       floatingActionButton: FloatingActionButton(
//         onPressed: (){
//           Navigator.of(context).push(
//             MaterialPageRoute(
//               builder: (BuildContext context){
//                 return EachView('New Page');
//               }
//             )
//           );
//         },
//         tooltip: 'Increment',
//         child: Icon(
//           Icons.add,
//           color: Colors.white,
//         ),
//       ),
//       floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,

//       bottomNavigationBar: BottomAppBar(
//         color: Colors.lightBlue,
//         shape: CircularNotchedRectangle(),
//         child: Row(
//           mainAxisSize: MainAxisSize.max,
//           mainAxisAlignment: MainAxisAlignment.spaceAround,
//           children: <Widget>[
//             IconButton(
//               icon: Icon(Icons.home),
//               color: Colors.white,
//               onPressed: (){
//                 setState(() {
//                   _index = 0;
//                 });
//               },
//             ),
//             IconButton(
//               icon: Icon(Icons.airport_shuttle),
//               color: Colors.white,
//               onPressed: (){
//                 setState(() {
//                   _index = 1;
//                 });
//               },
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
// ==================== 点击中间的「+」号按钮，是push进另一个页面，导航栏会隐藏 end