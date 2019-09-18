import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../service/service_method.dart';
import 'dart:convert';
import '../model/category.dart';

class CategoryPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('商品分类'),),
      body: Center(
        child: Row(
          children: <Widget>[
            LeftCategoryNav(),
          ],
        ),
      ),
    );
  }
  
}

///左侧大类导航
class LeftCategoryNav extends StatefulWidget {
  _LeftCategoryNavState createState() => _LeftCategoryNavState();
}

class _LeftCategoryNavState extends State<LeftCategoryNav> {
  List<Data> list = [];

  Widget _leftInkWell(int index) {
    return InkWell(
      onTap: (){},
      child: Container(
        height: ScreenUtil().setHeight(100),
        padding: EdgeInsets.only(left: 10, top: 20),
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border(
            bottom: BorderSide(width: 1, color: Colors.black12)
          ),
        ),
        child: Text(list[index].mallCategoryName, style: TextStyle(fontSize: ScreenUtil().setSp(28)),),
      ),
    );
  }

  @override
  void initState() {
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

  void _getCategory()async{
    await request('getCategory').then((val){
      var data = json.decode(val.toString());
      //CategoryBigListModel list = CategoryBigListModel.formJson(data['data']);
      //list.data.forEach((item)=> print(item.mallCategoryName) );

      CategoryModel category = CategoryModel.fromJson(data);
      setState((){
        list = category.data;
      });
    });
  }

}