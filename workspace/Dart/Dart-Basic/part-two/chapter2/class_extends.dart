import 'person.dart';

void main() {

//  var student = new Student();
//  student.study();  // output: Student study...
//
//  student.name = "Tom";
//  student.age = 16;
//
//  print(student.isAdult);
//  student.run();  // output: Person run...



  Person person = new Student();
  person.name = "Tom";
  person.age = 18;


  if (person is Student) {
    person.study(); // output: Student study...
  }

  print(person);
  // 没有重写时：output: Instance of 'Student'
  //重写后：output: Name is Tom, Age is 18

}

class Student extends Person {
  void study() {
    print("Student study...");
  }

  @override
  bool get isAdult => age > 15;

  @override
  void run() {
    //super.run();
    print("Student run...");
  }

  @override
  String toString() {
    return "Name is $name, Age is $age";
  }
}