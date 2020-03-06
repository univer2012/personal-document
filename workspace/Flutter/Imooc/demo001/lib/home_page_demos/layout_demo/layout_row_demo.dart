import 'package:flutter/material.dart';

import './lay1_inflexible_row.dart';
import './lay2_flexible_row.dart';
import './lay3_mix_inflexible_row.dart';

class LayoutRowPage extends StatelessWidget {
  const LayoutRowPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios),
          onPressed: (){
            Navigator.pop(context);
          },
        ),
        title: Text('水平布局Row'),
      ),
      body: ListView(
        children: <Widget>[
          RaisedButton(
            color: Colors.blue,
            child: Text('1不灵水平布局',style: TextStyle(color: Colors.white),),
            onPressed: (){
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) {
                    return Lay1InflexibleRowPage();
                  },
                  //fullscreenDialog: true,
                ),
              );
            }
          ),

          RaisedButton(
            color: Colors.blue,
            child: Text('2灵活水平布局',style: TextStyle(color: Colors.white),),
            onPressed: (){
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) {
                    return Lay2FlexibleRowPage();
                  },
                  //fullscreenDialog: true,
                ),
              );
            }
          ),
          RaisedButton(
            color: Colors.blue,
            child: Text('3灵活和不灵活的混用',style: TextStyle(color: Colors.white),),
            onPressed: (){
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) {
                    return Lay3MixInflexibleRowPage();
                  },
                  //fullscreenDialog: true,
                ),
              );
            }
          ),
        ],
      ),

    );
  }
}