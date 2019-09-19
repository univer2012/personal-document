import 'package:flutter/material.dart';
import '../model/categoryGoodsList.dart';

//ChangeNotifier 的混入是不用管理听众
class CategoryGoodsListProvide with ChangeNotifier {
  List<CategoryListData> goodsList = [];

  //点击大类时更换商品列表
  getGoodsList(List<CategoryListData> list) {

  }
}