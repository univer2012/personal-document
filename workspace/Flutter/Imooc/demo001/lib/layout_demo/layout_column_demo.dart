import 'package:flutter/material.dart';

import './lay4_base_column.dart';
import './lay5_main_cross_column.dart';
import './lay6_horizontal_center_column.dart';

class LayoutColumnPage extends StatelessWidget {
  const LayoutColumnPage({Key key}) : super(key: key);

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
        title: Text('垂直布局Column'),
      ),
      body: ListView(
        children: <Widget>[
          RaisedButton(
            color: Colors.blue,
            child: Text('4Column基本用法',style: TextStyle(color: Colors.white),),
            onPressed: (){
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) {
                    return Lay4BaseColumnPage();
                  },
                  //fullscreenDialog: true,
                ),
              );
            }
          ),

          RaisedButton(
            color: Colors.blue,
            child: Text('5主轴和副轴的辨识',style: TextStyle(color: Colors.white),),
            onPressed: (){
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) {
                    return Lay5MainCrossColumnPage();
                  },
                  //fullscreenDialog: true,
                ),
              );
            }
          ),
          RaisedButton(
            color: Colors.blue,
            child: Text('6水平方向相对屏幕居中',style: TextStyle(color: Colors.white),),
            onPressed: (){
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) {
                    return Lay6HorCenterColumnPage();
                  },
                  //fullscreenDialog: true,
                ),
              );
            }
          ),
        ],
      ),
    );
  }
}