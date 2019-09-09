import 'package:flutter/material.dart';

class WarpDemo extends StatefulWidget {
  @override
  _WarpDemoState createState() => _WarpDemoState();
}

class _WarpDemoState extends State<WarpDemo> {
  List<Widget> list; //声明一个list数组

  @override
  //初始化状态，给list添加值，这时候调用了一个自定义方法`buildAddButton`
  void initState() {
    super.initState();
    list = List<Widget>()..add(buildAddBution());
  }

  @override
  Widget build(BuildContext context) {
    //得到屏幕的高度和宽度，用来设置Container的宽和高
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;


    return Scaffold(
      appBar: AppBar(
        title: Text('Warp流式布局'),
      ),
      body: Center(
        child: Opacity(
          opacity: 0.8,
          child: Container(
            width: width,
            height: height / 2,
            color: Colors.grey,
            child: Wrap(    //流式布局
              children: list,
              spacing: 26.0,//设置间距
            ),
          ),
        ),
      ),
    );

  }

  Widget buildAddButon() {

  }

}