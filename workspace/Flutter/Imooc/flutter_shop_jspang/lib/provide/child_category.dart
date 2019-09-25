import 'package:flutter/material.dart';
import '../model/category.dart';

//ChangeNotifier 的混入是不用管理听众
class ChildCategory with ChangeNotifier {
  List<BxMallSubDto> childCategoryList = [];
  int childIndex = 0; //子类高亮索引
  String categoryId = '4'; //大类ID
  String subId = ''; //小类ID

  //点击大类时更换
  getChildCategory(List<BxMallSubDto> list, String id) {
    categoryId = id;
    childIndex = 0;
    subId = ''; //点击大类时，把子类ID清空

    BxMallSubDto all = BxMallSubDto();
    all.mallSubId = '00';
    all.mallCategoryId = '00';
    all.comments = 'null';
    all.mallSubName = '全部';

    childCategoryList = [all]; //把all加到开头
    childCategoryList.addAll(list);

    childCategoryList = list;
    notifyListeners();
  }

  //改变子类索引
  changeChildIndex(int index,String id) {
    //传递两个参数，使用新传递的参数给状态赋值
    childIndex = index;
    subId = id;
    notifyListeners();
  }
}