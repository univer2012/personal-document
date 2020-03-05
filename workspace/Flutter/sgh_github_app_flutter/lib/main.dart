import 'package:flutter/material.dart';
import 'package:sgh_github_app_flutter/common/style/GSYStyle.dart';
import 'package:sgh_github_app_flutter/page/WelcomePage.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: GSYColors.primarySwatch,
      ),
      home: new WelcomePage()
    );
  }
}

