import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provide/provide.dart';
import '../service/service_method.dart';
import 'dart:convert';
import '../model/category.dart';
import '../provide/child_category.dart';


class CategoryPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('商品分类'),),
      body: Center(
        child: Row(
          children: <Widget>[
            LeftCategoryNav(),
            RightCategoryNav(),
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
  List<Data> list = [];

  var listIndex = 0;

  Widget _leftInkWell(int index) {
    bool isClick = false;
    isClick = (index == listIndex)? true : false;
    return InkWell(
      onTap: (){
        setState(() {
          listIndex = index;
        });
        var childList = list[index].bxMallSubDto;
        Provide.value<ChildCategory>(context).getChildCategory(childList);
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
      CategoryModel category = CategoryModel.fromJson(data);
      setState((){
        list = category.data;
      });
      Provide.value<ChildCategory>(context).getChildCategory(list[0].bxMallSubDto);
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
                return _rightInkWell(childCategory.childCategoryList[index]);
              },
            ),
          ),
        );
      },
    );
    
    
    
  }


  Widget _rightInkWell(BxMallSubDto item) {
    

    return InkWell(
      onTap: (){ },
      child: Container(
        padding: EdgeInsets.fromLTRB(5.0, 10.0, 5.0, 10.0),
        child: Text(
          item.mallSubName,
          style: TextStyle(fontSize: ScreenUtil().setSp(28)),
        ),
      ),
    );
  }


}


