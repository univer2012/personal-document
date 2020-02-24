import 'package:flutter/material.dart';
import 'bottom_navigation_widget.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Text widget',
      home: Scaffold(
        body: Center(
          child: Text('Hello JSPang'),
        ),
      ),
    );



    // ========原来的
    // return MaterialApp(
    //   title: 'Flutter bottomNavigationBar',
    //   theme: ThemeData.light(),
    //   home: BottomNavigationWidget(),
    // );
  }
}