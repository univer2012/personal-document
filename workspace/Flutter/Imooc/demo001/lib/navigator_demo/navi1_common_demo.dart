import 'package:flutter/material.dart';

class Navi1CommonPage extends StatelessWidget {
  const Navi1CommonPage({Key key}) : super(key: key);

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
        title: Text('Stack的Positioned属性-层叠布局'),
      ),
      body: Center(
        child: RaisedButton(
          child: Text('查看商品详情页面'),
          onPressed: (){
            Navigator.push(context, new MaterialPageRoute(builder: (context) => new SecondScreen() ) );
        }),
      ),
    );
  }
}

class SecondScreen extends StatelessWidget {
  const SecondScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('技术胖商品详情页'),
      ),
      body: Center(
        child: RaisedButton(
          child: Text('返回'),
          onPressed: (){
            Navigator.pop(context);
        }),
      ),
    );
  }
}