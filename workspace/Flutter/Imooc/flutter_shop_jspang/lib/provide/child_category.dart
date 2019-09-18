import 'package:flutter/material.dart';
import '../model/category.dart';

//ChangeNotifier 的混入是不用管理听众
class ChildCategory with ChangeNotifier {
  List<BxMallSubDto> childCategoryList = [];

  getChildCategory(List<BxMallSubDto> list) {
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
}