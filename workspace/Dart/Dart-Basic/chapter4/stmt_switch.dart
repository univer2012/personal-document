void  main() {
  String language = "Java";
  switch (language) {
    case "Dart":
      print("Dart is my favrite");
      break;
    case "Java":
      print("Java is my favrite");
      break;
    case "Python":
      print("Python is my favrite");
      break;
    default:
      print("None");
  }


  // ======= `continue`跳转标签
  switch (language) {
    Test:
    case "Dart":
      print("Dart is my favrite");
      break;
    case "Java":
      print("Java is my favrite");
      continue Test;
//      break;
    case "Python":
      print("Python is my favrite");
      break;
    default:
      print("None");
  }
  /*output:
  Java is my favrite
  Dart is my favrite   */
}