
import 'dart:math';

class Person {
  final _name;

  Person(this._name);

  String greet(who) => 'Hello, $who. I am $_name';
}

class Imposter implements Person {
  final _name = "";

  String greet(who) => 'Hi $who. Do you know who I am?';
}
greetBob(Person person) => person.greet('bob');

void main() {
  print(greetBob(new Person('kathy')));
  print(greetBob(new Imposter()));
}

@proxy
class A {
  void noSuchMethod(Invocation mirror) {
    // ...
  }
}