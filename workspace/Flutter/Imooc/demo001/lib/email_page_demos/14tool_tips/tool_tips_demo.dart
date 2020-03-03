import 'package:flutter/material.dart';

class ToolTipDemo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('tool tips demo'),),
      body: Center(
        child: Tooltip( //这个效果，长按才会出来文字提示
          message: '不要碰我，我怕牙膏',
          child: Image.asset('images/game1.jpg'),
          //child: Icon(Icons.all_inclusive),
        ),
      ),
    );
  }
}