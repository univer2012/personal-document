import 'package:flutter/material.dart';

class MainAlarmScreen extends StatelessWidget {
  const MainAlarmScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('报警'),
      ),
      body: Center(
        child: Text('报警'),
      ),
    );
  }
}