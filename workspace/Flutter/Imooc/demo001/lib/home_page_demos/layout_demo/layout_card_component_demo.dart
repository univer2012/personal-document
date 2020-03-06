import 'package:flutter/material.dart';

class LayoutCardComponentPage extends StatelessWidget {
  const LayoutCardComponentPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    var card = new Card(
      child: Column(
        children: <Widget>[
          ListTile(
            title: new Text('吉林省吉林市昌邑区',style: TextStyle(fontWeight: FontWeight.w500),),
            subtitle: new Text('技术胖：151398888'),
            leading: new Icon(Icons.account_box, color: Colors.lightBlue,),
          ),
          new Divider(),
          ListTile(
            title: new Text('北京市海淀区中国科技大学',style: TextStyle(fontWeight: FontWeight.w500),),
            subtitle: new Text('胜宏宇:1513938888'),
            leading: new Icon(Icons.account_box, color: Colors.lightBlue,),
          ),
          new Divider(),
          ListTile(
            title: new Text('河南省濮阳市百姓办公楼',style: TextStyle(fontWeight: FontWeight.w500),),
            subtitle: new Text('JSPang:1513938888'),
            leading: new Icon(Icons.account_box, color: Colors.lightBlue,),
          ),
          new Divider(),
        ],
      ),
    );


    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios),
          onPressed: (){
            Navigator.pop(context);
          },
        ),
        title: Text('卡片组件布局'),
      ),
      body: Center(child: card,),
    );
  }
}