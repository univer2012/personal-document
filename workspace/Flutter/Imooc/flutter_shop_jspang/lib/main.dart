import 'package:flutter/material.dart';
import './pages/index_page.dart';
/// ======= provide 类
import 'package:provide/provide.dart';
import './provide/counter.dart';
import './provide/child_category.dart';
import './provide/category_goods_list.dart';
import './provide/details_info.dart';

import 'package:fluro/fluro.dart';
import './routers/routers.dart';
import './routers/application.dart';

void main() {
  var counter = Counter();
  var childCategory = ChildCategory();
  var categorygoodsListProvide = CategoryGoodsListProvide();
  var detailsInfoProvide = DetailsInfoProvide();

  var providers = Providers();
  


  providers
  ..provide(Provider<Counter>.value(counter))
  ..provide(Provider<CategoryGoodsListProvide>.value
  (categorygoodsListProvide))
  ..provide(Provider<DetailsInfoProvide>.value
  (detailsInfoProvide))
  ..provide(Provider<ChildCategory>.value(childCategory));//进行依赖

  runApp(ProviderNode(child: MyApp(), providers: providers));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    
    final router = Router();
    Routes.configureRoutes(router);
    Application.router = router;

    return Container(
      child: MaterialApp(
        title: '百姓生活+',
        onGenerateRoute: Application.router.generator,
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.pink,
        ),
        home: IndexPage(),
      ),
    );
  }
}