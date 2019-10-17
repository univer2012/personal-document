import 'package:flutter/material.dart';
import '../model/category.dart';

//ChangeNotifier 的混入是不用管理听众
class ChildCategory with ChangeNotifier {
  List<BxMallSubDto> childCategoryList = [];
  int childIndex = 0; //子类高亮索引
  String categoryId = '4'; //大类ID
  String subId = ''; //小类ID
  int page = 1;//列表页数，当改变大类或者小类时进行改变
  String noMoreText = '';//显示更多的标识

  //点击大类时更换
  getChildCategory(List<BxMallSubDto> list, String id) {
    categoryId = id;
    childIndex = 0;
    subId = ''; //点击大类时，把子类ID清空

    //-------------关键代码start
    page = 1;
    noMoreText = '';
    //-------------关键代码end

    BxMallSubDto all = BxMallSubDto();
    all.mallSubId = '00';
    all.mallCategoryId = '00';
    all.comments = 'null';
    all.mallSubName = '全部';

    print('list_length:${list.length}');
    childCategoryList = [all]; //把all加到开头
    childCategoryList.addAll(list);
    print('childCategoryList_length:${childCategoryList.length}');

    childCategoryList = list;
    notifyListeners();
  }

  //改变子类索引
  changeChildIndex(int index,String id) {
    //传递两个参数，使用新传递的参数给状态赋值
    childIndex = index;
    subId = id;
    //-------------关键代码start
    page = 1;
    noMoreText = ''; //显示更多的表示
    //-------------关键代码end
    notifyListeners();
  }

  //增加Page的 方法
  addPage(){
    page++;
    //print('page=${page}');
  }

  changeNoMore(String text) {
    noMoreText = text;
    notifyListeners();
  }
}