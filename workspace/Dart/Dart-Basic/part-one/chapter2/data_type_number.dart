
void main() {
  num a = 10;
  a = 12.5;

  int b = 20;
//  b = 20.5;


  double c = 10.5;
//  c = 30;

  print(b + c); // 30.5
  print(b - c); // 9.5
  print(b * c); // 210.0
  print(b / c); // 1.9047619047619047
  print(b ~/ c); //1
  print(b % c); // 9.5


  print(0.0 / 0.0); // NaN

  print(b.isEven);  // true  是否偶数
  print(b.isOdd);   // false 是否奇数

  int d = 11;
  print(d.isEven);  // false
  print(d.isOdd);   // true

  // abs()  ->  求绝对值
  int e = -100;
  print(e.abs()); //100

  double f = 10.5;
  print(f.round()); // 11 进行四舍五入
  print(f.floor()); // 10 向下取最大整数
  print(f.ceil());  // 11 向上取最小整数

  print(f.toInt()); // 10 取整数

  print(d.toDouble());  // 11.0
}
