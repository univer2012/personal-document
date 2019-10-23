import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:provide/provide.dart';
import '../provide/cart.dart';

class CartPage extends StatefulWidget {
  @override
  _CartPageState createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  List<String> testList = [];
  @override
  Widget build(BuildContext context) {
    _show();  //每次进入前进行显示
    return Scaffold(
      appBar: AppBar(
        title: Text('购物车'),
      ),
      body:FutureBuilder(
        future: _getCartInfo(context),
        builder: (context, snapshot) {
          List cartList = Provide.value<CartProvide>(context).cartList;
          if (snapshot.hasData) {
            return ListView.builder(
              itemCount: cartList.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(cartList[index].goodsName),
                );
              },
            );
          } else {
            return Text('正在加载');
          }
        },
      ),
    );
  }

  Future<String> _getCartInfo(BuildContext context) async {
    await Provide.value<CartProvide>(context).getCartInfo();
  }

  //增加方法
  void _add() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String temp = "技术胖是最胖的！";
    testList.add(temp);
    prefs.setStringList('testInfo', testList);  //增
    _show();
  }

  //显示方法
  void _show() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      if (prefs.getStringList('testInfo') != null) {
        testList = prefs.getStringList('testInfo'); //获取
      }
    });
  }

  void _clear() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    //prefs.clear();  //全部清空
    prefs.remove('testInfo'); //删除key键 //删
    setState(() {
      testList = [];
    });
  }

}