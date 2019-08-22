void main() {
  var list = new List<int>();

  list.add(1);

//  var utils = new Utils<int>();
//  utils.put(1);

  var utils = new Utils();
  utils.put<int>(1);
}

/*
class Utils {
  int element;
  String elementStr;

  void putInt(int element) {
    this.element = element;
  }

  void putString(String elementStr) {
    this.elementStr = elementStr;
  }
}
*/

///把上面的类使用泛型改造为：
/// 改造1
/*
class Utils<T {
  T element;

  void put(T element) {
    this.element = element;
  }
}
*/
/// 改造2
class Utils {
  void put<T>(T element) {
    print(element);
  }
}