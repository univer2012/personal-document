import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';//屏幕适配

//导航组件
class TopNavigator extends StatelessWidget {
  final List navigatorList;

  TopNavigator({Key key,this.navigatorList}): super(key: key);

  Widget _gridViewItemUI(BuildContext context, item){
    return InkWell(
      onTap: (){
        print('点击了导航');
      },
      child: Column(
        children: <Widget>[
          Image.network(item['image'], width: ScreenUtil().setWidth(95),),
          Text(item['mallCategoryName'])
        ],
      ),
    );
  }


  @override
  Widget build(BuildContext context) {
    if (this.navigatorList.length > 10) {
      this.navigatorList.removeRange(10, this.navigatorList.length);
    }
    return Container(
      height: ScreenUtil().setWidth(320),
      padding: EdgeInsets.all(3.0),
      child: GridView.count(
        crossAxisCount: 5, //每行有多少个
        padding: EdgeInsets.all(4.0),
        children: navigatorList.map((item){
          return _gridViewItemUI(context, item);
        }).toList(),
      ),
    );
  }
}