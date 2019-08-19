void main(List args) {
  print(args);    // []

  print(getPerson("张三", 18)); //output: name = 张三, age = 18

//  printPerson("李四", 20);  //output: name = 李四, age = 20

  print(printPerson("李四", 20));
  //output:
  //name = 李四, age = 20
  //null

}
//写法1
//String getPerson (String name, int age) {
//  return "name = $name, age = $age";
//}
//写法2
//getPerson (name, age) => "name = $name, age = $age";
//写法3
int gender = 2;
getPerson (name, age) =>  gender == 1 ? "name = $name, age = $age" : "Test";


//写法1
//void printPerson(String name, int age) {
//  print("name = $name, age = $age");
//}
//写法2
printPerson(name, age) {
  print("name = $name, age = $age");
}