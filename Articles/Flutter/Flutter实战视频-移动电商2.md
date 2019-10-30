## [#](https://jspang.com/posts/2019/03/01/flutter-shop.html#第60节：购物车-商品选中功能制作) 第60节：购物车_商品选中功能制作

在购物车里是有选择和取消选择，还有全选的功能按钮的。当我们选择时，价格和数量都是跟着自动计算的，列表也是跟着刷新的。这节课主要完成单选和全选按钮的交互效果。

###  制作商品单选按钮的交效果

这些业务逻辑代码，当然需要写到`Provide`中，打开`lib/provide/cart.dart`文件。新建一个`changeCheckState`方法：

```dart
  changeCheckState(CartInfoMode cartItem) async{
     SharedPreferences prefs = await SharedPreferences.getInstance();
     cartString=prefs.getString('cartInfo');  //得到持久化的字符串
     List<Map> tempList= (json.decode(cartString.toString()) as List).cast(); //声明临时List，用于循环，找到修改项的索引
     int tempIndex =0;  //循环使用索引
     int changeIndex=0; //需要修改的索引
     tempList.forEach((item){
         
         if(item['goodsId']==cartItem.goodsId){
          //找到索引进行复制
          changeIndex=tempIndex;
         }
         tempIndex++;
     });
     tempList[changeIndex]=cartItem.toJson(); //把对象变成Map值
     cartString= json.encode(tempList).toString(); //变成字符串
     prefs.setString('cartInfo', cartString);//进行持久化
     await getCartInfo();  //重新读取列表
    
  }
```

业务逻辑写完后到到UI层进行修改，打开`lib/pages/cart_page/cart_item.dart`文件，修改多选按钮的`onTap`方法。

```diff
   //多选按钮
   Widget _cartCheckBt(context, item) {
     return Container(
       child: Checkbox(
         value: item.isCheck,
         activeColor: Colors.pink,
         onChanged: (bool val){ 
-
+          item.isCheck = val;
+          Provide.value<CartProvide>(context).changeCheckState(item);
         },
       ),
     );
   }
```

修改完成后，可以点击测试一下效果，如果一切正常，就可以进行选中和取消的交互了。

### [#](https://jspang.com/posts/2019/03/01/flutter-shop.html#全选按钮交互效果制作) 全选按钮交互效果制作

声明一个状态变量`isAllCheck`,然后在读取购物车商品数据时进行更改。

```diff
  double allPrice = 0;    //总价格
  int allGoodsCount = 0;  //商品总数量

+  bool isAllCheck = true; //是否全选
+
  //添加商品到购物车
  //... ...
```

修改`getCartInfo`方法，就是获取购物车列表的方法.

```diff
    //得到购物车中的商品
   getCartInfo() async {
     SharedPreferences prefs = await SharedPreferences.getInstance();
     //获得购物车中的商品,这时候是一个字符串
     cartString = prefs.getString('cartInfo');
     //把cartList进行初始化，防止数据混乱 
     cartList = [];
     //判断得到的字符串是否有值，如果不判断会报错
     if (cartString == null) {
       cartList = [];
     } else {
       List<Map> tempList = (json.decode(cartString.toString()) as List).cast();
 
       allPrice = 0;
       allGoodsCount = 0;
+      isAllCheck = true;
 
       tempList.forEach((item){
         if (item['isCheck']) {
           allPrice += (item['count'] * item['price']);
           allGoodsCount += item['count'];
+        } else {
+          isAllCheck = false;
         }
-        
+
         cartList.add(new CartInfoMode.fromJson(item));
       });
     }
     notifyListeners();
   }
```

全选按钮的方法和当个商品很类似，也是在`Provide`中，新建一个`changeAllCheckBtnState`方法，写入下面的代码.

```dart
  //点击全选按钮操作
  changeAllCheckBtnState(bool isCheck) async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    cartString=prefs.getString('cartInfo'); 
    List<Map> tempList= (json.decode(cartString.toString()) as List).cast(); 
    List<Map> newList=[]; //新建一个List，用于组成新的持久化数据。
    for(var item in tempList ){
      var newItem = item; //复制新的变量，因为Dart不让循环时修改原值
      newItem['isCheck']=isCheck; //改变选中状态
      newList.add(newItem);
    } 
   
     cartString= json.encode(newList).toString();//形成字符串
     prefs.setString('cartInfo', cartString);//进行持久化
     await getCartInfo();

  }
```

完成后，到UI界面加入交互效果,打开`lib/pages/cart_page/cart_bottom.dart`文件,修改`selectAllBtn(context)`方法。

```diff
   //全选按钮
-  Widget selectAllBtn() {
+  Widget selectAllBtn(context) {
+
+    bool isAllCheck = Provide.value<CartProvide>(context).isAllCheck;
+
     return Container(
       child: Row(
         children: <Widget>[
           Checkbox(
-            value: true,
+            value: isAllCheck,
             activeColor: Colors.pink,
             onChanged: (bool val) {
-
+              Provide.value<CartProvide>(context).changeAllCheckBtnState(val);
             },
           ),
           Text('全选')
         ],
       ),
     );
   }
```

做完这步，就可以测试一下交互效果了。这的代码比较零散，所以修改的时候要特别注意，防止犯错。

## [#](https://jspang.com/posts/2019/03/01/flutter-shop.html#第61节：购物车-商品数量的加减操作) 第61节：购物车_商品数量的加减操作

现在基本购物车页面只差一个商品数量的加减操作了，通过几节课的学习，应该大部分小伙i版已经掌握了编写业务逻辑和持久化的方法。你可以先自己试着能不能做出这个效果。

###  编写业务逻辑方法

直接在`lib/provide/cart.dart`文件中，新建立一个方法`addOrReduceAction()`方法。方法接收两个参数.

- cartItem:要修改的项.
- todo: 是加还是减。

代码如下：

```dart
  addOrReduceAction(var cartItem, String todo )async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    cartString=prefs.getString('cartInfo'); 
    List<Map> tempList= (json.decode(cartString.toString()) as List).cast();
    int tempIndex =0;
    int changeIndex=0;
    tempList.forEach((item){
         if(item['goodsId']==cartItem.goodsId){
          changeIndex=tempIndex; 
         }
         tempIndex++;
     });
     if(todo=='add'){
       cartItem.count++;
     }else if(cartItem.count>1){
       cartItem.count--;
     }
     tempList[changeIndex]=cartItem.toJson();
     cartString= json.encode(tempList).toString();
     prefs.setString('cartInfo', cartString);//
     await getCartInfo();

  }
```

方法写完后，就可以修改UI部分了，让其有交互效果.

### [#](https://jspang.com/posts/2019/03/01/flutter-shop.html#ui交互效果的修改) UI交互效果的修改

现在页面中引入`Provide`相关的文件.

```dart
import 'package:provide/provide.dart';
import '../../provide/cart.dart';
```

然后设置接收参数，接收item就可以了

```dart
  var item;
  CartCount(this.item);
```

然后把组件的内部方法都加入参数`context`,这里直接给出所有代码，方便你学习。

```diff
 import 'package:flutter/material.dart';
 import 'package:flutter_screenutil/flutter_screenutil.dart';
+import 'package:provide/provide.dart';
+import '../../provide/cart.dart';
 
 class CartCount extends StatelessWidget {
+  var item;
+  CartCount(this.item);
+
   @override
   Widget build(BuildContext context) {
     return Container(
       width:ScreenUtil().setWidth(165),
       margin: EdgeInsets.only(top: 5.0),
       decoration: BoxDecoration(
         border: Border.all(width: 1,color: Colors.black12) 
       ),
       child: Row(
         children: <Widget>[
-          _reduceBtn(),
+          _reduceBtn(context),
           _countArea(),
-          _addBtn(),
+          _addBtn(context),
         ],
       ),
     );
   }
 
   //减少按钮
-  Widget _reduceBtn() {
+  Widget _reduceBtn(context) {
     return InkWell(
       onTap: () {
-
+        Provide.value<CartProvide>(context).addOrReduceAction(item, 'reduce');
       },
       child: Container(
         width: ScreenUtil().setWidth(45),
         height: ScreenUtil().setHeight(45),
         alignment: Alignment.center,
 
         decoration: BoxDecoration(
-          color: Colors.white,
+          color: item.count ? Colors.white : Colors.black12,
           border: Border(
             right: BorderSide(width: 1,color: Colors.black12)
           )
         ),
-        child: Text('-'),
+        child: item.count > 1 ? Text('-') : Text(' '),
       ),
     );
   }
 
   //添加按钮
-  Widget _addBtn() {
+  Widget _addBtn(context) {
     return InkWell(
       onTap: (){
-
+        Provide.value<CartProvide>(context).addOrReduceAction(item, 'add');
       },
       child: Container(
         width: ScreenUtil().setWidth(45),
         height: ScreenUtil().setHeight(45),
         alignment: Alignment.center,
 
         decoration: BoxDecoration(
           color: Colors.white,
           border: Border(
             left: BorderSide(width: 1,color: Colors.black12)
           )
         ),
         child: Text("+"),
       ),
     );
   }
 
   //中间数列显示区域
   Widget _countArea() {
     return Container(
       width: ScreenUtil().setWidth(70),
       height: ScreenUtil().setHeight(45),
       alignment: Alignment.center,
       color: Colors.white,
-      child: Text('1'),
+      child: Text('${item.count}'),
     );
   }
 
 }
```

全部改完后，还需要到`cart_item.dart`里的`_cartGoodsName`里的调用组件的方法。

```diff
     //商品名称
   Widget _cartGoodsName(item) {
     return Container(
       width: ScreenUtil().setWidth(300),
       padding: EdgeInsets.all(10),
       alignment: Alignment.topLeft,
       child: Column(
         children: <Widget>[
           Text(item.goodsName),
-          CartCount()
+          CartCount(item),
         ],
       ),
     );
   }
```

这步完成后，就应该可以实现商品数量的加减交互了。

## [#](https://jspang.com/posts/2019/03/01/flutter-shop.html#第62节：购物车-首页provide化-让跳转随心所欲) 第62节：购物车_首页Provide化 让跳转随心所欲

在开始学习教程时，由于为了教学效果，所以底部导航跳转并没有使用Provide，而是使用了简单的变量，这样作的结果就是其它页面没办法控制首页底部导航的跳转，让项目的跳转非常笨拙，缺乏灵活性。这节课就通过我们小小的改造，把首页`index_page.dart`，加入Provide控制。



###  编写Provide文件

先在`lib/provide`文件夹下面，新建一个`currentIndex.dart`文件,然后声明一个索引变量，这个变量就是控制底部导航和页面跳转的。也就是说我们只要把这个索引进行状态管理，那所以的页面可以轻松的控制首页的跳转了。代码如下：

```dart
import 'package:flutter/material.dart';

class CurrentIndexProvide with ChangeNotifier{
  int currentIndex=0;
  
  changeIndex(int newIndex){
    currentIndex=newIndex;
    notifyListeners();
  }

}
```



然后在`main.dart`实例化：

```diff
 import 'package:flutter/material.dart';
 import './pages/index_page.dart';
 /// ======= provide 类
 import 'package:provide/provide.dart';
 import './provide/child_category.dart';
 import './provide/category_goods_list.dart';
 import './provide/details_info.dart';
 import './provide/cart.dart';
-
+import './provide/currentIndex.dart';
 
 import 'package:fluro/fluro.dart';
 import './routers/routes.dart';
 import './routers/application.dart';
 
 
 
 
 import './provide/counter.dart';
 
 void main(){
   var childCategory= ChildCategory();
   var categoryGoodsListProvide= CategoryGoodsListProvide();
   var detailsInfoProvide= DetailsInfoProvide();
   var cartProvide = CartProvide();
+  var currentIndexProvide = CurrentIndexProvide();
 
   var counter = Counter();
   var providers  = Providers();
  
   providers
     ..provide(Provider<ChildCategory>.value(childCategory))
     ..provide(Provider<CategoryGoodsListProvide>.value(categoryGoodsListProvide))
     ..provide(Provider<DetailsInfoProvide>.value(detailsInfoProvide))
     ..provide(Provider<CartProvide>.value(cartProvide))
+    ..provide(Provider<CurrentIndexProvide>.value(currentIndexProvide))
     ..provide(Provider<Counter>.value(counter));
 
   runApp(ProviderNode(child:MyApp(),providers:providers));
 }
 //... ...
```





### [#](https://jspang.com/posts/2019/03/01/flutter-shop.html#重新编写首页) 重新编写首页

现在就要改造首页了，这次改动的地方比较多，所以干脆先注释掉所有代码，然后重新进行编写。

```diff
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'home_page.dart';
import 'category_page.dart';
import 'cart_page.dart';
import 'member_page.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provide/provide.dart';
import '../provide/currentIndex.dart';


+ class IndexPage extends StatelessWidget {
  final List<BottomNavigationBarItem> bottomTabs = [
    BottomNavigationBarItem(
      icon:Icon(CupertinoIcons.home),
      title:Text('首页')
    ),
    BottomNavigationBarItem(
      icon:Icon(CupertinoIcons.search),
      title:Text('分类')
    ),
    BottomNavigationBarItem(
      icon:Icon(CupertinoIcons.shopping_cart),
      title:Text('购物车')
    ),
     BottomNavigationBarItem(
      icon:Icon(CupertinoIcons.profile_circled),
      title:Text('会员中心')
    ),
  ];

   final List<Widget> tabBodies = [
      HomePage(),
      CategoryPage(),
      CartPage(),
      MemberPage()
   ];
 
-  int currentIndex = 0;
-  var currentPage;
-  @override
-  void initState() {
-    currentPage = tabBodies[currentIndex];
-    _pageController = new PageController()
-    ..addListener((){
-      if (currentPage != _pageController.page.round()) {
-        setState(() {
-          currentPage = _pageController.page.round();
-        });
-      }
-    });
-    super.initState();
-  }
+

   @override
   Widget build(BuildContext context) {
     ScreenUtil.instance = ScreenUtil(width: 750, height: 1334)..init(context);
-    return Scaffold(
-      backgroundColor: Color.fromRGBO(244, 245, 245, 1.0),
-      bottomNavigationBar: BottomNavigationBar(
-        type: BottomNavigationBarType.fixed,
-        currentIndex: currentIndex,
-        items: bottomTabs,
-        onTap: (index){
-          setState(() {
-            currentIndex = index;
-            currentPage = tabBodies[currentIndex];
-          });
-        },
-      ),
-      body: IndexedStack(
-        index: currentIndex,
-        children: tabBodies,
-      ),
+
+    return Provide<CurrentIndexProvide>(
+      builder: (context, child, val){
+        int currentIndex = Provide.value<CurrentIndexProvide>(context).currentIndex;
+
+        return Scaffold(
+          backgroundColor: Color.fromRGBO(244, 245, 245, 1.0),
+          bottomNavigationBar: BottomNavigationBar(
+            type: BottomNavigationBarType.fixed,
+            currentIndex: currentIndex,
+            items: bottomTabs,
+            onTap: (index){
+              Provide.value<CurrentIndexProvide>(context).changeIndex(index);
+            },
+          ),
+          body: IndexedStack(
+            index: currentIndex,
+            children: tabBodies,
+          ),
+        ); 
+
+      },
     );
   }
}
```

修改思路是这样的，把原来的`statfulWidget`换成静态的`statelessWeidget`然后进行主要修改`build`方法里。加入`Provide Widget`，然后再每次变化时得到索引，点击下边导航时改变索引.

### [#](https://jspang.com/posts/2019/03/01/flutter-shop.html#修改商品详细页，实现跳转) 修改商品详细页，实现跳转

打开`/lib/pages/details_page/details_bottom.dart`文件，先引入`curretnIndex.dart`文件.

```text
import '../../provide/currentIndex.dart';
```

然后修改`build`方法里的购物车图标区域.在图标的`onTap`方法里,加入下面的代码.

```diff
          InkWell( //左边的
            onTap: () {
+              Provide.value<CurrentIndexProvide>(context).changeIndex(2);
+              Navigator.pop(context);
            },
            child: Container(
              width: ScreenUtil().setWidth(110),
              alignment: Alignment.center,
              child: Icon(
                Icons.shopping_cart,
                size: 35,
                color: Colors.red,
              ),
            ),
          ),

```

这步做完，可以试着测试一下了，看看是不是可以从详细页直接跳转到购物车页面了。

## [#](https://jspang.com/posts/2019/03/01/flutter-shop.html#第63节：购物车-详细页显示购物车商品数量) 第63节：购物车_详细页显示购物车商品数量

现在购物车的基本功能都已经做完了，但是商品详细页面还有一个小功能没有完成，就是在商品详细页添加商品到购物车时，购物车的图标要动态显示出此时购物车的数量。这节课就利用点时间完成这个功能。

###  修改文件结构

打开`/lib/pages/details_page/details_bottom.dart`文件，修改图片区域，增加层叠组件`Stack Widget`,然后在右上角加入购物车现有商品数量。

```dart
          children: <Widget>[
          //关键代码--------------------start--------------
           Stack(
             children: <Widget>[
               InkWell(
                  onTap: (){
                      Provide.value<CurrentIndexProvide>(context).changeIndex(2);
                      Navigator.pop(context);
                  },
                  child: Container(
                      width: ScreenUtil().setWidth(110) ,
                      alignment: Alignment.center,
                      child:Icon(
                            Icons.shopping_cart,
                            size: 35,
                            color: Colors.red,
                          ), 
                    ) ,
                ),
                Provide<CartProvide>(
                  builder: (context,child,val){
                    int  goodsCount = Provide.value<CartProvide>(context).allGoodsCount;
                    return  Positioned(
                        top:0,
                        right: 10,
                        child: Container(
                          padding:EdgeInsets.fromLTRB(6, 3, 6, 3),
                          decoration: BoxDecoration(
                            color:Colors.pink,
                            border:Border.all(width: 2,color: Colors.white),
                            borderRadius: BorderRadius.circular(12.0)
                          ),
                          child: Text(
                            '${goodsCount}',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: ScreenUtil().setSp(22)
                            ),
                          ),
                        ),
                      ) ;
                  },
                )
              
             ],
           ),
           
           //关键代码--------------------end----------------
```

### [#](https://jspang.com/posts/2019/03/01/flutter-shop.html#修改provide-cart-dart文件) 修改`provide/cart.dart`文件

因为我们要实现动态展示，所以在添加购物车商品时，应该也有数量的变化，所以需要修改`cart.dart`文件里的`save()`方法。

```diff
     //添加商品到购物车
   save(goodsId, goodsName, count, price, images) async {
     //初始化SharedPreferences
     SharedPreferences prefs = await SharedPreferences.getInstance();
     cartString = prefs.getString('cartInfo'); //获取持久化存储的值
     //判断cartString是否为空，为空说明是第一次添加，或者被key被清除了。
     // 如果有值进行decode操作
     var temp = cartString == null ? [] : json.decode(cartString.toString());
     //把获得值转变成List
     List<Map> tempList = (temp as List).cast();
 
     //声明变量，用于判断购物车中是否已经存在此商品ID
     var isHave = false; //默认为没有
     int ival = 0;       //用于进行循环的索引使用
+
+    allPrice = 0;
+    allGoodsCount = 0;  //把视频总数量设置为0
+
+
     tempList.forEach((item){    //进行循环，找出是否已经存在该商品
       //如果存在，数量进行+1操作
       if (item['goodsId'] == goodsId) {
         tempList[ival]['count'] = item['count'] + 1;
         isHave = true;
       }
+
+      if (item['isCheck']) {
+        allPrice += (cartList[ival].price * cartList[ival].count);
+        allGoodsCount += cartList[ival].count;
+      }
+
       ival ++;
     });
 
     //  如果没有，进行增加
     if (!isHave) {
       Map<String, dynamic> newGoods = {
         'goodsId': goodsId,
         'goodsName': goodsName,
         'count': count,
         'price': price,
         'images': images,
         'isCheck': true   ///是否已经选择
       };
       tempList.add(newGoods);
       cartList.add(new CartInfoMode.fromJson(newGoods));
+
+      allPrice += (count * price);
+      allGoodsCount += count;
+
     }
     //把字符串进行encode操作，
     cartString = json.encode(tempList).toString();
-    print(cartString);
-    print(cartList.toString());
-    prefs.setString('cartInfo', cartString);
+    //print(cartString);
+    //print(cartList.toString());
+    prefs.setString('cartInfo', cartString);  //进行持久化
+
+    notifyListeners();
   }
```

完成后，就可以实现商品详细页购物车中商品数量的动态展示了。也算我们购物车区域所有功能都已经完成了。

## [#](https://jspang.com/posts/2019/03/01/flutter-shop.html#第64节：会员中心-首页头部布局) 第64节：会员中心_首页头部布局

这节课开始布局会员中心的UI，如果你前边的课程都认真听了，并且也跟着作了，那这部分的内容对你来说就比较简单了。你可以作为一个练习来作。

### [#](https://jspang.com/posts/2019/03/01/flutter-shop.html#页面大体架构的编写) 页面大体架构的编写

打开以前建立的`/lib/pages/member_page.dart`文件，先删除里边的代码，然后引入我们需要的`package`代码。

```text
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
```

引入package后，就可以编写一个`StatelessWidget`，代码如下：

```dart
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';


class MemberPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
   
  }
}
```

然后返回一个`Scaffold`，在`body`区域里加入一个ListView。

```dart
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';


class MemberPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
     appBar: AppBar(
       title: Text('会员中心'),
     ),
     body:ListView(
       children: <Widget>[
       ],
     ) ,
   );
  }
}
```

这样大体结构就已经编写完成了，编写完成后我们把`ListView`的进行分离出来，编写成不同的方法。

### [#](https://jspang.com/posts/2019/03/01/flutter-shop.html#顶部头像区域编写) 顶部头像区域编写

头像区域我们外边套一层`Container`，然后里边放入`Column`，圆形头像这个部分，我们使用`ClipOval Widget`。代码我直接放在下面了。

```dart
  Widget _topHeader(){

    return Container(
      width: ScreenUtil().setWidth(750),
      padding: EdgeInsets.all(20),
      color: Colors.pinkAccent,
      child: Column(
        children: <Widget>[
          Container(
            margin: EdgeInsets.only(top: 30), 
            child: ClipOval(
              
              child:Image.network('http://blogimages.jspang.com/blogtouxiang1.jpg')
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: 10),
            child: Text(
              '技术胖',
              style: TextStyle(
                fontSize: ScreenUtil().setSp(36),
                color:Colors.white,

              ),
            ),
          )
        ],
      ),
    );

  }
```

写完后把这个组件加入到build的ListView里就可以了。然后就可以进行一个预览了。

## [#](https://jspang.com/posts/2019/03/01/flutter-shop.html#第65节：会员中心-订单区域ui编写) 第65节：会员中心_订单区域UI编写

头部区域编写好后，我们就可以编写订单区域了，这部分我们简单分成两个方法来进行编写。

### [#](https://jspang.com/posts/2019/03/01/flutter-shop.html#订单标题区域) 订单标题区域

直接上代码了。



