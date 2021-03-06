import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provide/provide.dart';
import '../service/service_method.dart';
import 'dart:convert';
import '../model/category.dart';
import '../model/categoryGoodsList.dart';
import '../provide/child_category.dart';
import '../provide/category_goods_list.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:fluttertoast/fluttertoast.dart';

class CategoryPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('商品分类'),),
      body: Center(
        child: Row(
          children: <Widget>[
            LeftCategoryNav(),
            Column(
              children: <Widget>[
                RightCategoryNav(),
                CategoryGoodsList(),
              ],
            )
          ],
        ),
      ),
    );
  }
  
}

///MARK: 左侧大类导航
class LeftCategoryNav extends StatefulWidget {
  _LeftCategoryNavState createState() => _LeftCategoryNavState();
}

class _LeftCategoryNavState extends State<LeftCategoryNav> {
  List list = [];

  var listIndex = 0; //索引

  @override
  void initState() {
    ///左边大类初始化的请求
    _getCategory();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
       child: Container(
         width: ScreenUtil().setWidth(180),
         decoration: BoxDecoration(
           border: Border(
             right: BorderSide(width: 1, color: Colors.black12)
           ),
         ),
         child: ListView.builder(
           itemCount: list.length,
           itemBuilder: (context, index){
             return _leftInkWell(index);
           },
         ),
       ),
    );
  }

  Widget _leftInkWell(int index) {
    bool isClick = false;
    isClick = (index == listIndex)? true : false;
    return InkWell(
      onTap: (){
        ///点击左边大类的响应
        ///
        setState(() {
          listIndex = index;
        });
        var childList = list[index].bxMallSubDto;
        var categoryId = list[index].mallCategoryId;
        Provide.value<ChildCategory>(context).getChildCategory(childList,categoryId);
        ///点击左边大类的请求
        _getGoodsList(categoryId: categoryId);
        print("点击左边大类的响应");
      },
      child: Container(
        height: ScreenUtil().setHeight(100),
        padding: EdgeInsets.only(left: 10, top: 20),
        decoration: BoxDecoration(
          color: isClick ? Color.fromRGBO(236, 236, 236, 1.0) : Colors.white,
          border: Border(
            bottom: BorderSide(width: 1, color: Colors.black12)
          ),
        ),
        child: Text(list[index].mallCategoryName, style: TextStyle(fontSize: ScreenUtil().setSp(28)),),
      ),
    );
  }

  

  ///左边大类初始化的请求
  void _getCategory()async{
    await request('getCategory').then((val){
      var data = json.decode(val.toString());
      CategoryModel category = CategoryModel.fromJson(data);
      setState((){
        list = category.data;
      });

      ///选中第1个再请求
      var first =  list[0];
      var childList = first.bxMallSubDto;
      var categoryId = first.mallCategoryId;
      Provide.value<ChildCategory>(context).getChildCategory(childList,categoryId);
      ///点击左边大类的请求
      _getGoodsList(categoryId: categoryId);
    });
  }
  //放在category_page，作为内部方法
  ///得到商品列表数据
  ///点击左边大类的请求
  void _getGoodsList({String categoryId}) async {
    var data = {
      'categoryId': categoryId == null ? '4' : categoryId,
      'CategorySubId':'',
      'page':1
    };
    await request('getMallGoods',formData: data).then((val){
      var data = json.decode(val.toString());
      CategoryGoodsListModel goodsList = CategoryGoodsListModel.fromJson(data);
      Provide.value<CategoryGoodsListProvide>(context).getGoodsList(goodsList.data);
    });
  }

}


///右侧小类类别
class RightCategoryNav extends StatefulWidget {

  _RightCategoryNavState createState() => _RightCategoryNavState();
}

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
                //print("右边小类的数量=${childCategory.childCategoryList.length}");
                return _rightInkWell(index, childCategory.childCategoryList[index]);
              },
            ),
          )
        );
      },
    );
  }


  Widget _rightInkWell(int index, BxMallSubDto item) {
    
    bool isClick = false;
    isClick = (index == Provide.value<ChildCategory>(context).childIndex) ? true : false;

    return InkWell(
      onTap: (){ 
        ///  右边小类类别的点击响应
        /// 
        print("右边小类类别的点击响应");
        Provide.value<ChildCategory>(context).changeChildIndex(index, item.mallSubId);
        ///点击右边子类的请求
        _getGoodsList(item.mallSubId);
      },
      child: Container(
        padding: EdgeInsets.fromLTRB(5.0, 10.0, 5.0, 10.0),
        child: Text(
          item.mallSubName,
          style: TextStyle(
            fontSize: ScreenUtil().setSp(28), 
            color: isClick ? Colors.pink : Colors.black12
            ),
        ),
      ),
    );
  }

  ///点击右边子类的请求
  void _getGoodsList(String categorySubId) async {
    var data = {
      'categoryId': Provide.value<ChildCategory>(context).categoryId,
      'CategorySubId':categorySubId,
      'page':1
    };
    await request('getMallGoods',formData: data).then((val){
      var data = json.decode(val.toString());

      CategoryGoodsListModel goodsList = CategoryGoodsListModel.fromJson(data);
      if (goodsList.data == null) {
        Provide.value<CategoryGoodsListProvide>(context).getGoodsList([]);
      } else {
        Provide.value<CategoryGoodsListProvide>(context).getGoodsList(goodsList.data);
      }
      
    });
  }

}

/// 商品列表，可以上拉加载
class CategoryGoodsList extends StatefulWidget {
  CategoryGoodsList({Key key}) : super(key: key);
  _CategoryGoodsListState createState() => _CategoryGoodsListState();
}

class _CategoryGoodsListState extends State<CategoryGoodsList> {
  // List list = [];
  GlobalKey<RefreshFooterState> _footerkey = new GlobalKey<RefreshFooterState>();

  var scrollController = new ScrollController();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Provide<CategoryGoodsListProvide>(
      builder: (context,child,data){

        try {
          if (Provide.value<ChildCategory>(context).page == 1) {
            //列表位置，放到最上边
            scrollController.jumpTo(0.0);
          }
        } catch (e) {
          print('进入页面第一次初始化：${e}');
        }

        if (data.goodsList.length > 0) {
          return  Expanded(
              child: Container(
              width: ScreenUtil().setWidth(570),
              child: EasyRefresh(
                refreshFooter: ClassicsFooter(
                  key: _footerkey,
                  bgColor: Colors.white,
                  textColor: Colors.pink,
                  moreInfoColor: Colors.pink,
                  noMoreText: Provide.value<ChildCategory>(context).noMoreText,
                  moreInfo: '加载中',
                  loadingText: '上拉加载',
                  // loadReadyText: '上拉加载',
                ),
                child: ListView.builder(
                  controller: scrollController,
                  itemCount: data.goodsList.length,
                  itemBuilder: (context,index){
                    return _listWidget(data.goodsList, index);
                  },
                ),
                
                loadMore: ()async{
                  /// 上拉加载的响应
                  print('上拉加载更多.....');
                  _getMoreList();
                },
              ),
              
               
            ),
          );
        } else {
          return Text('暂时没有数据');
        }
 
      },
    );
    
  }

  //上拉加载更多的方法
  void _getMoreList() {
    Provide.value<ChildCategory>(context).addPage(); //增加Page的 方法
    
    var page =  Provide.value<ChildCategory>(context).page;  
    print('page=${page}'); //打印page
    var data = {
      'categoryId': Provide.value<ChildCategory>(context).categoryId,
      'categorySubId': Provide.value<ChildCategory>(context).subId,
      'page': page,
    };

    request('getMallGoods',formData: data).then((val){
      var data = json.decode(val.toString());

      CategoryGoodsListModel goodsList = CategoryGoodsListModel.fromJson(data);
      
      ///测试代码
      if (Provide.value<CategoryGoodsListProvide>(context).goodsList.length > 0) {
        goodsList.data = null;
      }
      //
      if (goodsList.data == null) {
        Fluttertoast.showToast(
          msg: "已经到底了",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          backgroundColor: Colors.pink,
          textColor: Colors.white,
          fontSize: 16.0
        );
        Provide.value<ChildCategory>(context).changeNoMore('没有更多了');
      } else {
        Provide.value<CategoryGoodsListProvide>(context).getMoreList(goodsList.data);
      }
    });
  }

  

  Widget _goodsImage(List newList,index) {
    return Container(
      width: ScreenUtil().setWidth(200),
      child: Image.network(newList[index].image),
    );
  }

  Widget _goodsName(List newList,index) {
    return Container(
      padding: EdgeInsets.all(5.0),
      width: ScreenUtil().setWidth(370),
      child: Text(
        newList[index].goodsName,
        maxLines: 2,
        overflow: TextOverflow.ellipsis,
        style: TextStyle(fontSize: ScreenUtil().setSp(28)),
      ),
    );
  }
  Widget _goodsPrice(List newList,index) {
    return Container(
      margin: EdgeInsets.only(top: 20.0),
      width: ScreenUtil().setWidth(370),
      child: Row(
        children: <Widget>[
          Text(
            '价格：￥${newList[index].presentPrice}',
            style: TextStyle(color: Colors.pink, fontSize: ScreenUtil().setSp(30)),
          ),
          Text(
            '￥${newList[index].oriPrice}',
            style: TextStyle(color: Colors.black26, decoration: TextDecoration.lineThrough),
          ),
        ],
      ),
    );
  }

  Widget _listWidget(List newList, int index) {
    return InkWell(
      onTap: (){},
      child: Container(
        padding: EdgeInsets.only(top: 5.0, bottom: 5.0),
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border(
            bottom: BorderSide(width: 1.0, color: Colors.black12)
          )
        ),
        child: Row(
          children: <Widget>[
            _goodsImage(newList,index),
            Column(
              children: <Widget>[
                _goodsName(newList,index),
                _goodsPrice(newList,index),
              ],
            )
          ],
        ),
      ),
    );
  }
}


