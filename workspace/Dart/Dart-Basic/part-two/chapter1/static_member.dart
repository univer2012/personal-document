void main() {
  var page = new Page();
  //page.scrollDown();  //output: ScrollDown...

  Page.scrollDown();
}

class Page {

  //const int maxPage = 10;//报错：Only static fields can be declared as const.
  static const int maxPage = 10;
  static int currentPage = 1;

  //下滑
  static void scrollDown() {
  //void scrollDown() {

    //如果方法被static修饰，会报错：Instance members can't be accessed from a static method.
    //因为currentPage 不是static的。
    currentPage = 1;
    print("ScrollDown...");
  }

  //上滑
 void scrollUp() {
    currentPage ++;
    print("scrollUp...");
 }
}