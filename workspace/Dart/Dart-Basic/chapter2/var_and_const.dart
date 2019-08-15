

void main() {
  var a;
  print(a); // null

  a = 10;
  print(a); // 10

  a = 'Hello Dart';
  print(a); // Hello Dart

  var b = 20;
  print(b); //20

  final c = 30;
//  c = "Dart"; // A value of type 'String' can't be assigned to a variable of type 'int'.
//  c = 50; // 'c', a final variable, can only be set once.

  const d = 20;
//  d = 50; // Constan variables can't be assigned a value.
}