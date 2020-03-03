import 'package:flutter/material.dart';

class Navi4BackWithParamsPage extends StatelessWidget {
  const Navi4BackWithParamsPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('要电话'),),
      body: Center(
        child: RouteButton(),
      ),
    );
  }
}

//跳转的Button
class RouteButton extends StatelessWidget {
  const RouteButton({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    _navigateToXiaoNiu(BuildContext context) async {
      final result = await Navigator.push(
        context, 
        MaterialPageRoute(builder: (context) => XiaoNiu())
      );
      Scaffold.of(context).showSnackBar(SnackBar(content: Text('$result')));
    }
    return RaisedButton(
      child: Text('找小妞'),
      onPressed: (){
        _navigateToXiaoNiu(context);
    });
  }
}


class XiaoNiu extends StatelessWidget {
  const XiaoNiu({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('我是小妞'),
      ),
      body: Center(
        child: Column(
          children: <Widget>[
            RaisedButton(
              child: Text('大长腿小妞'),
              onPressed: (){
                Navigator.pop(context, '大长腿:1511008888');
              }
            ),
            RaisedButton(
              child: Text('小蛮腰小妞'),
              onPressed: (){
                Navigator.pop(context, '大长腿:1511009999');
              }
            ),
          ],
        ),
      ),
    );
  }
}