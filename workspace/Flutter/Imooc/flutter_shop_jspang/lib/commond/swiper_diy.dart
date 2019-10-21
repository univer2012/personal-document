import 'package:flutter/material.dart';
import 'package:flutter_shop_jspang/routers/application.dart';
import 'package:flutter_swiper/flutter_swiper.dart'; //banner轮播
import 'package:flutter_screenutil/flutter_screenutil.dart';//屏幕适配

//首页轮播组件
class SwiperDiy extends StatelessWidget {
  final List swiperDataList;
  SwiperDiy({Key key, this.swiperDataList}): super(key:key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: ScreenUtil().setHeight(333),
      width: ScreenUtil().setWidth(750),
      child: Swiper(
        itemBuilder: (BuildContext context, int index){
          return InkWell(
            onTap: (){
              Application.router.navigateTo(context, "/detail?id=${swiperDataList[index]['goodsId']}");
            },
            child: Image.network('${swiperDataList[index]['image']}',fit: BoxFit.fill,),
          );
        },
        itemCount: swiperDataList.length,
        pagination: new SwiperPagination(),
        autoplay: true,
      ),
    );
  }
}