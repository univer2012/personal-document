import 'package:flutter/material.dart';
import '../service/service_method.dart';
import 'dart:convert';

class CategoryPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    _getCategory();
    return Scaffold(
      body: Center(
        child: Text('分类首页'),
      ),
    );
  }
  void _getCategory()async{
    await request('getCategory').then((val){
      var data = json.decode(val.toString());
      print(data);
    });
  }
}