import 'package:sgh_github_app_flutter/common/model/User.dart';
import 'package:sgh_github_app_flutter/common/net/Address.dart';
import 'package:sgh_github_app_flutter/common/net/Api.dart';
import 'package:sgh_github_app_flutter/common/redux/EventRedux.dart';
import 'package:sgh_github_app_flutter/common/redux/GSYState.dart';
import 'package:sgh_github_app_flutter/widget/EventItem.dart';
import 'package:redux/redux.dart';

class EventDao {
  static getEventReceived(Store<GSYState> store, {page = 1}) async 
  {
    User user = store.state.userInfo;
    if (user == null || user.login == null) {
      return null;
    }
    String userName = user.login;
    String url = Address.getEventReceived(userName) + Address.getPageParams("?", page);
    var res = await HttpManager.netFetch(url, null, null, null);
    if (res != null && res.result) {
      List<EventViewModel> list = new List();
      var data = res.data;
      if (data == null || data.length == 0) {
        return null;
      }
      for (var i = 0; i < data.length; i++) {
        list.add(EventViewModel.fromEventMap(data[i]));
      }
      if (page == 1) {
        store.dispatch(new RefreshEventAction(list));
      } else {
        store.dispatch(new LoadMoreEventAction(list));
      }
      return list;
    } else {
      return null;
    }

  }
}