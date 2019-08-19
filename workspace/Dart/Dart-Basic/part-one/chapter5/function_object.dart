void main() {

  //var func = printHello;  //方法对象
  Function func = printHello;
  func();   //执行方法

  var list = [1,2,3,4];
  list.forEach(print);



  var list2 = ["h", "e", "l", "l", "o"];
  print(listTimes(list2, times)); // output: [hhh, eee, lll, lll, ooo]

}
void printHello() {
  print("Hello");
}


List listTimes(List list, String times(str)) {
  for (var index = 0; index < list.length; index ++) {
    list[index] = times(list[index]);
  }
  return list;
}

String times(str) {
  return str * 3;
}