void main() {
  var func = a();
  func(); //output: 0
  func(); //output: 1
  func(); //output: 2
  func(); //output: 3
}

a() {
  int count = 0;


//  printCount() {
//    print(count++);
//  }
//  return printCount;

  return () {
    print(count++);
  };
}