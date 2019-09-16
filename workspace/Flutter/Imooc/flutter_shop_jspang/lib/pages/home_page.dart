// import 'dart:ui' as prefix0;

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../service/service_method.dart';
import 'dart:convert';
import '../commond/swiper_diy.dart'; //轮播
import '../commond/top_navigator.dart';//菜单
import 'package:url_launcher/url_launcher.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String homePageContent = '正在获取数据';

  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('百姓生活+'),),
      body: FutureBuilder(
        future: getHomePageContent(),
        builder: (context,snapshot){
          if(snapshot.hasData){
            //数据处理
            var data = json.decode(snapshot.data.toString());
            List<Map> swiper = (data['data']['slides'] as List).cast();// 顶部轮播组件数
            List<Map> navigatorList = (data['data']['category'] as List).cast();
            String advertesPicture = data['data']['advertesPicture']['PICTURE_ADDRESS']; //广告图片
            String leaderImage = data['data']['shopInfo']['leaderImage'];//店长图片
            String leaderPhone = data['data']['shopInfo']['leaderPhone'];//店长电话 

            return SingleChildScrollView(
              child: Column(
              children: <Widget>[
                SwiperDiy(swiperDataList: swiper,), //页面顶部轮播组件
                TopNavigator(navigatorList: navigatorList),//导航组件
                AdBanner(advertesPicture: advertesPicture,),//广告组件 
                LeaderPhone(leaderImage: leaderImage,leaderPhone: leaderPhone) //广告组件 
              ],
            ),
            );
          } else {
            return Center(
              child: Text('加载中...'),
            );
          }
        },
      ),
    );
  }
}
//广告区域
class AdBanner extends StatelessWidget {
  final String advertesPicture;

  const AdBanner({Key key,this.advertesPicture}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Image.network(advertesPicture),
    );
  }
}

//店长电话模块
class LeaderPhone extends StatelessWidget {
  final String leaderImage;//店长图片
  final String leaderPhone;//店长电话
  const LeaderPhone({Key key,this.leaderImage, this.leaderPhone}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: InkWell(
        onTap: _launchURL,
        child: Image.network(leaderImage),
      ),
    );
  }

  void _launchURL() async{
    String url = 'tel:' + leaderPhone;
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}

//商品推荐类
class Recommend extends StatelessWidget {
  final List recommendList;
  const Recommend({Key key, this.recommendList}) : super(key: key);

  //推荐商品标题
  Widget _titleWidget(){
    return Container(
      alignment: Alignment.centerLeft,
      padding: EdgeInsets.fromLTRB(10.0, 2.0, 0, 5.0),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border(bottom: BorderSide(width: 0.5,color: Colors.black12))
      ),
      child: Text(
        '商品推荐',
        style: TextStyle(color: Colors.pink),
      ),
    );
  }

  //
  Widget _item(index) {
    return InkWell(
      onTap: (){},
      child: Container(
        height: ScreenUtil().setHeight(330),
        width: ScreenUtil().setWidth(250),
        padding: EdgeInsets.all(8.0),
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border(
            left: BorderSide(width: 0.5, color: Colors.black12)
          ),
        ),
        child: Column(
          children: <Widget>[
            Image.network(recommendList[index]['image']),
            Text('￥${recommendList[index]['mallPrice']}'),
            Text(
              '￥${recommendList[index]['price']}',
              style: TextStyle(
                decoration: TextDecoration.lineThrough,
                color: Colors.grey,
              ),
            )
          ],
        ),
      ),
    );
  }
  //横向列表
  Widget _recommendList(){
    return Container(
      height: ScreenUtil().setHeight(330),
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: recommendList.length,
        itemBuilder: (context,index){
          return _item(index);
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: ScreenUtil().setHeight(380),
      margin: EdgeInsets.only(top: 10.0),
      child: Column(
        children: <Widget>[
          _titleWidget(),
          _recommendList()
        ],
      ),
    );
  }
}




