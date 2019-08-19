

void main() {
  //抽象类不能实例化。下面代码会报错： Abstract classes can't be created with a 'new' expression.
  //var person = new Person();

  var person = new Student();
  person.run(); // output: run ...

}

abstract class Person {
  void run();
}

class Student extends Person {
  @override
  void run() {
    print("run ...");
  }
}