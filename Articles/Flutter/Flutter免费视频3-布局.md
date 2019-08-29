来自：[Flutter免费视频第三季-布局](https://jspang.com/posts/2019/01/28/flutter-base3.html)



---

## 第01节：水平布局Row的使用

Flutter中的row控件就是水平控件，它可以让Row里边的子元素进行水平排列。

<font color=#FF0000>Row控件可以分为灵活排列和非灵活排列两种</font>，这两种模式都需要熟练掌握，等经验丰富后可根据需求进行使用。



### 非灵活水平布局

从字面上就可以理解到，<font color=#FF0000>不灵活就是根据Row子元素的大小，进行布局</font>。**如果子元素不足，它会留有空隙，如果子元素超出，它会警告。**

比如现在我们要制作三个按钮，并让三个按钮同时在一排。我们写下了如下代码，但你会发现效果并不理想。

```dart
import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title:  'ListView widget',
      home: new Scaffold(
        appBar: new AppBar(
          title: Text('水平方向布局'),
        ),
        body:  new Row(
          children: <Widget>[
            new RaisedButton(
              onPressed: (){

              },
              color: Colors.redAccent,
              child: new Text('红色按钮'),
            ),
            new RaisedButton(
              onPressed: (){

              },
              color: Colors.orangeAccent,
              child: new Text('橙色按钮'),
            ),
            new RaisedButton(
              onPressed: (){

              },
              color: Colors.pinkAccent,
              child: new Text('粉色按钮'),
            ),
          ],
        ),
      ),
    );
  }
}
```

![](https://raw.githubusercontent.com/univer2012/personal-document/master/Pictures/2019/Flutter/flutter_di3ji_1.png)



这时候你会发现的页面已经有了三个按钮，**但这三个按钮并没有充满一行，而是出现了空隙。这就是不灵活横向排列造成的。它根据子元素的大小来进行排列**。如果我们想实现充满一行的效果，就要使用灵活水平布局了。



### 灵活水平布局

解决上面有空隙的问题，可以使用 `Expanded`来进行解决，也就是我们说的灵活布局。我们在按钮的外边加入Expanded就可以了，代码如下：

```dart
body:  new Row(
  children: <Widget>[
    Expanded(child: new RaisedButton(
      onPressed: (){

      },
      color: Colors.redAccent,
      child: new Text('红色按钮'),
    )),
    Expanded(child: new RaisedButton(
      onPressed: (){

      },
      color: Colors.orangeAccent,
      child: new Text('橙色按钮'),
    )),
    Expanded(child: new RaisedButton(
      onPressed: (){

      },
      color: Colors.pinkAccent,
      child: new Text('粉色按钮'),
    )),
  ],
),
```

这时候就可以布满一行了，效果如下图。

![](https://raw.githubusercontent.com/univer2012/personal-document/master/Pictures/2019/Flutter/flutter_di3ji_2.png)

### 灵活和不灵活的混用

如果这时候想让中间的按钮大，而两边的按钮保持真实大小，就可以不灵活和灵活模式进行混用，实现效果。代码和效果如下：

```dart
body:  new Row(
  children: <Widget>[
    new RaisedButton(
      onPressed: (){

      },
      color: Colors.redAccent,
      child: new Text('红色按钮'),
    ),
    Expanded(child: new RaisedButton(
      onPressed: (){

      },
      color: Colors.orangeAccent,
      child: new Text('橙色按钮'),
    )),
    new RaisedButton(
      onPressed: (){

      },
      color: Colors.pinkAccent,
      child: new Text('粉色按钮'),
    ),
  ],
),
```

![](https://raw.githubusercontent.com/univer2012/personal-document/master/Pictures/2019/Flutter/flutter_di3ji_3.png)





## 第02节：垂直布局Column组件

Column组件即垂直布局控件，能够将子组件垂直排列。其实你学会了Row组件就基本掌握了Column组件，里边的大部分属性都一样，我们还是以文字为例子，来看看Column布局。

### olumn基本用法

写一段代码，在column里加入三行文字，然后看一下效果。

```dart
import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title:  'ListView widget',
      home: new Scaffold(
        appBar: new AppBar(
          title: Text('垂直方向布局'),
        ),
        body: Column(
          children: <Widget>[
            Text('I am Sengoln Huang'),
            Text('my website is univer2012'),
            Text('I love coding'),
          ],
        ),
      ),
    );
  }
}
```

这时候你会发现文字是以最长的一段文字居中对齐的，看起来很别扭。那如果想让文字以左边开始对齐，只需要加入一个对齐属性。

![](https://raw.githubusercontent.com/univer2012/personal-document/master/Pictures/2019/Flutter/flutter_di3ji_4.png)

左对齐只要在column组件下加入下面的代码，就可以让文字左对齐。

```dart
crossAxisAlignment: CrossAxisAlignment.start,
```

- CrossAxisAlignment.star：居左对齐。
- CrossAxisAlignment.end：居右对齐。
- CrossAxisAlignment.center：居中对齐。

### 主轴和副轴的辨识

在设置对齐方式的时候你会发现右mainAxisAlignment属性，意思就是主轴对齐方式，那什么是主轴，什么又是副轴呢？

- main轴：**如果你用column组件，那垂直就是主轴，如果你用Row组件，那水平就是主轴。**
- cross轴：**cross轴我们称为副轴，是和主轴垂直的方向**。比如Row组件，那垂直就是幅轴，Column组件的幅轴就是水平方向的。

主轴和幅轴我们搞清楚，才能在实际工作中随心所欲的进行布局。

比如现在我们要把上面的代码，改成垂直方向居中。因为用的是Column组件，所以就是主轴方向，这时候你要用的就是主轴对齐了。

```dart
mainAxisAlignment: MainAxisAlignment.center,
```

现在全部的代码如下：

```dart
import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title:  'ListView widget',
      home: new Scaffold(
        appBar: new AppBar(
          title: Text('垂直方向布局'),
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text('I am Sengoln Huang'),
            Text('my website is univer2012'),
            Text('I love coding'),
          ],
        ),
      ),
    );
  }
}
```

现在的效果如图：

![](https://raw.githubusercontent.com/univer2012/personal-document/master/Pictures/2019/Flutter/flutter_di3ji_5.png)



### 水平方向相对屏幕居中

让文字相对于水平方向居中，我们如何处理？其实只要加入Center组件就可以轻松解决。

```dart
body: Column(
  mainAxisAlignment: MainAxisAlignment.center,
  children: <Widget>[
    Center(child: Text('I am Sengoln Huang')),
    Center(child: Text('my website is univer2012')),
    Center(child: Text('I love coding')),
  ],
),
```



### Expanded属性的使用

其实在学习水平布局的时候我们对Expanded有了深刻的理解，**它就是灵活布局**。比如我们想让中间区域变大，而头部区域和底部根据文字所占空间进行显示。

```dart
				body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Center(child: Text('I am Sengoln Huang')),
            Expanded(child: Center(child: Text('my website is univer2012'))),
            Center(child: Text('I love coding')),
          ],
        ),
```

<font color=#FF0000>在Flutter里的布局个人觉得是很灵活的，但这就和我们写Html+CSS是一样的，我们需要些练习去熟悉它。</font>动手练习一下吧，理论上我们学会了水平和垂直布局，已经可以布出我们想要的任何界面了。



## 第03节：Stack层叠布局

水平布局和垂直布局确实很好用，但是有一种情况是无法完成的，**比如放入一个图片，图片上再写一些字或者放入容器，这时候Row和Column就力不从心了**。Flutter为这种情况准备了Stack层叠布局，这节就主要学习一下。

比如我们现在要作的效果如下：

在头像上方再放入一个容器，容器里边写上字，这时候我们就可以使用Stack布局。

### 层叠布局的-alignment-属性

alignment属性是控制层叠的位置的，建议在两个内容进行层叠时使用。它有两个值X轴距离和Y轴距离，值是从0到1的，都是从上层容器的左上角开始算起的。（视频中具体演示）



### CircleAvatar组件的使用

**`CircleAvatar`这个经常用来作头像的，组件里边有个`radius`的值可以设置图片的弧度**。

现在我们准备放入一个图像，然后把弧度设置成100，形成一个漂亮的圆形，代码如下：

