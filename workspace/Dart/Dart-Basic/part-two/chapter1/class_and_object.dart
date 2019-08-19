import 'Person.dart';

void main() {
  var person = new Person(); //warnning: Undefined class 'Person'.
//  var person = Person();  //new可省略
  person.name = "Tom";
  person.age = 20;
  //person.address = "china";// 'address' can't be used as a setter because it is final.

  print(person.name); // output: Tom
//  print(person.address);  //如果final的address没有初始化，获取address会崩溃
  person.work();  // output: Name is Tom, Age is 20,He is working...



}


