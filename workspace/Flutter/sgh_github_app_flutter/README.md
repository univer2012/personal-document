# sgh_github_app_flutter

A new Flutter project.


## Getting Started
For help getting started with Flutter, view our online
[documentation](https://flutter.io/).
准备：网络请求库使用dio、flutter-redux、sqflite、css_colors
在哪里存储字符串? 如何存储不同的语言
目前，最好的做法是创建一个名为Strings的类
class Strings{
  static String welcomeMessage = "Welcome To Flutter";
}
然后在你的代码中，你可以像访问你的字符串一样：new Text(Strings.welcomeMessage)


welcome -> login
welcome -> login

生成序列化模板
```
flutter packages pub run build_runner build
```
具体请查看：[JSON和序列化 ](https://flutterchina.club/json/#manual-serialization)




### 配合AutomaticKeepAliveClientMixin可以keep住tab