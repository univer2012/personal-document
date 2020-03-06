import 'package:meta/meta.dart';
/// ========== 第一步：添加依赖

/// ========== 第二步：创建State
/**
 * State中所有属性偶读应该是只读的
 */
@immutable
class CountState {
  int count;
  //get count => _count;

  CountState(this.count);

  CountState.initState(){ count = 0; }
}

/// ========== 第三步：创建action
/**
 * 定义操作该State的全部Action
 * 这里只有增加count一个动作
 */
enum CountAction {
  increment
}


/// ========== 第四步：创建reducer
/**
 * reducer会根据传进来的action生成新的CountState
 */
CountState reducer(CountState state,action) {
  //匹配Action
  if (action == CountAction.increment) {
    state.count += 1;
    return CountState(state.count);
  }
  return state;
}


/// ========== 第五步：创建store
// 这段代码写在State中
// CountState.initState(){ _count = 0; }
