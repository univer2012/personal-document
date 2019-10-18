import 'package:flutter/material.dart';
import './pages/index_page.dart';

import 'package:provide/provide.dart';
import './provide/counter.dart';
import './provide/child_category.dart';
import './provide/category_goods_list.dart';
import 'package:fluro/fluro.dart';

void main() {
  var counter = Counter();
  var childCategory = ChildCategory();
  var categorygoodsListProvide = CategoryGoodsListProvide();

  var providers = Providers();
  providers
  ..provide(Provider<Counter>.value(counter))
  ..provide(Provider<CategoryGoodsListProvide>.value(categorygoodsListProvide))
  ..provide(Provider<ChildCategory>.value(childCategory));//进行依赖

  runApp(ProviderNode(child: MyApp(), providers: providers));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: MaterialApp(
        title: '百姓生活+',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.pink,
        ),
        home: IndexPage(),
      ),
    );
  }
}