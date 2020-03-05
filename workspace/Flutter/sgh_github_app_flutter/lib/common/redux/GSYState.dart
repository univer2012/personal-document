import 'package:sgh_github_app_flutter/common/model/User.dart';
import 'package:sgh_github_app_flutter/common/redux/UserRedux.dart';

class GSYState {

  User userInfo;
  
  GSYState({this.userInfo});
}


GSYState appReducer(GSYState state, dynamic action) {
  return GSYState(
    userInfo: UserReducer(state.userInfo, action),
  );
}