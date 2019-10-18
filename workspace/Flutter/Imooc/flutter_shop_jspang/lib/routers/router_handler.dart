import 'package:flutter/material.dart';
import 'package:fluro/fluro.dart';
import '../pages/details_page.dart';

///Handler 相当于控制器的意思，或者叫操作器
Handler detailsHandler = Handler(
  handlerFunc: (BuildContext context, Map<String,List<String>> params) {
    String goodsId = params['id'].first;
    print('index>details goodsId is ${goodsId}');
    return DetailsPage(goodsId);
  }
);