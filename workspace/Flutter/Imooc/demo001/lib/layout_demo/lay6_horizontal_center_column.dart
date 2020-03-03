import 'package:flutter/material.dart';

class Lay6HorCenterColumnPage extends StatelessWidget {
  const Lay6HorCenterColumnPage({Key key}) : super(key: key);

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
        title: Text('水平方向相对屏幕居中'),
      ),

      
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Center(child: Text('I am JSPang')),
            Expanded(child: Text('my website is jspang.com')),
            Center(child: Text('I love coding')),
          ],
        ),
      ),




      //========= demo1 start
      // body: Column(
      //   mainAxisAlignment: MainAxisAlignment.center,
      //   children: <Widget>[
      //     Center(child: Text('I am JSPang')),
      //     Center(child: Text('my website is jspang.com')),
      //     Center(child: Text('I love coding')),
      //   ],
      // ),
      //========= demo1 end
    );
  }
}