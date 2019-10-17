// import 'dart:ui' as prefix0;

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../service/service_method.dart';
import 'dart:convert';
import '../commond/swiper_diy.dart'; //轮播
import '../commond/top_navigator.dart';//菜单
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:flutter_easyrefresh/material_footer.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with AutomaticKeepAliveClientMixin {
  int page = 1;
  List<Map> hotGoodsList = [];
  GlobalKey<RefreshFooterState> _footKey = new GlobalKey<RefreshFooterState>();
  String homePageContent = '正在获取数据';

  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();
    print('1111111111111111');
  }

  @override
  Widget build(BuildContext context) {
    var formData = {'lon': '115.02932', 'lat':'35.76189'};
    return Scaffold(
      appBar: AppBar(title: Text('百姓生活+'),),
      body: FutureBuilder(
        future: getHomePageContent(),
        //future: request('homePageContent',formData),
        builder: (context,snapshot){
          if(snapshot.hasData){
            //数据处理
            var data = json.decode(snapshot.data.toString());
            List<Map> swiper = (data['data']['slides'] as List).cast();// 顶部轮播组件数
            List<Map> navigatorList = (data['data']['category'] as List).cast();
            String advertesPicture = data['data']['advertesPicture']['PICTURE_ADDRESS']; //广告图片
            String leaderImage = data['data']['shopInfo']['leaderImage'];//店长图片
            String leaderPhone = data['data']['shopInfo']['leaderPhone'];//店长电话 
            List<Map> recommendList = (data['data']['recommend'] as List).cast();//商品推荐

            //楼层商品
            String floor1Tiltle = data['data']['floor1Pic']['PICTURE_ADDRESS'];
            String floor2Tiltle = data['data']['floor2Pic']['PICTURE_ADDRESS'];
            String floor3Tiltle = data['data']['floor3Pic']['PICTURE_ADDRESS'];
            List<Map> floor1 =  (data['data']['floor1'] as List).cast();
            List<Map> floor2 =  (data['data']['floor2'] as List).cast();
            List<Map> floor3 =  (data['data']['floor3'] as List).cast();


            return EasyRefresh(
              // refreshFooter: ClassicalFooter(
              //   key: _footKey,
              //   bgColor: Colors.white,
              //   textColor: Colors.pink,
              //   infoColor: Colors.pink,
              //   showInfo: true,
              //   noMoreText: '',
              //   infoText: '加载中',
              //   loadReadyText: '上拉加载...'
              // ),
              refreshFooter: ClassicsFooter(
                key: _footKey,
                bgColor: Colors.white,
                textColor: Colors.pink,
                moreInfoColor: Colors.pink,
                showMore: true,
                noMoreText: '',
                moreInfo: '加载中',
                loadReadyText: '上拉加载...'
              ),
              child: ListView(
                children: <Widget>[
                  SwiperDiy(swiperDataList: swiper,), //页面顶部轮播组件
                  TopNavigator(navigatorList: navigatorList),//导航组件
                  AdBanner(advertesPicture: advertesPicture,),//广告组件 
                  LeaderPhone(leaderImage: leaderImage,leaderPhone: leaderPhone), //广告组件 
                  Recommend(recommendList: recommendList),
                  //楼层商品
                  FloorTitle(picture_address: floor1Tiltle),
                  FloorContent(floorGoodsList: floor1),
                  FloorTitle(picture_address: floor2Tiltle),
                  FloorContent(floorGoodsList: floor2),
                  FloorTitle(picture_address: floor3Tiltle),
                  FloorContent(floorGoodsList: floor3),
                  _hotGoods(),
                ],
              ),
              loadMore:()async{
                print('开始加载更多');
                var formPage = {'page': page};
                await request('homePageBelowConten', formData:formPage).then((val){
                  var data = json.decode(val.toString());
                  List<Map> newGoodsList = (data['data'] as List).cast();
                  setState(() {
                    hotGoodsList.addAll(newGoodsList);
                    page++;
                  });
                });
              }
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


  //火爆专区标题
  Widget hotTitle = Container(
    margin: EdgeInsets.only(top: 10.0),
    padding: EdgeInsets.all(5.0),
    alignment: Alignment.centerLeft,
    decoration: BoxDecoration(
      color: Colors.white,
      border: Border(
        bottom: BorderSide(width: 0.5, color: Colors.black12)
      )
    ),
    child: Text('火爆专区'),
  );
  //火爆专区子项
  Widget _wrapList(){
    if (hotGoodsList.length != 0) {
      List<Widget> listWidget = hotGoodsList.map((val){
        return InkWell(
          onTap: (){print('点击了火爆商品');},
          child: Container(
            width: ScreenUtil().setWidth(372),
            color: Colors.white,
            padding: EdgeInsets.all(5.0),
            margin: EdgeInsets.only(bottom: 3.0),
            child: Column(
              children: <Widget>[
                Image.network(val['image'], width: ScreenUtil().setWidth(375)),
                Text(
                  val['name'],
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(color: Colors.pink, fontSize: ScreenUtil().setSp(26)),
                ),
                Row(
                  children: <Widget>[
                    Text('￥${val['mallPrice']}'),
                    Text('￥${val['price']}', style: TextStyle(color: Colors.black26, decoration: TextDecoration.lineThrough),)
                  ],
                )
              ],
            ),
          ),
        );
      }).toList();

      return Wrap(
        spacing: 2,
        children: listWidget,
      );
    } else {
      return Text(' ');
    }
  }
  //火爆专区组合
  Widget _hotGoods(){
    return Container(
      child: Column(
        children: <Widget>[
          hotTitle,
          _wrapList(),
        ],
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

  //商品推荐
class Recommend extends StatelessWidget {
  final List  recommendList;

  Recommend({Key key, this.recommendList}) : super(key: key);

  

  //推荐商品标题
  Widget _titleWidget(){
     return Container(
       alignment: Alignment.centerLeft,
       padding: EdgeInsets.fromLTRB(10.0, 2.0, 0,5.0),
       decoration: BoxDecoration(
         color:Colors.white,
         border: Border(
           bottom: BorderSide(width:0.5,color:Colors.black12)
         )
       ),
       child:Text(
         '商品推荐',
         style:TextStyle(color:Colors.pink)
         )
     );
  }
  Widget _item(index){
    return InkWell(
      onTap: (){},
      child: Container(
        height: ScreenUtil().setHeight(330),
        width: ScreenUtil().setWidth(250),
        padding: EdgeInsets.all(8.0),
        decoration:BoxDecoration(
          color:Colors.white,
          border:Border(
            left: BorderSide(width:0.5,color:Colors.black12)
          )
        ),
        child: Column(    //列
          children: <Widget>[
            Image.network(recommendList[index]['image']),
            Text('￥${recommendList[index]['mallPrice']}'),
            Text(
              '￥${recommendList[index]['price']}',
              style: TextStyle(
                decoration: TextDecoration.lineThrough,
                color:Colors.grey
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _recommedList(){

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
           _recommedList()
         ],
       ),
    );
  }
  
}

//楼层
class FloorTitle extends StatelessWidget {
  final String picture_address;//图片地址
  const FloorTitle({Key key, this.picture_address}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(8.0),
      child: Image.network(picture_address),
    );
  }
}
//楼层商品组件
class FloorContent extends StatelessWidget {
  final List floorGoodsList;

  const FloorContent({Key key, this.floorGoodsList}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: <Widget>[
          _firstRow(),
          _otherGoods()
        ],
      ),
    );
  }

  Widget _firstRow() {
    return Row(
      children: <Widget>[
        _goodsItem(floorGoodsList[0]),
        Column(
          children: <Widget>[
            _goodsItem(floorGoodsList[1]),
            _goodsItem(floorGoodsList[2]),
          ],
        )
      ],
    );
  }

  Widget _otherGoods(){
    return Row(
      children: <Widget>[
        _goodsItem(floorGoodsList[3]),
        _goodsItem(floorGoodsList[4]),
      ],
    );
  }

  Widget _goodsItem(Map goods) {
    return Container(
      width: ScreenUtil().setWidth(375),
      child: InkWell(
        onTap: (){
          print('点击了楼层商品');
        },
        child: Image.network(goods['image']),
      ),
    );
  }


}


