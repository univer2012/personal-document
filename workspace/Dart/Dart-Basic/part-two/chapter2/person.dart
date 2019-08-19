class Person {
  String name;
  int age;
  String birthday;

  bool get isAdult => age > 18;

  void run() {
    print("Person run...");
  }
}