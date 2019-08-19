void main() {
  //子类初始化会调用父类的无名无参构造方法，所以打印：Person...
  var student = new Student("Tom", "Male");

  print(student.name);  // output: Tom
}

class Person {
  String name;

  Person(this.name);

  Person.withName(this.name);
}

class Student extends Person {
  int age;

  final String gender;

  //Student(String name) : super(name);
  //Student(String name) : super.withName(name); //或者调用父类的`withName`方法


  //下面构造方法会报错：super call must be last in an initializer list (see https://goo.gl/EY6hDP): 'super.withName(name)'.
  //Student(String name, String g) : super.withName(name), gender = g; //错误的写法

  Student(String name, String g) : gender = g, super.withName(name); //正确的写法


}