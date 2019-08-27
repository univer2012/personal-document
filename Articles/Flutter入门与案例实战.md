# Flutter入门与案例实战

### 2-5 手把手教你写一个HelloWrold程序
1. 手把手带着大家写一个HelloWorld程序
2. StatefullWidget和StatelessWidget区别
3. VSCode中常用快捷键和热加载方法

#### 升级FlutterSDK
1. 在终端使用 `flutter upgrade`
2. 删除SDK包重新下载

#### VSCode中常用快捷键
1. R键：点击后热加载，直接查看预览效果
2. P键：在虚拟机显示网格，工作中经常使用
3. O键：切换Android和iOS的预览模式
4. Q键：退出调试预览模式

```dart
import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Welcome to Flutter',
      home: Scaffold(
        appBar: AppBar(
          title:  Text('Hello World'),
        ),
        body: Center(
          child: Text('Hello World imooc!'),
        ),
      ),  
    )
  }
}
```


### 3-1 TextWidget文本组件
1. 手把手使用一个最简单的TextWidget
2. TextWidget常用属性
3. Style属性的用法，让文本漂亮起来

#### TextWidget的常用属性
1. TextAlign：文本对齐属性
2. maxLines:文本显示的最大行数
3. overflow：控制文本的溢出效果
4. 
