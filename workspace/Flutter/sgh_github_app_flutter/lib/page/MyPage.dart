
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:sgh_github_app_flutter/common/redux/GSYState.dart';
// import 'package:sgh_github_app_flutter/widget/userh

class MyPage extends StatelessWidget {
  const MyPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return new StoreConnector<GSYState, String>(
      converter: (store) => store.state.userInfo.name,
      builder: (context, count) {
        return new Text(
          count,
          style: Theme.of(context).textTheme.display1,
        );
      }, 
      
    );
  }
}