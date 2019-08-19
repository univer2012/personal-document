void main() {

  /*
  Person person = new Person();
  //person.work();
  //报错：NoSuchMethodError: The method 'work' was called on null.
  //应改为：
  person?.work(); //有实例化person，就会输出：Work...    没有实例化person，则不执行work方法。
  */


  /*
  var person;
  person = "";
  person = new Person();

//  (person as Person).work();  //output: Work...

  if (person is Person) {
    person.work();
  }
  //有疑问的地方： is 和 is! 的区别
  */


  // ====== 级联操作
  var person = new Person();


  //person.name = "Tom";
  //person.age = 20;
  //person.work();
  //与下面的级联操作等价：
  new Person()..name = "Tome"..age = 20 ..work();



}

class Person {
  String name;
  int age;

  void work() {
    print("Work...$name, $age");
  }
}