import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provide/provide.dart';

import '../../provide/cart.dart';
import '../../provide/details_info.dart';
import '../../provide/currentIndex.dart';

class DetailsBottom extends StatelessWidget {
  
  @override
  Widget build(BuildContext context) {
    var goodsInfo = Provide.value<DetailsInfoProvide>(context).goodsInfo.data.goodInfo;
    var goodsId = goodsInfo.goodsId;
    var goodsName = goodsInfo.goodsName;
    var count = 1;
    var price = goodsInfo.presentPrice;
    var images = goodsInfo.image1;
    return Container(
      width: ScreenUtil().setWidth(750),
      color: Colors.white,
      height: ScreenUtil().setHeight(80),
      child: Row(
        children: <Widget>[
          InkWell( //左边的
            onTap: () {
              Provide.value<CurrentIndexProvide>(context).changeIndex(2);
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
          InkWell( //中间的
            onTap: () async {
              await Provide.value<CartProvide>(context).save(goodsId, goodsName, count, price, images);
            },
            child: Container(
              alignment: Alignment.center,
              width: ScreenUtil().setWidth(320),
              height: ScreenUtil().setHeight(80),
              color: Colors.green,
              child: Text(
                '加入购物车',
                style: TextStyle(color: Colors.white, fontSize: ScreenUtil().setSp(28)),
              ),
            ),
          ),
          InkWell( //右边的
            onTap: () async{
              await Provide.value<CartProvide>(context).remove();
             },
            child: Container(
              alignment: Alignment.center,
              width: ScreenUtil().setWidth(320),
              height: ScreenUtil().setHeight(80),
              color: Colors.red,
              child: Text(
                '马上购买',
                style: TextStyle(color: Colors.white, fontSize: ScreenUtil().setSp(28)),
              ),
            ),
          ),
        ],
      ),
    );
  }
}