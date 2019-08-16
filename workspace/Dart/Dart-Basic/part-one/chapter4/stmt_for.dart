void main() {

  var list = [1,2,3,4,5];
  for (var index = 0; index < list.length; index ++) {
    print(list[index]);
  }
  /*output:
  * 1
  * 2
  * 3
  * 4
  * 5*/

  print("----------");
  for (var item in list) {
    print(item);
  }
  /*output:
  * 1
  * 2
  * 3
  * 4
  * 5*/

}