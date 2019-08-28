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

```dart
import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'TextWidget',
      home: Scaffold(
        appBar: AppBar(
          title:  Text('TextWidget'),
        ),
        body: Center(
          child: Text(
            '慕课网（IMOOC）是IT技能学习平台，慕课网（IMOOC）提供了丰富的移动端开发，php开发，web前端，android开发以及html5等视频教程资源公开课，并且富有交互性及趣味性，你还可以和朋友一起编程。',
            textAlign: TextAlign.left,
            maxLines: 2,
            overflow: TextOverflow.fade,
            ),
        ),
        
      ),  
    );
  }
}
```



`TextStyle`：

```dart
//...
body: Center(
  child: Text(
    '慕课网（IMOOC）是IT技能学习平台，慕课网（IMOOC）提供了丰富的移动端开发，php开发，web前端，android开发以及html5等视频教程资源公开课，并且富有交互性及趣味性，你还可以和朋友一起编程。',
    style: TextStyle(
      fontSize: 25.0 //字体大小
      color: Color.fromARGB(255, 255, 150, 150),//文字颜色
      decoration: TextDecoration.underline,//装饰：下横线
      decorationStyle: TextDecorationStyle.solid,//装饰类型：实体
    ),
    ),
),
//...
```

### 3-2 ContainerWidget容器组件讲解-1

1. Alignment属性的使用
2. 设置宽高和颜色

```dart
//...
body: Center(
  child: Container(
    child: new Text(
      'Hello Imooc',
      style: TextStyle(
        fontSize:  40.0,
      ),
    ),
    alignment: Alignment.center,
    width: 300.0,
    height: 400.0,
    color: Colors.lightBlue,
  )
),
//...
```

### 3-3 ContainerWidget容器组件讲解-2
1. Padding内边距属性的使用
2. margin外边距属性的使用
3. decoration属性制作彩色背景

#### padding内边距属性
1. EdgeInsets.all()：统一设置
2. EdgeInsets.fromLTRB(value1,value2,value3,value4)

#### decoration修饰器
1. 设置容器的边框
2. BoxDecoration Widget讲解
3. LinearGradient设置背景颜色渐变

```dart
				body: Center(
          child: Container(
            child: new Text(
              '慕课网（IMOOC）是IT技能学习平台，慕课网（IMOOC）提供了丰富的移动端开发，php开发，web前端，android开发以及html5等视频教程资源公开课，并且富有交互性及趣味性，你还可以和朋友一起编程。',
              style: TextStyle(
                fontSize:  40.0,
              ),
            ),
            alignment: Alignment.topLeft,
            width: 500.0,
            height: 400.0,
            color: Colors.lightBlue,
            padding: const EdgeInsets.fromLTRB(10.0, 30.0, 0.0, 0.0),
            margin: const EdgeInsets.all(10.0),
          )
        ),
```

`BoxDecoration`：

```dart
				child: Container(
            child: new Text(
              '慕课网（IMOOC）是IT技能学习平台，慕课网（IMOOC）提供了丰富的移动端开发，php开发，web前端，android开发以及html5等视频教程资源公开课，并且富有交互性及趣味性，你还可以和朋友一起编程。',
              style: TextStyle(
                fontSize:  40.0,
              ),
            ),
            alignment: Alignment.topLeft,
            width: 500.0,
            height: 400.0,
            padding: const EdgeInsets.fromLTRB(10.0, 30.0, 0.0, 0.0),
            margin: const EdgeInsets.all(10.0),
            decoration: new BoxDecoration(
              gradient: const LinearGradient(
                colors: [
                  Colors.lightBlue,
                  Colors.greenAccent,
                  Colors.purple,
                ],
              ),
            ),
          )
```

### 3-4 ImageWidget图片组件讲解

#### Image图片组件的使用

1. Image Widget的几种加入形式
2. Fit属性的详细讲解
3. 图片的混合模式
4. Repeat属性让图片重复

#### Image Widget的几种加入形式

1. Image.asset：加载资源图片，会使打包时包体过大
2. Image.network：网络资源图片，经常换的或者动态的图片
3. Image.file：本地图片，比如相机照相后的图片预览
4. Image.memory：加载到内存中的图片，Uint8List

```dart
child: Container(
  child: new Image.network(
    'https://img4.mukewang.com/szimg/5d1032ab08719e0906000338-360-202.jpg',
    scale: 1.5, //压缩比例
    fit: BoxFit.scaleDown,//适配
  ),
  width: 400.0,
  height: 300.0,
  color: Colors.lightBlue,
)
```

图片的混合模式：

```dart
child: Container(
  child: new Image.network(
    'https://img4.mukewang.com/szimg/5d1032ab08719e0906000338-360-202.jpg',
    scale: 2.0, //压缩比例
    color: Colors.greenAccent,
    colorBlendMode: BlendMode.difference, //modulate,//混合模式
  ),
  width: 400.0,
  height: 300.0,
  color: Colors.lightBlue,
)
```

图片重复：

```dart
child: Container(
  child: new Image.network(
    'https://img4.mukewang.com/szimg/5d1032ab08719e0906000338-360-202.jpg',
    scale: 2.0, //压缩比例
    repeat: ImageRepeat.repeatY, //repeat：XY重复; repeatX:X重复; repeatY:Y重复
  ),
  width: 400.0,
  height: 300.0,
  color: Colors.lightBlue,
)
```



### 3-5 ListView组件的使用

1. ListView组件的语法讲解
2. ListTitle的使用
3. 小实例 做一个图片列表

```dart
home: Scaffold(
  appBar:  new AppBar(
    title:  new Text('ListVew Widget'),
  ),
  body: new ListView(
    children: <Widget>[
      new ListTile(
        leading: new Icon(Icons.border_right),
        title: new Text('border_right'),
      ),
      new ListTile(
        leading: new Icon(Icons.android),
        title: new Text('android'),
      ),
      new ListTile(
        leading: new Icon(Icons.arrow_back_ios),
        title: new Text('arrow_back_ios'),
      ),
    ],
  ),

),
```



3、做一个图片列表

```dart
home: Scaffold(
  appBar:  new AppBar(
    title:  new Text('ListVew Widget'),
  ),
  body: new ListView(
    children: <Widget>[
      new Image.network('https://img1.mukewang.com/szimg/5d5b6dd109a8f14512000676-360-202.png'),
      new Image.network('https://img4.mukewang.com/szimg/59b8a486000107fb05400300-360-202.jpg'),
      new Image.network('https://img2.mukewang.com/szimg/5c18d2d8000141c506000338-360-202.jpg'),
      new Image.network('https://img4.mukewang.com/szimg/5d1032ab08719e0906000338-360-202.jpg'),
      new Image.network('https://img2.mukewang.com/szimg/5d31765d08c90cba06000338-360-202.jpg'),
    ],
  ),

),
```



### 3-6 横向列表和自定义组件讲解

#### 横向列表的使用

1. 制作横向列表，小例子
2. scrollDirection属性的讲解
3. 代码优化，自定义组件



#### scrollDirection属性讲解

1. Axis.horizontal：横向滚动或者叫水平方向滚动
2. Axis.vertical：纵向滚动或者叫垂直方向滚动

===== 横向滚动：

```dart
home: Scaffold(
  appBar:  new AppBar(
    title:  new Text('ListVew Widget'),
  ),
  body: Center(
    child: Container(
      height: 200.0,
      child: new ListView(
        scrollDirection: Axis.horizontal,
        children: <Widget>[
          new Container(
            width: 180.0,
            color: Colors.lightBlue,
          ),
          new Container(
            width: 180.0,
            color: Colors.amber,
          ),
          new Container(
            width: 180.0,
            color: Colors.deepOrange,
          ),
          new Container(
            width: 180.0,
            color: Colors.deepPurpleAccent,
          ),
        ],
      ),
    ),
  ),

),
```



=====代码优化，自定义组件:

```dart
//...
home: Scaffold(
  appBar:  new AppBar(
    title:  new Text('ListVew Widget'),
  ),
  body: Center(
    child: Container(
      height: 200.0,
      child: MyList(),
    ),
  ),
),
//...

class MyList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView(
      scrollDirection: Axis.horizontal,
        children: <Widget>[
          new Container(
            width: 180.0,
            color: Colors.lightBlue,
          ),
          new Container(
            width: 180.0,
            color: Colors.amber,
          ),
          new Container(
            width: 180.0,
            color: Colors.deepOrange,
          ),
          new Container(
            width: 180.0,
            color: Colors.deepPurpleAccent,
          ),
        ],
    );
  }
}
```



### 3-7 动态列表的使用

#### 动态列表的使用

1. Dart中List类型的使用
2. 传递和接受参数，实现动态列表的基础
3. 动态列表案例制作

#### Dart中List的使用

1. List类型简介，可以简单理解为js中的数组
2. 声明List的4中方式



#### 参数的传递和接受

1. 如何传递参数
2. 如何接受参数



```dart
void main() => runApp(MyApp(
  items: new List<String>.generate(1000, (i)=>'Item $i')
));

class MyApp extends StatelessWidget {

final List<String> items;
MyApp({Key key, @required this.items}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'IMooc Flutter Demo',
      home: Scaffold(
        appBar:  new AppBar(
          title:  new Text('ListVew Widget'),
        ),
        body: new ListView.builder(
          itemCount: items.length,
          itemBuilder: (context, index){
            return new ListTile(
              title: new Text('${items[index]}'),
            );
          },
        ),

      ),
    );
  }
}
```



### 4-1 电影海报实例代码基本结构的建立

#### 电影海报实例制作

1. GridView网格列表的使用
2. 图片网格列表的使用
3. 手把手实例的编写和讲解

```dart
import 'package:flutter/material.dart';

void main()=> runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '电影海报实例',
      home: Scaffold(
        body: Text('电影海报实例'),
        appBar: new AppBar(
          title: Text('电影海报实例'),
        ),
      ),
    );
  }
}
```



### 4-2 电影海报实例代码GridViewWidget学习

#### GridView Widget

1. padding：设置内边距的属性
2. crossAxisSpacing：网格间的空隙
3. crossAxisCount：网格的列数

```dart
home: Scaffold(
  appBar: new AppBar(
    title: Text('电影海报实例'),
  ),
  body: GridView.count(
    padding: const EdgeInsets.all(10.0),//内间距
    crossAxisSpacing: 10.0, //列之间的空隙
    crossAxisCount: 3,//列数
    children: <Widget>[
      const Text('I love IMooc'),
      const Text('I love IMooc'),
      const Text('I love IMooc'),
      const Text('I love IMooc'),
      const Text('I love IMooc'),
      const Text('I love IMooc'),
    ],
  ),
),
```



### 4-3 电影海报图片的加入与课程总结

```dart
home: Scaffold(
  appBar: new AppBar(
    title: Text('电影海报实例'),
  ),
  body: GridView(
    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
      crossAxisCount: 3,
      mainAxisSpacing: 2.0, //主轴间距
      crossAxisSpacing: 2.0,//副轴间距
      childAspectRatio: 0.7,
    ),
    children: <Widget>[
      new Image.network('https://img3.doubanio.com/view/photo/s_ratio_poster/public/p2566618190.jpg',fit: BoxFit.cover,),
      new Image.network('https://img3.doubanio.com/view/photo/s_ratio_poster/public/p2551393832.jpg',fit: BoxFit.cover,),
      new Image.network('https://img3.doubanio.com/view/photo/s_ratio_poster/public/p2555084871.jpg',fit: BoxFit.cover,),

      new Image.network('https://img3.doubanio.com/view/photo/s_ratio_poster/public/p2547108654.jpg',fit: BoxFit.cover,),
      new Image.network('https://img3.doubanio.com/view/photo/s_ratio_poster/public/p2555952192.jpg',fit: BoxFit.cover,),
      new Image.network('https://img3.doubanio.com/view/photo/s_ratio_poster/public/p2551119672.jpg',fit: BoxFit.cover,),

      new Image.network('https://img3.doubanio.com/view/photo/s_ratio_poster/public/p2553992741.jpg',fit: BoxFit.cover,),
      new Image.network('https://img3.doubanio.com/view/photo/s_ratio_poster/public/p2545020183.jpg',fit: BoxFit.cover,),
      new Image.network('https://img3.doubanio.com/view/photo/s_ratio_poster/public/p2554370800.jpg',fit: BoxFit.cover,),

      new Image.network('https://img1.doubanio.com/view/photo/s_ratio_poster/public/p2564832427.jpg',fit: BoxFit.cover,),
      new Image.network('https://img3.doubanio.com/view/photo/s_ratio_poster/public/p2563766934.jpg',fit: BoxFit.cover,),
      new Image.network('https://img1.doubanio.com/view/photo/s_ratio_poster/public/p2565063457.jpg',fit: BoxFit.cover,),
    ],
  ),
),
```



测试diff：

```diff
  class _TodoListState extends State<TodoList> {
    List<Todo> todos = [];

+   _buildItem() {}
+
    @override
    Widget build(BuildContext context) {
-     return Container();
+     return ListView.builder(
+       itemBuilder: _buildItem,
+       itemCount: todos.length,
+     );
    }
  }
```
