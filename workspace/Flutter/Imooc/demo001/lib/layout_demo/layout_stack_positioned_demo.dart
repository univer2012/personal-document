import 'package:flutter/material.dart';

class LayoutStackPositionedPage extends StatelessWidget {
  const LayoutStackPositionedPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    var stack = new Stack(
      children: <Widget>[
        new CircleAvatar(
          backgroundImage: new NetworkImage('https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1582285344711&di=26a59216f97df2a3df8e8f4e3d627fdc&imgtype=0&src=http%3A%2F%2Fpic3.zhimg.com%2F50%2Fv2-381570a67d5418397357346cd1cc7aa4_hd.jpg'),
          radius: 100.0,
        ),
        new Positioned(
          top: 10.0,
          left: 10.0,
          child: new Text('JSPang.com'),
        ),
        new Positioned(
          bottom: 10.0,
          right: 10.0,
          child: new Text('技术胖'),
        ),
      ],
      //是不是觉的有了层叠布局，我们在Flutter中的布局就更加灵活了那。小伙伴们可以动手实现一个你常见的布局效果。
    );

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios),
          onPressed: (){
            Navigator.pop(context);
          },
        ),
        title: Text('Stack的Positioned属性-层叠布局'),
      ),

      body: Center(child: stack),
    );
  }
}