import 'package:flutter/material.dart';

class LayoutStackPage extends StatelessWidget {
  const LayoutStackPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    var stack = new Stack(
      alignment: const FractionalOffset(0.5, 0.8),
      children: <Widget>[
        new CircleAvatar(
          backgroundImage: new NetworkImage('https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1582285344711&di=26a59216f97df2a3df8e8f4e3d627fdc&imgtype=0&src=http%3A%2F%2Fpic3.zhimg.com%2F50%2Fv2-381570a67d5418397357346cd1cc7aa4_hd.jpg'),
          radius: 100.0,
        ),
        new Container(
          decoration: new BoxDecoration(
            color: Colors.lightBlue,
          ),
          padding: EdgeInsets.all(5.0),
          child: new Text('JSPang 技术胖'),
        ),
      ],
    );

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios),
          onPressed: (){
            Navigator.pop(context);
          },
        ),
        title: Text('Stack层叠布局'),
      ),

      body: Center(child: stack),
    );
  }
}