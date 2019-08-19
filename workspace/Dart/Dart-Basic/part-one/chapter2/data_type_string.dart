void main() {
  String str1 = 'Hello';//"Hello"
  String str2 = '''Hello
                   Dart''';
  print(str2);
  /*Hello
                   Dart*/

//  String str3 = 'Hello \n Dart';
//  print(str3);
  /*output：
  * Hello
  *  Dart
  * */
  String str3 = r'Hello \n Dart';
  print(str3);
  //Hello \n Dart


  String str4 = "This is m favorite language";
  print(str4 + "New"); // This is m favorite languageNew
  print(str4 * 5); //复制5遍,输出如下：
  // This is m favorite languageThis is m favorite languageThis is m favorite languageThis is m favorite languageThis is m favorite language

  print(str3 == str4);  // false
  print(str4[0]); // T


  // ======== 插值表达式：`${expression}`
  int a = 1;
  int b = 2;
  print("a + b = ${a + b}");  // a + b = 3
  print("a = $a");  // a = 1


  // ======== 常用属性：`length`、`isEmpty`、`isNotEmpty`
  print(str4.length);   // 27
  print(str4.isEmpty);  // false

  // ======== `contains()`、`subString()`
  print(str4.contains("This")); // true
  print(str4.substring(0,3)); // Thi

  // ======== `startsWith()`、`endsWith()`
  print(str4.startsWith("a"));  // false
  print(str4.endsWith("ge")); // true

  
  var list = str4.split(" ");
  print(list);  // [This, is, m, favorite, language]

  print(str4.replaceAll("This", "That")); // That is m favorite language

}