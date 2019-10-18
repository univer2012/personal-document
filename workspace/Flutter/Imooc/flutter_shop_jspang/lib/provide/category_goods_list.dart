import 'package:flutter/material.dart';
import '../model/categoryGoodsList.dart';

//ChangeNotifier 的混入是不用管理听众
class CategoryGoodsListProvide with ChangeNotifier {
  List<CategoryListData> goodsList = [];

  //点击左边大类时更换商品列表
  getGoodsList(List<CategoryListData> list) {
    print("before_goodsList_length=${goodsList.length}");
    goodsList = list;
    print("after_goodsList_length=${goodsList.length}");
    notifyListeners();
  }

  getMoreList(List<CategoryListData> list) {
    goodsList.addAll(list);
    print('goodsList_length = ${goodsList.length}');
    notifyListeners();
  }

}