void main() {
  var person = new Person("Tom", 20, "Male");
}

class Person {
  String name;
  int age;

  final String gender;

  //构造方法 写法4 当有final的属性要在构造方法中初始化时，需要使用下面的构造方法
  Person(this.name, this.age, this.gender);

  Person.withMap(Map map): name = map["name"], gender = map["gender"] {
    age = map["age"];
  }

  void work() {
    print("Work...");
  }
}