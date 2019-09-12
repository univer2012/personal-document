import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
class RightBackDemo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      //appBar: AppBar(title: Text('首页'),),
      child: Center(
        child: Container(
          height: 100.0,
          width: 100.0,
          color: CupertinoColors.activeBlue,
          child: CupertinoButton(
            child: Icon(CupertinoIcons.add),
            onPressed: (){
              CupertinoPageRoute(builder: (BuildContext context){
                return RightBackDemo();
              });
            },
          ),
        ),
      ),
    );
  }
}