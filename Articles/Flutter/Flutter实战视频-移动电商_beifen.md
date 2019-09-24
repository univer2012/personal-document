## 第32节：列表页_小类高亮交互效果制作

这节课主要学习小类高亮交互效果的实现，通过几节课的练习，应该对状态管理有了比较深刻的理解。我建议小伙伴们可以先不看视频自己作一下，检验一下自己的学习能力。

### Expanded Widget的使用

Expanded Widget 是让子Widget有伸缩能力的小部件，它继承自`Flexible`,用法也差不多。那为什么要单独拿出来讲一下Expanded Widget那？我们在首页布局和列表页布局时都遇到了高度适配的问题，很多小伙伴出现了高度溢出的BUG，所以这节课开始前先解决一下这个问题。

修改 `Category_page.dart`里的商品列表页面，不再约束高了，而是使用`Expanded Widget`包裹外层，修改后的代码如下:

```text
 @override
  Widget build(BuildContext context) {
    return Provide<CategoryGoodsListProvide>(
        builder: (context,child,data){
          return Expanded(
            child:Container(
              width: ScreenUtil().setWidth(570) ,
              child:ListView.builder(
                  itemCount: data.goodsList.length,
                  itemBuilder: (context,index){
                    return _ListWidget(data.goodsList,index);
                  },
                ) ,
            ) ,
          ); 
       },
    );
  }
```

### [#](https://jspang.com/posts/2019/03/01/flutter-shop.html#小类高亮效果制作)小类高亮效果制作

由于高亮效果也受到大类的控制，不仅仅是子类别的控制，所以这个效果也要用到状态管理来制作。这个状态很简单，没必要单独写一个`Provide`，所以直接使用以前的类就可以，我们直接在`provide/child_category.dart`里修改。修改的代码为：

```diff
import 'package:flutter/material.dart';
import '../model/category.dart';


//ChangeNotifier的混入是不用管理听众
class ChildCategory with ChangeNotifier{

    List<BxMallSubDto> childCategoryList = [];
+    int childIndex = 0;
  


+    //点击大类时更换
    getChildCategory(List<BxMallSubDto> list){
      
+      childIndex=0;
      BxMallSubDto all=  BxMallSubDto();
      all.mallSubId='00';
      all.mallCategoryId='00';
      all.mallSubName = '全部';
      all.comments = 'null';
      childCategoryList=[all];
      childCategoryList.addAll(list);   
      notifyListeners();
    }
+    //改变子类索引
+    changeChildIndex(index){
+       childIndex=index;
+       notifyListeners();
+    }
}
```

然后就可以修改UI部分了，UI部分主要是增加索引参数，然后进行判断。

1. 先把`_rghtInkWell`方法增加一个接收参数`int index`.这就是修改变量的索引值。

```text
Widget _rightInkWell(int index,BxMallSubDto item)
```

1. 定义是否高亮变量，再根据状态进行赋值

```text
   bool isCheck = false;
   isCheck =(index==Provide.value<ChildCategory>(context).childIndex)?true:false;
```

3.点击时修改状态

```text
onTap: (){
    Provide.value<ChildCategory>(context).changeChildIndex(index);
},
```

4.用`isCheck`判断是否高亮

```text
color:isCheck?Colors.pink:Colors.black ),
```

到这里，我们的子类高亮就制作完成了，并且当更换大类时，子类自动更改为第一个高亮。

修改的全部代码如下：

```diff
class _RightCategoryNavState extends State<RightCategoryNav> {
  @override
  Widget build(BuildContext context) {

    //List list = ['名酒','宝丰', '北京二锅头', '舍得','五粮液','茅台','散白'];
    return Provide<ChildCategory>(
      builder: (context,child, childCategory){
        return Container(
          child: Container(
            height: ScreenUtil().setHeight(80),
            width: ScreenUtil().setWidth(570),
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border(
                bottom: BorderSide(width: 1, color: Colors.black12)
              )
            ),
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: childCategory.childCategoryList.length,
              itemBuilder: (context,index) {
-                return _rightInkWell(childCategory.childCategoryList[index]);
+                return _rightInkWell(index,childCategory.childCategoryList[index]);
               },

            ),
          ),
        );
      },
    );
    
    
    
  }

 
-  Widget _rightInkWell(BxMallSubDto item) {
+  Widget _rightInkWell(int index, BxMallSubDto item) {
     
+    bool isClick = false;
+    isClick = (index == Provide.value<ChildCategory>(context).childIndex) ? true : false;
 
     return InkWell(
-      onTap: (){ },
+      onTap: (){ 
+        Provide.value<ChildCategory>(context).changeChildIndex(index);
+      },
       child: Container(
         padding: EdgeInsets.fromLTRB(5.0, 10.0, 5.0, 10.0),
         child: Text(
           item.mallSubName,
-          style: TextStyle(fontSize: ScreenUtil().setSp(28)),
+          style: TextStyle(
+            fontSize: ScreenUtil().setSp(28), 
+            color: isClick ? Colors.pink : Colors.black12
+            ),
         ),
       ),
     );
	}
	//... ...
}
```



到这里，我们的子类高亮就制作完成了，并且当更换大类时，子类自动更改为第一个高亮。

## [#](https://jspang.com/posts/2019/03/01/flutter-shop.html#第33节-列表页-子类和商品列表切换)第33节:列表页_子类和商品列表切换

其实点击大类切换商品列表效果如果你会了，那点击小类切换商品列表效果几乎是一样。只有很小的改动。

### 修改Provide类

先改动一下`child_ategory.dart`的Provide类，增加一个大类ID，然后在更改大类的时候改变ID。

```text
import 'package:flutter/material.dart';
import '../model/category.dart';


//ChangeNotifier的混入是不用管理听众
class ChildCategory with ChangeNotifier{

    List<BxMallSubDto> childCategoryList = [];
    int childIndex = 0;
    String categoryId = '4';
  


    //点击大类时更换
    getChildCategory(List<BxMallSubDto> list,String id){
      categoryId=id;
      childIndex=0;
      BxMallSubDto all=  BxMallSubDto();
      all.mallSubId='00';
      all.mallCategoryId='00';
      all.mallSubName = '全部';
      all.comments = 'null';
      childCategoryList=[all];
      childCategoryList.addAll(list);   
      notifyListeners();
    }
    //改变子类索引
    changeChildIndex(index){
       childIndex=index;
       notifyListeners();
    }
}
```

### [#](https://jspang.com/posts/2019/03/01/flutter-shop.html#修改调用getchildcategory放)修改调用getChildCategory放

增加了参数，以前的调用方法也就都不对了，所以需要修改一下。直接用搜索功能就可以找到`getChildCategory`方法，一共两处，直接修改就可以了

```text
Provide.value<ChildCategory>(context).getChildCategory(childList,categoryId);
Provide.value<ChildCategory>(context).getChildCategory(list[0].bxMallSubDto,list[0].mallCategoryId);
```

### [#](https://jspang.com/posts/2019/03/01/flutter-shop.html#增加getgoodslist方法)增加getGoodsList方法

拷贝`_getGoodsList`方法到子列表类里边，然后把传递参数换成子类的参数`categorySubId`.代码如下：

```text
   //得到商品列表数据
   void _getGoodList(String categorySubId) {
     
    var data={
      'categoryId':Provide.value<ChildCategory>(context).categoryId,
      'categorySubId':categorySubId,
      'page':1
    };
    
    request('getMallGoods',formData:data ).then((val){
        var  data = json.decode(val.toString());
        CategoryGoodsListModel goodsList=  CategoryGoodsListModel.fromJson(data);
        // Provide.value<CategoryGoodsList>(context).getGoodsList(goodsList.data);
        Provide.value<CategoryGoodsListProvide>(context).getGoodsList(goodsList.data);
       
    });
  }
```

### [#](https://jspang.com/posts/2019/03/01/flutter-shop.html#调用方法改版列表)调用方法改版列表

当点击子类时，调用这个方法，并传入子类ID。

```text
onTap: (){
    Provide.value<ChildCategory>(context).changeChildIndex(index);
    _getGoodList(item.mallSubId);
},
```

## [#](https://jspang.com/posts/2019/03/01/flutter-shop.html#第34节：列表页-小bug的修复)第34节：列表页_小Bug的修复

在列表页还是有小Bug的，这节课我们就利用几分钟，进行修复一下.