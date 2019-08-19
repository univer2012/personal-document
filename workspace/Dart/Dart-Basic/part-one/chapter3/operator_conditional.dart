void main() {
  int gender = 1;
  String str = gender == 0 ? "Male=$gender" : "Female=$gender";
  print(str); //Male=0    Female=1


//  String a;
//  String b = "Java";
//  String c = a ?? b;
//  print(c); // Java

  String a = "Dart";
  String b = "Java";
  String c = a ?? b;  //??    a有值，就取a的值；否则取b的值
  print(c); // Dart
}