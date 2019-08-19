void main() {
  //var person = new Person("Tom", 20, "Male");
  var person = new Person("Tom", 20);
  print(person.name); // output: Tom

  new Person.withName("Jack");
  new Person.withAge(18);

}

class Person {
  String name;
  int age;

  //final String gender;

  //构造方法 写法1
//  Person(String name, int age) {
//    this.name = name;
//    this.age = age;
//  }
  //构造方法 写法2
//  Person(this.name, this.age);

  //构造方法 写法3
//  Person(this.name, this.age) {
//    print(name);
//  }

  //有final属性未初始化时，下面的构造方法是错误的。
//  Person(String name, int age, String gener) {
//    this.name = name;
//    this.age = age;
//    this.gender = gener; // warnning: 'gender' can't be used as a setter because it is final.
//  }

  //构造方法 写法4 当有final的属性要在构造方法中初始化时，需要使用下面的构造方法
  //Person(this.name, this.age, this.gender);
  Person(this.name, this.age);

  //构造方法不能重载：如果重载，会报错：The default constructor is already defined.
  //Person(){}


  // ==== 类名构造方法 写法1
  Person.withName(String name) {
    this.name = name;
  }

  // ==== 类名构造方法 写法2
  Person.withAge(this.age);

  void work() {
    print("Work...");
  }
}