void main() {
  /// 下面构造方法会报错：Const variables must be initialized with a constant value.
  //const person = new Person("Tom", 20, "Male");
  /// 下面构造方法会报错：The constructor being called isn't a const constructor.
  //const person = const Person("Tom", 20, "Male");

  // ====== 常量构造方法

  //const person = const cPerson("Tom", 20, "Male");
  const person = cPerson("Tom", 20, "Male");// const 可省略

  /// 报错：Constant variables can't be assigned a value.
  //person = cPerson();

  person.work();  // output: Work...
}
/*
class Person {
  String name;
  int age;

  final String gender;

  Person(this.name, this.age, this.gender);

  void work() {
    print("Work...");
  }
}
*/
class cPerson {
  final String name;
  final int age;

  final String gender;

  const cPerson(this.name, this.age, this.gender);

  void work() {
    print("Work...");
  }
}

