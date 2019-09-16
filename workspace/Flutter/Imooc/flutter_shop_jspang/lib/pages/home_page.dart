import 'dart:io';

import 'package:flutter/material.dart';

import 'package:dio/dio.dart';
import '../config/httpHeaders.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  TextEditingController typeController = TextEditingController();
  String showText = "还没有请求数据";


  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
        appBar: AppBar(title: Text('请求远程数据'),),
        body: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              RaisedButton(
                onPressed:_jike,
                child: Text('请求数据'),
              ),
              Text(showText),
            ],
          ),
        ),
      ),
    );
  }

  void _jike() {
    print('开始向极客时间请求数据..........');
    getHttp().then((val){
      setState(() {
        showText = val['data'].toString();
      });
    });
  }

  Future getHttp() async {
    try{
      Response response;
      Dio dio = new Dio();
      dio.options.headers=httpHeaders;
      //response = await dio.get('https://time.geekbang.org/serv/v1/column/newAll');
      response = await dio.get('https://time.geekbang.org/serv/v1/column/topList');
      print(response);
      return response.data;
    }catch(e) {
      return print(e);
    }
  }

}