import 'package:flutter/material.dart';

class GridViewPage extends StatelessWidget {
  const GridViewPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios),
          onPressed: (){
            Navigator.pop(context);
          },
        ),
        title: Text('GridView'),
      ),
      body: GridView(gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        mainAxisSpacing: 2.0, //上下间距
        crossAxisSpacing: 2.0, //左右间距
        childAspectRatio: 0.7,
        ),
        //padding: EdgeInsets.all(10),
        children: <Widget>[
          //new Image.network('http://img5.mtime.cn/mt/2018/10/22/104316.77318635_180X260X4.jpg', fit: BoxFit.cover),
            //new Image.network('http://img5.mtime.cn/mt/2018/10/10/112514.30587089_180X260X4.jpg', fit: BoxFit.cover),
            //new Image.network('http://img5.mtime.cn/mt/2018/11/13/093605.61422332_180X260X4.jpg', fit: BoxFit.cover),
            Image.asset('images/game1.jpg'),
            Image.asset('images/game2.png'),
            Image.asset('images/game3.jpg'),
            new Image.network('http://img5.mtime.cn/mt/2018/11/07/092515.55805319_180X260X4.jpg', fit: BoxFit.cover),
            new Image.network('http://img5.mtime.cn/mt/2018/11/21/090246.16772408_135X190X4.jpg', fit: BoxFit.cover),
            new Image.network('http://img5.mtime.cn/mt/2018/11/17/162028.94879602_135X190X4.jpg', fit: BoxFit.cover),
            new Image.network('http://img5.mtime.cn/mt/2018/11/19/165350.52237320_135X190X4.jpg', fit: BoxFit.cover),
            new Image.network('http://img5.mtime.cn/mt/2018/11/16/115256.24365160_180X260X4.jpg', fit: BoxFit.cover),
            new Image.network('http://img5.mtime.cn/mt/2018/11/20/141608.71613590_135X190X4.jpg', fit: BoxFit.cover),
        ],
      ),



      //========= demo1 start
      // body: GridView.count(
      //   padding: const EdgeInsets.all(20.0),
      //   crossAxisSpacing: 10.0,
      //   crossAxisCount: 3,
      //   children: <Widget>[
      //     const Text('I am Jspang'),
      //     const Text('I love Web'),
      //     const Text('jspang.com'),
      //     const Text('我喜欢玩游戏'),
      //     const Text('我喜欢看书'),
      //     const Text('我喜欢吃火锅'),
      //   ],
      // ),
      //========= demo1 end
    );
  }
}