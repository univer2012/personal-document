void main() {
  int a = 10;

//  int b;
//
//  b ??= 10;
//  print(b); // 10

  int b = 5;

  b ??= 10;     //  ??=   被一个变量设置初始值。如果有值，则用原来的值。
  print(b); // 5

  a += 2;
  print(a); // 12

  a -= 5;
  print(a); // 7

  print(a *= b);  // 35
//  a /= b;
  print(a ~/= b); // 7
  print(a %= b);  // 2


}