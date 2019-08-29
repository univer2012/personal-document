来自：[Flutter免费视频第四季-页面导航和其他](https://jspang.com/posts/2019/02/01/flutter-base4.html)



---

到目前位置，作一个页面已经没有什么问题了，接下来需要学习一下页面间的跳转，学会了这一季内容，就可以从一个单页面的应用制作一个项目了。

不过提前跟小伙伴们说一下，其实这章也是有难度的，因为这跟前端的导航或者说超链接有所不同。如果你能有空杯心态，学习来会容易一点。



## [#](https://jspang.com/posts/2019/02/01/flutter-base4.html#第01节：一般页面导航和返回)第01节：一般页面导航和返回

![](https://raw.githubusercontent.com/univer2012/personal-document/master/Pictures/2019/Flutter/flutter_di4ji_1.jpg)

导航的使用在任何程序里都至关重要，这也是一个程序的灵魂。那这节我们就开始学习导航的知识。



### [#](https://jspang.com/posts/2019/02/01/flutter-base4.html#raisedbutton按钮组件)RaisedButton按钮组件

它有两个最基本的属性：

- child：可以放入容器，图标，文字。让你构建多彩的按钮。
- onPressed：点击事件的相应，一般会调用`Navigator`组件。

**我们在作页面导航时，大量的使用了`RaisedButton`组件，这个组件的使用在实际工作中用的也比较多。**

### [#](https://jspang.com/posts/2019/02/01/flutter-base4.html#navigator-push-和-navigator-pop)Navigator.push 和 Navigator.pop

- `Navigator.push`：是跳转到下一个页面，它要接受两个参数一个是上下文`context`，另一个是要跳转的函数。
- `Navigator.pop`：是返回到上一个页面，使用时传递一个context（上下文）参数，使用时要注意的是，你必须是有上级页面的，也就是说上级页面使用了`Navigator.push`。

### [#](https://jspang.com/posts/2019/02/01/flutter-base4.html#写一个demo)写一个Demo

我们现在就来作一个简单的案例，我们打开一个页面，页面上只有一个简单的按钮，按钮写着“查看商品详情页面”，然后点击后进入下一个页面，页面有一个按钮，可以直接返回。



代码如下：

```dart
import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '导航演示1',
      home: new FirstScreen(),
    );
  }
}

class FirstScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: AppBar(title: Text('导航页面'),),
      body: Center(
        child: RaisedButton(
          child: Text('查看商品详情页面'),
          onPressed: (){
            Navigator.push(context, MaterialPageRoute(
              builder: (context) => new SecondScreen())
              );
          },
        ),
      ),
    );
  }
}

class SecondScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('技术胖商品详情页'),),
      body: Center(child: RaisedButton(
        child: RaisedButton(
          child: Text('返回'),
          onPressed: (){
            Navigator.pop(context);
          },
        ),
      ),),
    );
  }
}
```

填坑，如果是1.0以下版本，热更新的时候会有时不能实现导航，这个需要你重新启动一下虚拟机。



## [#](https://jspang.com/posts/2019/02/01/flutter-base4.html#第02节：导航参数的传递和接收（1）)第02节：导航参数的传递和接收（1）

这节主要学习页面跳转的时候参数的传递和接受。什么是参数的传递和接受那？就是比如我们来到了娱乐场所，然后进来一队漂亮的服务人员，这时候我们需要挑选，服务人员身上的号码或者名称就是我们的参数，当我们把号码告诉给领班，这个小姐姐就可以为我们服务了。

![](https://raw.githubusercontent.com/univer2012/personal-document/master/Pictures/2019/Flutter/flutter_di4ji_2.jpg)

这个挑选小姐姐的过程就是参数的传递和接受，用在程序上解释就是比如你进入一个商品选择列表，当你想选择一个商品的具体信息的时候，你就要传递商品编号，详细页面接受到编号后，显示出不同的内容。



### [#](https://jspang.com/posts/2019/02/01/flutter-base4.html#awesome-flutter-snippets组件的使用)Awesome Flutter snippets组件的使用

因为这节课我们的代码有些多，这时候我们要加快敲代码的速度，可以使用VSCode 中的`Awesome Flutter snippets`插件。它可以帮忙我们快速生成常用的Flutter代码片段。

比如输入`stlss`就会给我们生成如下代码：

```dart
class name extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      
    );
  }
}
```

安装完成后，我们可以看这个插件的说明，可以快速生成很多代码片段，我就不一个个给大家试了，小伙伴们可以自己测试。熟练掌握后，能大大加快我们的代码编写速度。



### [#](https://jspang.com/posts/2019/02/01/flutter-base4.html#声明数据结构类)声明数据结构类

Dart中可以使用类来抽象一个数据，比如我们模仿一个商品信息，有商品标题和商品描述。我们定义了一个Product类，里边有两个字符型变量，title和description。

- title:是商品标题。
- description: 商品详情描述

代码如下:

```dart
class Product {
  final String title; //商品标题
  final String description;//商品描述
  Product(this.title, this.description);
}
```

### 构建一个商品列表

作一个商品的列表，这里我们采用动态的构造方法，在主方法里传递一个商品列表（List）到自定义的Widget中。

先来看看主方法的编写代码:

```dart
void main(){
  runApp(MaterialApp(
    title:'数据传递案例',
    home:ProductList(
      products:List.generate(
        20, 
        (i)=>Product('商品 $i','这是一个商品详情，编号为:$i')
      ),
    )
  ));
}
```

上面的代码是主路口文件，主要是在home属性中，我们使用了ProductList，这个自定义组件，而且时候会报错，因为我们缺少这个组件。这个组件我们传递了一个products参数，也就是商品的列表数据，这个数据是我们用`List.generate`生成的。并且这个生成的List原型就是我们刚开始定义的Product这个类（抽象数据）。

ProductList自定义组件的代码：

```dart
class ProductList extends StatelessWidget{
  final List<Product> products;
  ProductList({Key key,@required this.products}):super(key:key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title:Text('商品列表')),
      body:ListView.builder(
        itemCount:products.length,
        itemBuilder: (context,index){
          return ListTile(
            title:Text(products[index].title),
            onTap:(){
            }
          );
        },
      )
    );
  }
}
```

先接受了主方法传递过来的参数，接受后用`ListView.builder`方法，作了一个根据传递参数数据形成的动态列表。

## [#](https://jspang.com/posts/2019/02/01/flutter-base4.html#第03节：导航参数的传递和接收（2）



已经有了商品列表，下面要做的就是把商品数据传递过去，然后显示商品详情页面。

### 导航参数的传递

我们还是使用`Navigator`组件，然后使用路由`MaterialPageRoute`传递参数，具体代码如下。

```dart
Navigator.push(
  context, 
  MaterialPageRoute(
    builder:(context)=>new ProductDetail(product:products[index])
  )
);
```

这段代码要写在onTap相应事件当中。这时候`ProductDetail`会报错，因为我们还没有生命这个组件或者说是类。

### [#](https://jspang.com/posts/2019/02/01/flutter-base4.html#子页面接受参数并显示)子页面接受参数并显示

现在需要声明`ProductDetail`这个类（组件），先要作的就是接受参数，具体代码如下。

```dart
class ProductDetail extends StatelessWidget {
  final Product product;
  ProductDetail({Key key ,@required this.product}):super(key:key);


  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: AppBar(
        title:Text('${product.title}'),
      ),
      body:Center(child: Text('${product.description}'),)
    );
  }
}
```

先接受了参数，并把数据显示在了页面中。



### Demo全部代码如下

为了更好的帮助大家学习，我把所有的传递参数和接受参数的代码附在了下面。

```dart
import 'package:flutter/material.dart';

//传递的数据结构,也可以理解为对商品数据的抽象
class Product{
  final String title;  //商品标题
  final String description;  //商品描述
  Product(this.title,this.description);
}

void main(){
  runApp(MaterialApp(
    title:'数据传递案例',
    home:ProductList(
      products:List.generate(
        20, 
        (i)=>Product('商品 $i','这是一个商品详情，编号为:$i')
      ),
    )
  ));
}

class ProductList extends StatelessWidget{
  final List<Product> products;
  ProductList({Key key,@required this.products}):super(key:key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title:Text('商品列表')),
      body:ListView.builder(
        itemCount:products.length,
        itemBuilder: (context,index){
          return ListTile(
            title:Text(products[index].title),
            onTap:(){
              Navigator.push(
                context, 
                MaterialPageRoute(
                  builder:(context)=>new ProductDetail(product:products[index])
                )
              );
            }
          );
        },
      )
    );
  }
}

class ProductDetail extends StatelessWidget {
  final Product product;
  ProductDetail({Key key ,@required this.product}):super(key:key);


  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: AppBar(
        title:Text('${product.title}'),
      ),
      body:Center(child: Text('${product.description}'),)
    );
  }
}
```

## [#](https://jspang.com/posts/2019/02/01/flutter-base4.html#第04节：页面跳转并返回数据)第04节：页面跳转并返回数据

这节课学一下页面跳转后，当我们返回页面时返回结果到上一个页面（也就是父页面）。这样的场景经常用于，我们去子页面选择了一项选项，然后把选择的结果返回给父级页面。

这节课要作的例子是这样的，要去找小姐姐，当进入房间后，找到自己喜欢的小姐姐，然后小姐姐给了我们电话，我们这时候就在主页面显示出选择的小姐姐电话。