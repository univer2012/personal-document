import 'package:flutter/material.dart';

class MainAirplayScreen extends StatelessWidget {
  const MainAirplayScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('投屏'),
      ),
      body: Center(
        child: Text('投屏'),
      ),
    );
  }
}