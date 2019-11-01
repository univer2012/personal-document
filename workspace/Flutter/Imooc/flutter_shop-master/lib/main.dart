import 'package:flutter/material.dart';
import 'package:amap_base/amap_base.dart';
// import 'package:amap_base_location/amap_base_location.dart';

void main() {
  //AMap.init('5e222b2725209dc503fae7b2f74f7cfa');
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(

        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: '高德地图测试'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  AMapController _controller;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: AMapView(
        onAMapViewCreated: (controller) {
          _controller = controller;
        },
        amapOptions: AMapOptions(
          compassEnabled: false,
          zoomControlsEnabled: true,
          logoPosition: LOGO_POSITION_BOTTOM_CENTER,
          camera: CameraPosition(
            target: LatLng(41.851827, 112.801637),
            zoom: 4,
          ),
        ),
      )
    );
  }
}







// import 'package:flutter/material.dart';
// import './pages/index_page.dart';
// /// ======= provide 类
// import 'package:provide/provide.dart';
// import './provide/child_category.dart';
// import './provide/category_goods_list.dart';
// import './provide/details_info.dart';
// import './provide/cart.dart';
// import './provide/currentIndex.dart';

// import 'package:fluro/fluro.dart';
// import './routers/routes.dart';
// import './routers/application.dart';




// import './provide/counter.dart';

// void main(){
//   var childCategory= ChildCategory();
//   var categoryGoodsListProvide= CategoryGoodsListProvide();
//   var detailsInfoProvide= DetailsInfoProvide();
//   var cartProvide = CartProvide();
//   var currentIndexProvide = CurrentIndexProvide();

//   var counter = Counter();
//   var providers  = Providers();
 
//   providers
//     ..provide(Provider<ChildCategory>.value(childCategory))
//     ..provide(Provider<CategoryGoodsListProvide>.value(categoryGoodsListProvide))
//     ..provide(Provider<DetailsInfoProvide>.value(detailsInfoProvide))
//     ..provide(Provider<CartProvide>.value(cartProvide))
//     ..provide(Provider<CurrentIndexProvide>.value(currentIndexProvide))
//     ..provide(Provider<Counter>.value(counter));

//   runApp(ProviderNode(child:MyApp(),providers:providers));
// }

// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {

//     final router = Router();
//     Routes.configureRoutes(router);
//     Application.router=router;
    

//     return Container(
      
//       child: MaterialApp(
//         title:'百姓生活+',
//         debugShowCheckedModeBanner: false,
//         onGenerateRoute: Application.router.generator,
//         theme: ThemeData(
//           primaryColor:Colors.pink,
//         ),
//         home:IndexPage()
//       ),
//     );
//   }
// }