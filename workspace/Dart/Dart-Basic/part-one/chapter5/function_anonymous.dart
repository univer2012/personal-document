void main() {
  // ======== 无参
  //匿名方法实现
//  var func = () {
//    print("Hello");
//  };
//  func();//匿名方法调用
//  //output: Hello

  // ======== 有参
  var func = (str) {
    print("Hello --- $str");
  };
  func(30);//匿名方法调用
  //output: Hello --- 30


  // ========= 匿名方法作为 匿名方法的参数 被调用
//  (() {
//    print("Test");
//  })();
  // output: Test


  // ========= 匿名方法作为 方法的参数 被调用
  var list2 = ["h", "e", "l", "l", "o"];
  var result = listTimes(list2, (str){ return str * 3;});
  print(result); // output: [hhh, eee, lll, lll, ooo]


  print(listTimes2(list2));
  // output: [hhhhhhhhh, eeeeeeeee, lllllllll, lllllllll, ooooooooo]
}


List listTimes(List list, String times(str)) {
  for (var index = 0; index < list.length; index ++) {
    list[index] = times(list[index]);
  }
  return list;
}

List listTimes2(List list) {
  var func = (str) { return str * 3; };
  for (var index = 0; index < list.length; index ++) {
    list[index] = func(list[index]);
  }
  return list;
}
