import 'package:flutter/material.dart';

class ExpansionPanelListDemo extends StatefulWidget {
  @override
  _ExpansionPanelListDemoState createState() => _ExpansionPanelListDemoState();
}

class _ExpansionPanelListDemoState extends State<ExpansionPanelListDemo> {
  var currentPanelIndex = -1;
  List<int> mList;  //组成一个int类型数组，用来控制索引
  List<ExpandStateBean> expandStateList; //开展开的状态列表，ExpandStateBean是自定义的类

  _ExpansionPanelListDemoState(){
    mList = new List();
    expandStateList = new List();
    //遍历，为2个List赋值
    for (int i = 0;i < 10;i++) {
      mList.add(i);
      expandStateList.add(ExpandStateBean(i, false));
    }
  }

  _setCurrentIndex(int index, isExpand) {
    setState(() {
      //遍历可展开状态列表
      expandStateList.forEach((item){
        if (item.index == index) {
          //取反
          item.isOpen = !isExpand;
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('expansion panel list'),
      ),
      //加入可滚动组件
      body: SingleChildScrollView(
        child: ExpansionPanelList(
          //交互回掉属性，里边是个匿名函数
          expansionCallback: (index, bol) {
            //调用内部方法
            _setCurrentIndex(index, bol);
          },
          children: mList.map((index){//进行map操作，然后用toList再次组成List
            return ExpansionPanel(
              headerBuilder: (context, isExpanded){
                return ListTile(
                  title: Text('This is No. $index'),
                  subtitle: Text('好的，No. $index'),
                );
              },
              body: ListTile(
                title: Text('expansion no.$index'),
                subtitle: Text('你好，副标题.$index'),
              ),
              isExpanded: expandStateList[index].isOpen
            );
          }).toList(),
        ),
      ),
    );
  }
}
//自定义扩展状态类
class ExpandStateBean {
  var isOpen;
  var index;
  ExpandStateBean(this.index, this.isOpen);
}

