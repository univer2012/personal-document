void main() {
  printPerson("张三");  //output: name=张三,age=null, gender= null
  printPerson("李四",age: 20);  //output: name=李四,age=20, gender= null
  printPerson("李四",age: 20, gender: "Male");  //output: name=李四,age=20, gender= Male
  printPerson("李四", gender: "Male");  //output: name=李四,age=null, gender= Male


  printPerson2("张三"); //output: name=张三,age=null, gender= null
  printPerson2("张三",18);  //output: name=张三,age=18, gender= null
  printPerson2("张三",18, "Female");  //output: name=张三,age=18, gender= Female
}

printPerson(String name, {int age, String gender}) {
  print("name=$name,age=$age, gender= $gender");
}

printPerson2(String name, [int age, String gender]) {
  print("name=$name,age=$age, gender= $gender");
}