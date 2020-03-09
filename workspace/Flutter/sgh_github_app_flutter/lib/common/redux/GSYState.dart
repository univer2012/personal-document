import 'package:sgh_github_app_flutter/common/model/User.dart';
import 'package:sgh_github_app_flutter/common/redux/UserRedux.dart';
import 'package:sgh_github_app_flutter/common/redux/EventRedux.dart';
import 'package:sgh_github_app_flutter/widget/EventItem.dart';

class GSYState {

  User userInfo;
  
  List<EventViewModel> eventList = new List();

  GSYState({this.userInfo, this.eventList});
}


GSYState appReducer(GSYState state, dynamic action) {
  return GSYState(
    userInfo: UserReducer(state.userInfo, action),
    eventList: EventReducer(state.eventList, action),
  );
}