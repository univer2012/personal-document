# 第07节：dio基础_POST请求的使用



home_page.dart的代码：

```dart
import 'package:flutter/material.dart';

import 'package:dio/dio.dart';


class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  TextEditingController typeController = TextEditingController();
  String showText = "欢迎你来到美好人间";


  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
        appBar: AppBar(title: Text('美好人间'),),
        body: SingleChildScrollView(
          //height: 1000,
          child: Column(
            children: <Widget>[
              TextField(
                controller: typeController,
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.all(10.0),
                  labelText: '美女类型',
                  helperText: '请输入你喜欢的类型',
                ),
                autofocus: false,
              ),
              RaisedButton(
                onPressed: _choiceAction,
                child: Text('选择完毕'),
              ),

              Text(
                showText,
                overflow: TextOverflow.ellipsis,
                maxLines: 2,
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _choiceAction(){
    print('开始选择你喜欢的类型.........');
    if (typeController.text.toString() == '') {
      showDialog(
        context: context,
        builder: (context)=>AlertDialog(title: Text('美女类型不能为空'),)
      );
    } else {
      getHttp(typeController.text.toString()).then((val){
        setState(() {
          showText = val['data']['name'].toString();
        });
      });
    }
  }

  Future getHttp(String TypeText)async{
    try {
      Response response;
      var data = {'name':TypeText};
      // response = await Dio().post(
      //   "https://www.easy-mock.com/mock/5c60131a4bed3a6342711498/baixing/post_dabaojian",
      //   queryParameters:data
      // );
      //get请求
      response = await Dio().get(
        "https://www.easy-mock.com/mock/5c60131a4bed3a6342711498/baixing/dabaojian",
        queryParameters:data
      );
      
      return response.data;
    }catch(e){
      return print(e);
    }
  }
}


/*
class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    getHttp();
    return Scaffold(
      body: Center(
        child: Text('商城首页'),
      ),
    );
  }

  void getHttp()async{
    try{
      Response response;
      var data = {'name':'技术胖'};
      response = await Dio().get(
        "https://www.easy-mock.com/mock/5c60131a4bed3a6342711498/baixing/dabaojian?name=大胸美女",
        //  queryParameters:data
      );
      return print(response);
    }catch(e){
      return print(e);
    }
  }
}
*/
```

## 第08节:dio基础_伪造请求头获取数据

在很多时候，后端为了安全都会有一些请求头的限制，只有请求头对了，才能正确返回数据。这虽然限制了一些人恶意请求数据，但是对于我们聪明的程序员来说，就是形同虚设。这节课就以`极客时间`为例，讲一下通过伪造请求头，来获取`极客时间`首页主要数据。（不保证接口和安全措施一直可用哦，赶快练习吧）

这节学完，大家就应该知道如何读取别人的端口数据了，比如你学完这个实战课，想自己作一个掘金或者极客时间，这都是很简单的事情了。



### 查看极客时间的数据端口

如果你是一个前端，这套流程可能已经烂熟于心，先找出掘金的一个端口，来进行分析。

首先在浏览器端打开掘金网站（我用的是chrome浏览器）:`https://time.geekbang.org/`,然后按F12打开浏览器控制台，来到`NetWork`选项卡，再选择`XHR`选项卡，这时候刷新页面就会出现异步请求的数据。我们选择`newAll`这个接口来进行查看。

拷贝地址：`https://time.geekbang.org/serv/v1/column/newAll`

我们就以这个接口为案例，来获取它的数据。

### [#](https://jspang.com/posts/2019/03/01/flutter-shop.html#非法请求的实现)非法请求的实现

有了接口，我们把上节课的页面进行一下改造。注意的是，这时候我们并没有设置请求头，为的是演示我们不配置请求头时，是无法获取数据的,它会返回一个`451`的错误。

`451`:就是非法请求，你的请求不合法，服务器决绝了请求，也什么都没给我们返回。

代码如下：

```text
import 'package:flutter/material.dart';
import 'package:dio/dio.dart';


class HomePage extends StatefulWidget {
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String showText='还没有请求数据';
  @override
  Widget build(BuildContext context) {
    return Container(
       child: Scaffold(
         appBar: AppBar(title: Text('请求远程数据'),),
         body: SingleChildScrollView(
           child: Column(
             children: <Widget>[
               RaisedButton(
                 onPressed: _jike,
                 child: Text('请求数据'),
               ),
               Text(showText)
             ],
           ),
         ),
       ),
    );
  }

  void _jike(){
    print('开始向极客时间请求数据..................');
    getHttp().then((val){
      setState(() {
       showText=val['data'].toString();
      });
    });
  }


  Future getHttp()async{
    try{
      Response response;
      Dio dio = new Dio(); 
      response =await dio.get("https://time.geekbang.org/serv/v1/column/newAll");
      print(response);
      return response.data;
    }catch(e){
      return print(e);
    }
  }

}
```

这时候我们预览，会返现控制台无情的输出了异常消息。

```text
I/flutter ( 6942): DioError [DioErrorType.RESPONSE]: Http status error [451]
E/flutter ( 6942): [ERROR:flutter/shell/common/shell.cc(184)] Dart Error: Unhandled exception:
```

### [#](https://jspang.com/posts/2019/03/01/flutter-shop.html#伪造请求头)伪造请求头

新建一个文件夹，起名叫作`config`，然后在里边新建一个文件`httpHeaders.dart`,把请求头设置好，请求头可以在浏览器中轻松获得，获得后需要进行改造。

```text
const httpHeaders={
  'Accept': 'application/json, text/plain, */*',
'Accept-Encoding': 'gzip, deflate, br',
'Accept-Language': 'zh-CN,zh;q=0.9',
'Connection': 'keep-alive',
'Content-Type': 'application/json',
'Cookie': '_ga=GA1.2.676402787.1548321037; GCID=9d149c5-11cb3b3-80ad198-04b551d; _gid=GA1.2.359074521.1550799897; _gat=1; Hm_lvt_022f847c4e3acd44d4a2481d9187f1e6=1550106367,1550115714,1550123110,1550799897; SERVERID=1fa1f330efedec1559b3abbcb6e30f50|1550799909|1550799898; Hm_lpvt_022f847c4e3acd44d4a2481d9187f1e6=1550799907',
'Host': 'time.geekbang.org',
'Origin': 'https://time.geekbang.org',
'Referer': 'https://time.geekbang.org/',
'User-Agent': 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/70.0.3538.77 Safari/537.36'
};
```

有了请求头文件后，可以修改主体文件，修改就是引入请求头文件，并进行设置，主要代码就这两句。

```text
import '../config/httpHeaders.dart';
dio.options.headers= httpHeaders;
```

全部代码如下：

```dart
import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import '../config/httpHeaders.dart';

class HomePage extends StatefulWidget {
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String showText='还没有请求数据';
  @override
  Widget build(BuildContext context) {
    return Container(
       child: Scaffold(
         appBar: AppBar(title: Text('请求远程数据'),),
         body: SingleChildScrollView(
           child: Column(
             children: <Widget>[
               RaisedButton(
                 onPressed: _juejin,
                 child: Text('请求数据'),
               ),
               Text(showText)
             ],
           ),
         ),
       ),
    );
  }

  void _juejin(){
    print('开始向极客时间请求数据..................');
    getHttp().then((val){
      setState(() {
       showText=val['data'].toString();
      });
    });
  }


  Future getHttp()async{
    try{
      Response response;
      Dio dio = new Dio();
      dio.options.headers= httpHeaders;
      response =await dio.get("https://time.geekbang.org/serv/v1/column/newAll");
      print(response);
      return response.data;
    }catch(e){
      return print(e);
    }
  }

}
```

现在就可以正常获取数据了。

**课程总结**： 本节主要学习了Dio中如何通过伪造请求头来获取别人接口的数据，学会了这个是非常有用的，以后我们想自己作练习Demo时就不用为后端接口而犯愁了。当然课程里查看接口的方法比较初级，我们可以使用向Fiddler这样的专用软件来获得接口。因为Fiddler不是课程内容，所以感兴趣的小伙伴就自行学习吧。

## [#](https://jspang.com/posts/2019/03/01/flutter-shop.html#第09节：移动商城数据请求实战（好戏开始）)第09节：移动商城数据请求实战（好戏开始）

前几节已经对Dio的基础知识作了讲解，当然Dio还有一些比较高级的用法，这些用法就不单独拿出来讲了，在项目中遇到后再详细讲解。从这节开始，我们来制作商城的首页，那制作商城的首页第一步还是需要从后端接口获取需要使用的记录。

视频链接地址：https://m.qlchat.com/topic/details?topicId=2000003709189599

### [#](https://jspang.com/posts/2019/03/01/flutter-shop.html#url接口管理文件建立)URL接口管理文件建立

第一步需要在建立一个URL的管理文件，因为课程的接口会一直进行变化，所以单独拿出来会非常方便变化接口。当然工作中的URL管理也是需要这样配置的，以为我们会不断的切换好几个服务器，组内服务器，测试服务器，内测服务器，公测上线服务器。

所以说一定要单独把这个文件配置出来，这也算是一个开发经验之谈吧。

在/lib/config文件夹下，建立一个`service_url.dart`文件，然后写入如下代码：

```text
const serviceUrl= 'http://v.jspang.com:8088/baixing/';
const servicePath={
  'homePageContext': serviceUrl+'wxmini/homePageContent', // 商家首页信息
};
```

接口的详细说明文件，我会在文章下方有一个接口文档给大家。以后的接口URL都会放到这个里边。

### [#](https://jspang.com/posts/2019/03/01/flutter-shop.html#接口读取文件和方法的建立)接口读取文件和方法的建立

URL的配置管理文件建立好了，接下来需要建立一个数据接口读取的文件，以后所有跟后台请求数据接口的方法，都会放到这个文件里。

有小伙伴会问了，为什么不耦合在UI页面里？这样看起来更直观。其实如果公司人少，耦合在页面里是可以的，而且效率会更高。但是大公司一个项目会有很多人参与，有时候对接后台接口的是专门一个人或者几个人，那这时候把文件单独出来，效率就更高。

那我们尽力贴合大公司的开放流程，所以把这个文件也单独拿出来，便于以后扩展。 新建一个service文件夹，然后建立一个`service_method.dart`文件。

首先我们引入三个要使用的包和上边写的一个文件文件，代码如下：

```dart
import "package:dio/dio.dart";
import 'dart:async';
import 'dart:io';
import '../config/service_url.dart';
```

然后编写一个`getHomePageContent`方法，方法返回一个`Future`对象。具体代码如下：

```dart
import "package:dio/dio.dart";
import 'dart:async';
import 'dart:io';
import '../config/service_url.dart';



Future getHomePageContent() async{

  try{
    print('开始获取首页数据...............');
    Response response;
    Dio dio = new Dio();
    dio.options.contentType=ContentType.parse("application/x-www-form-urlencoded");
    var formData = {'lon':'115.02932','lat':'35.76189'};
    response = await dio.post(servicePath['homePageContext'],data:formData);
    if(response.statusCode==200){
      return response.data;
    }else{
      throw Exception('后端接口出现异常，请检测代码和服务器情况.........');
    }
  }catch(e){
    return print('ERROR:======>${e}');
  }

}
```

这个就是我们于后端对接的接口，一般在公司需要一个既会前端有懂后端的人来作，这也是为什么好多公司招聘前端时，需要你懂一个后端语言的主要原因(小公司既作前端又作后端的忽略)。 这个文件完成，就可以回答`home_page.dart`，来获取数据了。

### [#](https://jspang.com/posts/2019/03/01/flutter-shop.html#home-page-dart-获取首页数据)home_page.dart 获取首页数据

删除学基础知识的所有代码，在`home_page.dart`里编写真正的项目代码。代码如下，因为这些知识都已经讲过，所以只贴出代码，当然视频中会有非常详细的讲解。

```dart
import 'package:flutter/material.dart';
import '../service/service_method.dart';


class HomePage extends StatefulWidget {
  _HomePageState createState() => _HomePageState();

}

class _HomePageState extends State<HomePage> {
  String homePageContent='正在获取数据';
  @override
  void initState() {
    getHomePageContent().then((val){
      setState(() {
           homePageContent=val.toString();
      });
      
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('百姓生活+'),
      ),
      body:SingleChildScrollView(
        child:  Text(homePageContent) ,
      )
      
    
    );
  }
}
```

写完后，就可以使用`flutter run`进行测试了。如果能读取远程数据，说明我们编写成功。

**本节总结**:

- 和后端接口对接的一些实战技巧，这些技巧可以大大增加项目的灵活性和减少维护成本。
- 真实项目接口数据的获取，为我们的项目提供后端数据支持。

## [#](https://jspang.com/posts/2019/03/01/flutter-shop.html#第10节-使用flutterswiper制作轮播效果)第10节:使用FlutterSwiper制作轮播效果

已经有了项目需要的数据，只是现在看起来比较乱（一坨一坨的），有很多格式化JSON的方法，这里我就不给大家墨迹了（要不又有人说我骗时长了）。如果说格式化也懒得格式化，你就直接看博客文章后方的API就可以了。如果你API都懒得看，那就泡杯茶，看视频吧。



### [#](https://jspang.com/posts/2019/03/01/flutter-shop.html#引入flutter-swiper插件)引入flutter_swiper插件

> flutter最强大的siwiper, 多种布局方式，无限轮播，Android和IOS双端适配.

好牛X得介绍，一般敢用“最”的一般都是神级大神，看到这个介绍后我也是吃了碗贾玲代言的方便面（一桶半），压了压我激动的心情。

Flutter_swiper的GitHub地址：https://github.com/best-flutter/flutter_swiper



了解`flutter_swiper`后，需要作的第一件事就再`pubspec.yaml`文件中引入这个插件（录课时flutter_swiper插件的版本文v1.1.6，以后可能会有更新）。

```text
flutter_swiper : ^1.1.6  （记得使用最新版）
```

引入后再VSCode中保存，会自动为我们下载包。开着点代理，有一次没开代理死活下不下来。

### [#](https://jspang.com/posts/2019/03/01/flutter-shop.html#首页轮播效果的编写)首页轮播效果的编写

我们新定义一个类，当然你甚至可以新起一个文件，完全独立出来。这样一个页面就可以分为多个类，然后写完后由项目组长统一整合起来。

当然作练习就没必要每一个模块都分一个`dart`文件了，要不太乱，自己反而降低编写效率。所以就写在同一个目录里了。

首先引入`flutter_swiper`插件，然后就可以编写自定义轮播类了。

新写了一个`SwiperDiy`的类，当然这个类用静态类就完全可以了,这个类是需要接受一个List参数的，所以我们定义了一个常量`swiperDataList`,然后返回一个组件，这个组件其实就是Swiper组件，不过我们在Swiper组件外边包裹了一个`Container`。

代码如下：

```dart
// 首页轮播组件编写
class SwiperDiy extends StatelessWidget {
  final List swiperDataList;
  SwiperDiy({Key key,this.swiperDataList}):super(key:key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 333.0,
      child: Swiper(
        itemBuilder: (BuildContext context,int index){
          return Image.network("${swiperDataList[index]['image']}",fit:BoxFit.fill);
        },
        itemCount: swiperDataList.length,
        pagination: new SwiperPagination(),
        autoplay: true,
      ),
    );
  }
}
```

### FutureBuilder Widget

这是一个Flutter内置的组件，是用来等待异步请求的。现在可以使用`FuturerBuilder`来改造`HomePage`类里的build方法，具体代码细节在视频中进行讲解。

代码如下：

```dart
@override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(title: Text('百姓生活+'),),
      body:FutureBuilder(
        future:getHomePageContent(),
        builder: (context,snapshot){
          if(snapshot.hasData){
             var data=json.decode(snapshot.data.toString());
             List<Map> swiperDataList = (data['data']['slides'] as List).cast(); // 顶部轮播组件数
             return Column(
               children: <Widget>[
                   SwiperDiy(swiperDataList:swiperDataList ),   //页面顶部轮播组件
               ],
             );
          }else{
            return Center(
              child: Text('加载中'),
            );
          }
        },
      )
    );

  }
```

有了这个方法，我们就没必要再用initState了，删除了就可以了。

全体代码如下：

```dart
import 'package:flutter/material.dart';
import '../service/service_method.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'dart:convert';


class HomePage extends StatefulWidget {
  _HomePageState createState() => _HomePageState();

}

class _HomePageState extends State<HomePage> {
  
  


  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(title: Text('百姓生活+'),),
      body:FutureBuilder(
        future:getHomePageContent(),
        builder: (context,snapshot){
          if(snapshot.hasData){
             var data=json.decode(snapshot.data.toString());
             List<Map> swiperDataList = (data['data']['slides'] as List).cast(); // 顶部轮播组件数
             return Column(
               children: <Widget>[
                   SwiperDiy(swiperDataList:swiperDataList ),   //页面顶部轮播组件
               ],
             );
          }else{
            return Center(
              child: Text('加载中'),
            );
          }
        },
      )
    );

  }
}
// 首页轮播组件编写
class SwiperDiy extends StatelessWidget {
  final List swiperDataList;
  SwiperDiy({Key key,this.swiperDataList}):super(key:key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 333.0,
      child: Swiper(
        itemBuilder: (BuildContext context,int index){
          return Image.network("${swiperDataList[index]['image']}",fit:BoxFit.fill);
        },
        itemCount: swiperDataList.length,
        pagination: new SwiperPagination(),
        autoplay: true,
      ),
    );
  }
}
```

课程总结：

- `flutter_Swiper`:学习了`flutter_swiper`组件的简单使用方法，当然你还可以自己学习。
- `FutureBuilder`: 这个布局可以很好的解决异步渲染的问,实战中我们讲了很多使用的技巧，注意反复学习。
- 自定义类接受参数：我们复习了类接受参数的方法。学会了这个技巧就可以把我们的页面分成很多份，让很多人来进行编写，最后再整合到一起。

## [#](https://jspang.com/posts/2019/03/01/flutter-shop.html#第11节：首页-屏幕适配方案和制作)第11节：首页_屏幕适配方案和制作

移动端的屏幕大小不一，IOS端就有很多种，Android端更是多如牛毛。美工或UI妹子也会经常，甜甜的问我们：“哥，设计用啥尺寸的？” 作为一个公司的技术和颜值担当，你一定要很轻松的回答这个问题。你回答后会不会心里胆怯，不用怕，学完今天这节课，你就可以轻松的回答这个问题。

### flutter_ScreenUtil插件简介

> flutter_ScreenUtil屏幕适配方案，让你的UI在不同尺寸的屏幕上都能显示合理的布局。

插件会让你先设置一个UI稿的尺寸，他会根据这个尺寸，根据不同屏幕进行缩放，能满足大部分屏幕场景。

github:https://github.com/OpenFlutter/flutter_ScreenUtil



目前github的star数是:1035

这个轮子功能还不是很完善，但是也在一点点的进步，这也算是国内现在最好的Flutter屏幕适配插件了，又不足的地方你可以自己下载源码进行修改，并使用。

个人觉的今年在国内应该是Flutter的爆发年，也会有更多更好用的插件诞生。

### [#](https://jspang.com/posts/2019/03/01/flutter-shop.html#flutter-screenutil的引入和使用)flutter_ScreenUtil的引入和使用

因为是第三方包，所以还需要在`pubspec.yaml`文件中进行注册依赖。在填写依赖之前，最好到github上看一下最新版本，因为这个插件也存在着升级后，以前版本不可用的问题。

```dart
dependencies:
     flutter_screenutil: ^0.5.3
```

需要注意的是,一定要注意使用最新版本，这个插件版本升级还是挺快的，基本每周都有升级。

需要在每个使用的地方进行导入：

```dart
import 'package:flutter_screenutil/flutter_screenutil.dart';
```

**初始化设置尺寸**

在使用之前请设置好设计稿的宽度和高度，传入设计稿的宽度和高度，注意单位是px。

我们公司一般会以Iphone6的屏幕尺寸作设计稿，这个习惯完全是当初公司组长的手机是Iphone6的，审核美工稿的时候，可以完美呈现，所以就沿用下来了（我想估计老总的手机早升级了）。

```dart
 ScreenUtil.instance = ScreenUtil(width: 750, height: 1334)..init(context);
```

**这句话的引入一定要在有了界面UI树建立以后执行，如果还没有UI树，会报错的。比如我们直接放在类里，就会报错，如果昉在build方法里，就不会报错。**

**适配尺寸**

这时候我们使用的尺寸是`px`.

- 根据屏幕宽度适配：`width:ScreenUtil().setWidth(540)`;
- 根据屏幕高度适配：`height:ScreenUtil().setHeight(200)`;
- 适配字体大小：`fontSize：ScreenUtil().setSp(28,false)`;

配置字体大小的参数`false`是不会根据系统的"字体大小"辅助选项来进行缩放。

根据学到的知识，来设置一下昨天的轮播图片问题。

- 首先在`home_page.dart`里，用`import`进行引入。
- 在`build`方法里，初始化设计稿尺寸，`ScreenUtil.instance = ScreenUtil(width: 750, height: 1334)..init(context);`.
- 给`Container`设置高和宽的值`height: ScreenUtil().setHeight(333),`和`width: ScreenUtil().setWidth(750),`

全部代码如下:

```dart
import 'package:flutter/material.dart';
import '../service/service_method.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'dart:convert';
import 'package:flutter_screenutil/flutter_screenutil.dart';


class HomePage extends StatefulWidget {
  _HomePageState createState() => _HomePageState();

}

class _HomePageState extends State<HomePage> {
  
  


  @override
  Widget build(BuildContext context) {
   
    return Scaffold(
      appBar: AppBar(title: Text('百姓生活+'),),
      body:FutureBuilder(
        future:getHomePageContent(),
        builder: (context,snapshot){
          if(snapshot.hasData){
             var data=json.decode(snapshot.data.toString());
             List<Map> swiperDataList = (data['data']['slides'] as List).cast(); // 顶部轮播组件数
             return Column(
               children: <Widget>[
                   SwiperDiy(swiperDataList:swiperDataList ),   //页面顶部轮播组件
               ],
             );
          }else{
            return Center(
              child: Text('加载中'),
            );
          }
        },
      )
    );

  }
}
// 首页轮播组件编写
class SwiperDiy extends StatelessWidget {
  final List swiperDataList;
  SwiperDiy({Key key,this.swiperDataList}):super(key:key);

  @override
  Widget build(BuildContext context) {
     ScreenUtil.instance = ScreenUtil(width: 750, height: 1334)..init(context);
    return Container(
      height: ScreenUtil().setHeight(333),
      width: ScreenUtil().setWidth(750),
      child: Swiper(
        itemBuilder: (BuildContext context,int index){
          return Image.network("${swiperDataList[index]['image']}",fit:BoxFit.fill);
        },
        itemCount: swiperDataList.length,
        pagination: new SwiperPagination(),
        autoplay: true,
      ),
    );
  }
}
```

写完这个代码以后，可以查看界面的变化，甚至你可以多测试几个手机的效果。查看一下屏幕的适配效果如何。

### [#](https://jspang.com/posts/2019/03/01/flutter-shop.html#api其他属性简介)API其他属性简介

我们在简单的学习一下ScreenUtil的其他属性，有助于你在工作中的灵活使用。

- ScreenUtil.pixelRatio : 设备的像素密度
- ScreenUtil.screenWidth : 设备的宽度
- ScreenUtil.screenHeight : 设备高度

我们就简单介绍这三个吧，剩下的有些API如果感兴趣，可以到github上自行学习一下。

```dart
 ScreenUtil.instance = ScreenUtil(width: 750, height: 1334)..init(context);
 print('设备宽度:${ScreenUtil.screenWidth}');
 print('设备高度:${ScreenUtil.screenHeight}');
 print('设备像素密度:${ScreenUtil.pixelRatio}');
```

重新用大`R`刷新一下界面，可以看到控制台已经显示出了这三个基本值了。

本节总结：这节课主要学习了使用`flutter_ScreenUtil`来视频Flutter的APP应用，需要注意的是这个插件再不断升级中，所以使用的时候要使用最新版。

## [#](https://jspang.com/posts/2019/03/01/flutter-shop.html#第12节-首页导航区域编写)第12节:首页导航区域编写

导航区是每个APP（爱啪啪，今天同事教我的，我觉的生动形象，充满娱乐性）必备的一个功能。这节课就利用`GridView`小部件进行制作，当然制作中我们也会讲到一些布局技巧。

### 导航单元素的编写

从外部看，导航是一个`GridView`部件，但是每一个导航又是一个上下关系的Column。小伙伴们都知道Flutter有多层嵌套的问题，如果我们都写在一个组件里，那势必造成嵌套严重，不利于项目以后的维护工作。所以我们单独把每一个自元素导航拿出来，一个方法，返回一个组件。

代码如下：

```dart
class TopNavigator extends StatelessWidget {
  final List navigatorList;
  TopNavigator({Key key, this.navigatorList}) : super(key: key);

  Widget _gridViewItemUI(BuildContext context,item){
    return InkWell(
      onTap: (){print('点击了导航');},
      child: Column(
        children: <Widget>[
          Image.network(item['image'],width:ScreenUtil().setWidth(95)),
          Text(item['mallCategoryName'])
        ],
      ),
    );
  }
}
```

### [#](https://jspang.com/posts/2019/03/01/flutter-shop.html#gridview制作导航)GridView制作导航

这个制作我们还是在外层嵌套一个`Container`组件，然后直接使用`GridView`。代码如下：

```dart
  @override
  Widget build(BuildContext context) {
    return Container(
      height: ScreenUtil().setHeight(320),
      padding:EdgeInsets.all(3.0),
      child: GridView.count(
        crossAxisCount: 5,
        padding: EdgeInsets.all(4.0),
        children: navigatorList.map((item){
          return _gridViewItemUI(context, item);
        }).toList(),
      ),
    );
  }
```

需要注意的是`children`属性，我们使用了`map`循环，然后再使用toList()进行转换。

### [#](https://jspang.com/posts/2019/03/01/flutter-shop.html#数据处理和bug解决)数据处理和Bug解决

在`HomePage`的`build`方法里声明一个List变量，然后把数据进行List转换。再调用`TopNavigator`自定义组件。

```dart
 List<Map> navigatorList =(data['data']['category'] as List).cast(); //类别列表
  TopNavigator(navigatorList:navigatorList),  //导航组件
```

这时候进行预览界面，你会发现界面有些问题，就是多了一个类别，并不是我们想要的10个列表，其实如果正常，这应该是后端给数据的一个Bug。但是我们是没办法去找后端麻烦的，所以只能自己想办法解决这个问题。

解决的办法就是把List进行截取，方法如下。

```dart
 if(navigatorList.length>10){
      navigatorList.removeRange(10, navigatorList.length);
    }
```

这节主要是以导航功能为例子，讲解了一下布局的技巧。其实知识我们都已经在基础部分学过了，主要练习的是我们综合运用的能力。这种能力要多进行练习，你才能在实际项目中灵活布局。

## [#](https://jspang.com/posts/2019/03/01/flutter-shop.html#第13节：adbanner组件的编写)第13节：ADBanner组件的编写

这节课的内容相对简单一点，只要制作一个广告的Bannder条就可以了。

### AdBanner组件的编写

我们还是把这部分单独出来，需要说明的是，这个`Class`你也是可以完全独立成一个`dart`文件的。代码如下：

```text
//广告图片
class AdBanner extends StatelessWidget {
  final String advertesPicture;

  AdBanner({Key key, this.advertesPicture}) : super(key: key);

  @override
  Widget build(BuildContext context) {
   

    return Container(
      child: Image.network(advertesPicture),
    );
  }
}
```

### [#](https://jspang.com/posts/2019/03/01/flutter-shop.html#数据准备和调用组件)数据准备和调用组件

我们先把广告的图片准备好，准备好后就可以调用图片组件了。

```text
String advertesPicture = data['data']['advertesPicture']['PICTURE_ADDRESS']; //广告图片

AdBanner(advertesPicture:advertesPicture),   //广告组件  
```

这时候进行预览就会得到你想要的效果了，这节课虽然很短，但是你要知道一直知识，就是如何把一个复杂的页面，拆解成一个个`Widget`，这样有助于我们多人的协作开发，适应现在的开发流程。

### [#](https://jspang.com/posts/2019/03/01/flutter-shop.html#说说新版本的升级)说说新版本的升级

我录课的时候使用的是Flutter1.0版本，但这两天正好升级了1.2版本，而且有一些盼望已久的功能，就有很多小伙伴问我，到底该不该升级。

对于升级这个问题我是这样认为的：

- 学习项目：尽快升级，体验最新的版本，对我们的职业技能非常有好处。
- 生产项目：谨慎升级，一般生产的正式项目开发周期比较长，使用插件比较多，追求稳定是一项重要工作，所以等版本稳定，插件跟上后，我们再进行升级。

**升级方法有两种：**

- 直接在控制台使用`flutter upgrade`，这种方法需要开启科学上网，如果中途卡死或者出错，可以使用下面的方法。
- 直接删除原来下载的Flutter SDK，然后下载最新版本，放置到原来SDK的位置，就可以升级成功。

总结：这节课的内容比较少，主要两个方面，一是图片广告的添加，二是关于是否升级最新版本的问题。下节课我们主要讲一下切换



## [#](https://jspang.com/posts/2019/03/01/flutter-shop.html#第14节：首页-拨打电话操作)第14节：首页_拨打电话操作

拨打电话的功能在app里也很常见，比如一般的外卖app都会有这个才做。其实Flutter本身是没给我们提供拨打电话的能力的，那我们如何来拨打电话那?这节课我们就使用url_launcher来制作拨打电话的效果。

### 编写店长电话模块

这个小伙伴们一定轻车熟路了，我也就不再多介绍吧。直接看代码，相信都能看懂。

```dart
class LeaderPhone extends StatelessWidget {
  final String leaderImage; //店长图片
  final String leaderPhone; //店长电话

  LeaderPhone({Key key, this.leaderImage,this.leaderPhone}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: InkWell(
        onTap: (){},
        child: Image.network(leaderImage),
      ),
    );
  }
}
```

**获取需要的数据**

在`HomePage`里获取获取店长图片和电话数据，并形成变量。

```dart
String  leaderImage= data['data']['shopInfo']['leaderImage'];  //店长图片
String  leaderPhone = data['data']['shopInfo']['leaderPhone']; //店长电话 
```

有了数据之后，就可以调用这个自己写的组件了。调用方法如下：

```dart
  LeaderPhone(leaderImage:leaderImage,leaderPhone: leaderPhone)  //广告组件  
```

### [#](https://jspang.com/posts/2019/03/01/flutter-shop.html#url-launcher的简介)url_launcher的简介

官方介绍：

> A Flutter plugin for launching a URL in the mobile platform. Supports iOS and Android.

意思是用于在移动平台中启动URL的Flutter插件，适用于IOS和Android平台。他可以打开网页，发送邮件，还可以拨打电话。

github地址：https://github.com/flutter/plugins/tree/master/packages/url_launcher



**引入依赖**

在`pubspec.yaml`文件里注册依赖，并保存下载包。请注意使用最新版。

```text
url_launcher: ^5.0.1
```

在需要使用的页面在使用import引入具体的`url_launcher`包。

```dart
import 'package:url_launcher/url_launcher.dart';
```

### [#](https://jspang.com/posts/2019/03/01/flutter-shop.html#改造店长电话组件)改造店长电话组件

有了`url_launcher`插件就后，我们就可以实现拨打电话功能了，不过要简单的改造一下拨打电话模块的代码，改造后的代码如下。

```dart
class LeaderPhone extends StatelessWidget {
  final String leaderImage; //店长图片
  final String leaderPhone; //店长电话

  LeaderPhone({Key key, this.leaderImage,this.leaderPhone}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: InkWell(
        onTap:_launchURL,
        child: Image.network(leaderImage),
      ),
    );
  }

  void _launchURL() async {
    String url = 'tel:'+leaderPhone;
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}
```

这时候就可以打开虚拟机进行调试了，需要说的是，有些虚拟机并出不来拨打电话的效果，如果你的虚拟机出不来这个效果，可以使用真机进行测试。

**本节总结**：本节主要学习了使用`url_launcher`来进行打开网页和拨打电话的设置。希望小伙伴们都有所收获。

## [#](https://jspang.com/posts/2019/03/01/flutter-shop.html#第15节：商品推荐区域制作)第15节：商品推荐区域制作

简单的部门就适当省略些，中间放图片的步骤就省略点了，这节课学习一下商品推荐这个部分的编写。这个部分是一个横向列表，而且为了避免嵌套，所以要把个个组件进行内部拆分。

### 超出边界的处理方法

其实这个操作已经讲过，但是技术胖在编写的时候还是没有进行此步设置，我的锅，我自己背。其实我们只要使用`SingleChildScrollView`widget就可以了。把这个widget放到我们主`build`里的`Column`外边就可以了。

其实这时候我们给自己以后的`ListView`组件埋了一个坑。

具体代码如下:

```text
return SingleChildScrollView(
  child: Column(
  children: <Widget>[
      SwiperDiy(swiperDataList:swiperDataList ),   //页面顶部轮播组件
      TopNavigator(navigatorList:navigatorList),   //导航组件
      AdBanner(advertesPicture:advertesPicture), 
      LeaderPhone(leaderImage:leaderImage,leaderPhone: leaderPhone),  //广告组件  
    ],
) ,
);
```

### [#](https://jspang.com/posts/2019/03/01/flutter-shop.html#推荐商品类的编写)推荐商品类的编写

这个类接收一个List参数，就是推荐商品的列表，这个列表是可以左右滚动的。

```text
//商品推荐
class Recommend extends StatelessWidget {
  final List  recommendList;

  Recommend({Key key, this.recommendList}) : super(key: key);
}
```

### [#](https://jspang.com/posts/2019/03/01/flutter-shop.html#推荐标题内部方法的编写)推荐标题内部方法的编写

因为实际开发中，要尽量减少嵌套，所以我们需要把复杂的组件，单独拿出来一个方法进行编写。这里就把标题单独拿出来进行编写。

```text
 //推荐商品标题
  Widget _titleWidget(){
     return Container(
       alignment: Alignment.centerLeft,
       padding: EdgeInsets.fromLTRB(10.0, 2.0, 0,5.0),
       decoration: BoxDecoration(
         color:Colors.white,
         border: Border(
           bottom: BorderSide(width:0.5,color:Colors.black12)
         )
       ),
       child:Text(
         '商品推荐',
         style:TextStyle(color:Colors.pink)
         )
     );
  }
```

### [#](https://jspang.com/posts/2019/03/01/flutter-shop.html#推荐商品单独项编写)推荐商品单独项编写

把推荐商品的每一个子项我们也分离出来。每一个子项都使用`InkWell`，这样为以后的页面导航作准备。里边使用了`Column`,把内容分成三行。

具体代码：

```text
  Widget _item(index){
    return InkWell(
      onTap: (){},
      child: Container(
        height: ScreenUtil().setHeight(330),
        width: ScreenUtil().setWidth(250),
        padding: EdgeInsets.all(8.0),
        decoration:BoxDecoration(
          color:Colors.white,
          border:Border(
            left: BorderSide(width:0.5,color:Colors.black12)
          )
        ),
        child: Column(
          children: <Widget>[
            Image.network(recommendList[index]['image']),
            Text('￥${recommendList[index]['mallPrice']}'),
            Text(
              '￥${recommendList[index]['price']}',
              style: TextStyle(
                decoration: TextDecoration.lineThrough,
                color:Colors.grey
              ),
            )
          ],
        ),
      ),
    );
  }
```

### [#](https://jspang.com/posts/2019/03/01/flutter-shop.html#横向列表组件的编写)横向列表组件的编写

横向列表组件也进行单独编写，以减少嵌套，这样我们就把每一个重要的部分都进行了分离。这种分离技巧，小伙伴们一定要掌握，这在工作中非常重要。

```text
  Widget _recommedList(){

      return Container(
        height: ScreenUtil().setHeight(330),
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: recommendList.length,
          itemBuilder: (context,index){
            return _item(index);
          },
        ),
      );
  }
```

有了这三个基本组件，最后我们在`build`方法里进行组合，形成商品推荐区域。

```text
 @override
  Widget build(BuildContext context) {
    return Container(
       height: ScreenUtil().setHeight(380),
       margin: EdgeInsets.only(top: 10.0),
       child: Column(
         children: <Widget>[
           _titleWidget(),
           _recommedList()
         ],
       ),
    );
  }
```

**整个组件的类代码如下**

```text
//商品推荐
class Recommend extends StatelessWidget {
  final List  recommendList;

  Recommend({Key key, this.recommendList}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
       height: ScreenUtil().setHeight(380),
       margin: EdgeInsets.only(top: 10.0),
       child: Column(
         children: <Widget>[
           _titleWidget(),
           _recommedList()
         ],
       ),
    );
  }

//推荐商品标题
  Widget _titleWidget(){
     return Container(
       alignment: Alignment.centerLeft,
       padding: EdgeInsets.fromLTRB(10.0, 2.0, 0,5.0),
       decoration: BoxDecoration(
         color:Colors.white,
         border: Border(
           bottom: BorderSide(width:0.5,color:Colors.black12)
         )
       ),
       child:Text(
         '商品推荐',
         style:TextStyle(color:Colors.pink)
         )
     );
  }

  Widget _recommedList(){

      return Container(
        height: ScreenUtil().setHeight(330),
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: recommendList.length,
          itemBuilder: (context,index){
            return _item(index);
          },
        ),
      );
  }

  Widget _item(index){
    return InkWell(
      onTap: (){},
      child: Container(
        height: ScreenUtil().setHeight(330),
        width: ScreenUtil().setWidth(250),
        padding: EdgeInsets.all(8.0),
        decoration:BoxDecoration(
          color:Colors.white,
          border:Border(
            left: BorderSide(width:0.5,color:Colors.black12)
          )
        ),
        child: Column(
          children: <Widget>[
            Image.network(recommendList[index]['image']),
            Text('￥${recommendList[index]['mallPrice']}'),
            Text(
              '￥${recommendList[index]['price']}',
              style: TextStyle(
                decoration: TextDecoration.lineThrough,
                color:Colors.grey
              ),
            )
          ],
        ),
      ),
    );
  }
}
```

### [#](https://jspang.com/posts/2019/03/01/flutter-shop.html#准备数据并进行调用)准备数据并进行调用

随着大家越来越熟练的使用，这部分没什么好讲的了。直接上代码：

```text
 List<Map> recommendList = (data['data']['recommend'] as List).cast(); // 商品推荐
 Recommend(recommendList:recommendList),    
```

本节总结:这节主要制作了商品推荐区域的制作，知识点可能都是我们以前学过的，但是要重点练习一下如何练习对组件的拆分能力。当你掌握了这种能力后，你会发现Flutter真的很好用，我们只需要`Dart`这一种语言，就可以编写页面和前台的业务逻辑。不再像使用前端技术时，要回js、html、css还要会框架。 个人感觉使用一种语言来作全部事情，是爽歪歪的。

## [#](https://jspang.com/posts/2019/03/01/flutter-shop.html#第16节：补充-切换后页面状态的保持)第16节：补充_切换后页面状态的保持

这节课算是一个补充，因为这几天一直有小伙伴问我在底部导航栏切换的时候，我作的程序页面并没有保持页面结果，就是每次切换都需要重新加载。这节课我们就来解决一下这个问题。

### 上节课遗留的一个而问题

上节课我们虽然做出了效果，但是在模拟器上看是有一些问题的，就是模拟器纵向显示`0.5`的线支持的不好。所以我们改位1，试一下效果。

改为1，这个问题就应该解决了。

### [#](https://jspang.com/posts/2019/03/01/flutter-shop.html#automatickeepaliveclientmixin)AutomaticKeepAliveClientMixin

`AutomaticKeepAliveClientMixin`这个`Mixin`就是Flutter为了保持页面设置的。哪个页面需要保持页面状态，就在这个页面进行混入。

不过使用使用这个`Mixin`是有几个先决条件的：

- 使用的页面必须是`StatefulWidget`,如果是`StatelessWidget`是没办法办法使用的。
- 其实只有两个前置组件才能保持页面状态：`PageView`和`IndexedStack`。
- 重写`wantKeepAlive`方法，如果不重写也是实现不了的。

如果你还不明白什么是混入，可以看技术胖的那个基础文章《[20个Flutter实例视频教程 让你轻松上手工作](https://jspang.com/post/flutterDemo.html)



》 有对混入的详细介绍，这里我就不重复讲解了。

### [#](https://jspang.com/posts/2019/03/01/flutter-shop.html#修改index-page-dart)修改index_page.dart

明白基本知识之后，就可以修改`index_page.dart`,思路就是增加一个`IndexedStack`包裹在`tabBodies`外边。

整体代码如下：

```text
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'home_page.dart';
import 'category_page.dart';
import 'cart_page.dart';
import 'member_page.dart';


class IndexPage extends StatefulWidget {
  _IndexPageState createState() => _IndexPageState();
}

class _IndexPageState extends State<IndexPage>{

   PageController _pageController;


  final List<BottomNavigationBarItem> bottomTabs = [
    BottomNavigationBarItem(
      icon:Icon(CupertinoIcons.home),
      title:Text('首页')
    ),
    BottomNavigationBarItem(
      icon:Icon(CupertinoIcons.search),
      title:Text('分类')
    ),
    BottomNavigationBarItem(
      icon:Icon(CupertinoIcons.shopping_cart),
      title:Text('购物车')
    ),
     BottomNavigationBarItem(
      icon:Icon(CupertinoIcons.profile_circled),
      title:Text('会员中心')
    ),
  ];
  final List<Widget> tabBodies = [
    HomePage(),
    CategoryPage(),
    CartPage(),
    MemberPage()
  ];
  int currentIndex= 0;
  var currentPage ;
  @override
  void initState() {
   currentPage=tabBodies[currentIndex];
   _pageController=new PageController()
      ..addListener(() {
        if (currentPage != _pageController.page.round()) {
          setState(() {
            currentPage = _pageController.page.round();
          });
        }
  });


    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(244, 245, 245, 1.0),
      bottomNavigationBar: BottomNavigationBar(
        type:BottomNavigationBarType.fixed,
        currentIndex: currentIndex,
        items:bottomTabs,
        onTap: (index){
          setState(() {
           currentIndex=index;
            currentPage =tabBodies[currentIndex]; 
          });
           
        },
      ),
      body: IndexedStack(
        index: currentIndex,
        children: tabBodies
      )
    );
  }
}
```

代码虽然很长，但是改动的部分并不多。具体看视频吧，真的不好描述（文笔蹩脚，继续努力）。

### [#](https://jspang.com/posts/2019/03/01/flutter-shop.html#加入mixin保持页面状态)加入Mixin保持页面状态

在`home_page.dart`里加入`AutomaticKeepAliveClientMixin`混入，加入后需要重写`wantKeepAlive`方法。主要代码如下：

```text
class _HomePageState extends State<HomePage> with AutomaticKeepAliveClientMixin {
  
  @override
  bool get wantKeepAlive =>true;
}
```

为了检验结果，我们在 `_HomePageState`里增加一个`initState`,在里边`print`一些内容，如果内容输出了，证明我们的页面重新加载了，如果没输出，证明我们的页面保持了状态。

```text
@override
  void initState() {
    super.initState();
     print('111111111111111111111111111');
  }
```

本节总结:这节课主要是回答网页在学习中遇到的页面保持状态的问题。

## [#](https://jspang.com/posts/2019/03/01/flutter-shop.html#第17节：首页-楼层区域的编写)第17节：首页_楼层区域的编写

这节课主要学习一下楼层区域的编写，楼层目前是有3层的，而且布局都比较特殊，但每个楼层都是一样的，只是商品图片不同，那就可以把每个楼层抽象为一个部件，这样可以减少维护成本。

### 编写楼层标题组件

这个组件编写起来非常容易，就是接收一个图片地址，然后显示图片。代码如下：

```text
class FloorTitle extends StatelessWidget {
  final String picture_address; // 图片地址
  FloorTitle({Key key, this.picture_address}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(8.0),
      child: Image.network(picture_address),
    );
  }
}
```

### [#](https://jspang.com/posts/2019/03/01/flutter-shop.html#楼层商品组件的编写)楼层商品组件的编写

在编写楼层商品组件时，我们要对它详细的拆分，我们把一个组件拆分成如下内部方法。

- _goodsItem:每个商品的子项，也算是这个类的最小模块了。
- _firstRow:前三个商品的组合，是一个Row组件。
- _otherGoods:其它商品的组合，也是一个Row组件。

总后把这些组件通过Column合起来。总代码如下：

```text
//楼层商品组件
class FloorContent extends StatelessWidget {
  final List floorGoodsList;

  FloorContent({Key key, this.floorGoodsList}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: <Widget>[
          _firstRow(),
          _otherGoods()
        ],
      ),
    );
  }

  Widget _firstRow(){
    return Row(
      children: <Widget>[
        _goodsItem(floorGoodsList[0]),
        Column(
          children: <Widget>[
           _goodsItem(floorGoodsList[1]),
           _goodsItem(floorGoodsList[2]),
          ],
        )
      ],
    );
  }

  Widget _otherGoods(){
    return Row(
      children: <Widget>[
       _goodsItem(floorGoodsList[3]),
       _goodsItem(floorGoodsList[4]),
      ],
    );
  }

  Widget _goodsItem(Map goods){

    return Container(
      width:ScreenUtil().setWidth(375),
      child: InkWell(
        onTap:(){print('点击了楼层商品');},
        child: Image.network(goods['image']),
      ),
    );
  }

}
```

### [#](https://jspang.com/posts/2019/03/01/flutter-shop.html#数据的准备)数据的准备

不多说了，一次性全部写出来。

```text
    String floor1Title =data['data']['floor1Pic']['PICTURE_ADDRESS'];//楼层1的标题图片
    String floor2Title =data['data']['floor2Pic']['PICTURE_ADDRESS'];//楼层1的标题图片
    String floor3Title =data['data']['floor3Pic']['PICTURE_ADDRESS'];//楼层1的标题图片
    ist<Map> floor1 = (data['data']['floor1'] as List).cast(); //楼层1商品和图片 
    List<Map> floor2 = (data['data']['floor2'] as List).cast(); //楼层1商品和图片 
    List<Map> floor3 = (data['data']['floor3'] as List).cast(); //楼层1商品和图片 
    
    return SingleChildScrollView(
      child: Column(
      children: <Widget>[
          SwiperDiy(swiperDataList:swiperDataList ),   //页面顶部轮播组件
          TopNavigator(navigatorList:navigatorList),   //导航组件
          AdBanner(advertesPicture:advertesPicture), 
          LeaderPhone(leaderImage:leaderImage,leaderPhone: leaderPhone),  //广告组件  
          Recommend(recommendList:recommendList),    
          FloorTitle(picture_address:floor1Title),
          FloorContent(floorGoodsList:floor1),
          FloorTitle(picture_address:floor2Title),
          FloorContent(floorGoodsList:floor2),
          FloorTitle(picture_address:floor3Title),
          FloorContent(floorGoodsList:floor3),
        ],
        ) ,
    );
```

本节总结：这节课学习了楼层组件的制作，并进行了复用。

## [#](https://jspang.com/posts/2019/03/01/flutter-shop.html#第18节-首页-火爆专区商品接口制作)第18节:首页_火爆专区商品接口制作

这节课我们开始读取火爆专区部分的接口，这个接口制作起来还是稍微有一些麻烦的，比如他里边有上拉加载更多数据这样的操作。

### 接口初探

使用Fiddler可以看到火爆专区的商品接口为`homePageBelowConten`,接收一个page参数，接口类型为post类型。有了这些最进本的信息，就可以先到项目中的接口管理文件`lib/config/servic.dart`来设置接口。

代码如下：

```text
const servicePath={
  'homePageContext': serviceUrl+'wxmini/homePageContent', // 商家首页信息
  'homePageBelowConten': serviceUrl+'wxmini/homePageBelowConten', //商城首页热卖商品拉取
};
```

因为随着项目的制作，接口越来越多，所以一定要做好注释工作。

### [#](https://jspang.com/posts/2019/03/01/flutter-shop.html#获取接口的方法)获取接口的方法

在`service/service_method.dart`里制作方法。我们先不接收参数，先把接口调通。

```text
//获得火爆专区商品的方法
Future getHomePageBeloConten() async{

  try{
    print('开始获取下拉列表数据.................');
    Response response;
    Dio dio = new Dio();
    dio.options.contentType=ContentType.parse("application/x-www-form-urlencoded");
    int page=1;
    response = await dio.post(servicePath['homePageBelowConten'],data:page);
    if(response.statusCode==200){
      return response.data;
    }else{
      throw Exception('后端接口出现异常，请检测代码和服务器情况.........');
    }
  }catch(e){
      return print('ERROR:======>${e}');
  }

}
```

### [#](https://jspang.com/posts/2019/03/01/flutter-shop.html#进行调试接口)进行调试接口

接口对接的方法写好了，然后我们进行测试一下接口是否可以读出数据，如果能读出数据，就说明接口已经调通，我们就可以搞事情了。

因为这个新的类是由下拉刷新的，也就是动态的类，所以需要使用`StatefulWidget`。

代码如下：

```text
class HotGoods extends StatefulWidget {
  _HotGoodsState createState() => _HotGoodsState();
}

class _HotGoodsState extends State<HotGoods> {


   void initState() { 
     super.initState();
      getHomePageBeloConten().then((val){
         print(val);
      });
   }
    
  @override
  Widget build(BuildContext context) {
    return Container(
       child:Text('1111'),
    );
  }
}
```

### [#](https://jspang.com/posts/2019/03/01/flutter-shop.html#精简代码，来个通用接口)精简代码，来个通用接口

在写`service_method.dart`的时候，你会发现我们大部分的代码都是相同的，甚至复制一个方法后，通过简单的修改几个地方，就可以使用了。那就说明这个地方由优化的必要。让代码更通用更精简。

精简代码如下：

```text
Future request(url,formData)async{
    try{
      print('开始获取数据...............');
      Response response;
      Dio dio = new Dio();
      dio.options.contentType=ContentType.parse("application/x-www-form-urlencoded");
      if(formData==null){
          response = await dio.post(servicePath[url]);
      }else{
          response = await dio.post(servicePath[url],data:formData);
      }
      if(response.statusCode==200){
        return response.data;
      }else{
          throw Exception('后端接口出现异常，请检测代码和服务器情况.........');
      }
    }catch(e){
        return print('ERROR:======>${e}');
    }
     
}
```

使用也是非常简单的，只要传递一个接口名称和相对参数就可以了。

```text
request('homePageBelowConten',1).then((val){
         print(val);
      });
```

本节总结:这节主要学习了火爆专区的接口，并进行了调试和优化。主要知识点是对dio方法的优化，这样就可以大大减少代码量。

## [#](https://jspang.com/posts/2019/03/01/flutter-shop.html#第19节：首页-火爆专区界面制作)第19节：首页_火爆专区界面制作

上节课已经调通了后端接口，这节课我们把火爆专区的页面制作一下，然后再制作上拉加载效果。

### Dart中可选参数的设置

上节课在作通用方法的时候，我们的参数使用了一个必选参数，其实我们可以使用一个可选参数。Dart中的可选参数，直接使用“{}”(大括号)就可以了。可选参数在调用的时候必须使用`paramName:value`的形式。

我们把上节课的后端接口代码改为如下:

```text
Future request(url,{formData})async{
    try{
      print('开始获取数据...............');
      Response response;
      Dio dio = new Dio();
      dio.options.contentType=ContentType.parse("application/x-www-form-urlencoded");
      if(formData==null){
        
          response = await dio.post(servicePath[url]);
      }else{
          response = await dio.post(servicePath[url],data:formData);
      }
      if(response.statusCode==200){
        return response.data;
      }else{
          throw Exception('后端接口出现异常，请检测代码和服务器情况.........');
      }
    }catch(e){
        return print('ERROR:======>${e}');
    }
     
}
```

然后调用的时候，采用的方式是`request('homePageBelowConten',formData:formPage)`,这样就可以实现可选参数了。

### [#](https://jspang.com/posts/2019/03/01/flutter-shop.html#读取火爆专区数据)读取火爆专区数据

我们先声明两个变量，一个是火爆专区的商品列表数据，一个是当前的页数。

```text
  int page = 1;
  List<Map> hotGoodsList=[];
```

声明好变量后，我们就可以写一个获取数据的方法了。

```text
//火爆商品接口
  void _getHotGoods(){
     var formPage={'page': page};
     request('homePageBelowConten',formData:formPage).then((val){
       
       var data=json.decode(val.toString());
       List<Map> newGoodsList = (data['data'] as List ).cast();
       setState(() {
         hotGoodsList.addAll(newGoodsList);
         page++; 
       });
       
     
     });
  }
```

做好方法后，再`initState`方法里执行,就会得到数据了。

### [#](https://jspang.com/posts/2019/03/01/flutter-shop.html#火爆专区标题编写)火爆专区标题编写

火爆专区，我们先采用State的原始方法，来进行制作，因为这也是很多小伙伴要求的，所以我们主要讲解一下`StatefulWidget`的使用。下次我们写分类页面的时候会用Redux的方法，以为`StatefulWidget`的方法会让程序耦合性很强，不利于以后程序的维护。

因为首页我们采用`StatefulWidget`的方法，所以把标题写在内部。这次我们不采用方法返回`Widget`的方法了，而是采用变量的方法。

代码如下：

```text
//火爆专区标题
  Widget hotTitle= Container(
        margin: EdgeInsets.only(top: 10.0),
        
        padding:EdgeInsets.all(5.0),
        alignment:Alignment.center,
        decoration: BoxDecoration(
          color: Colors.white,
          border:Border(
            bottom: BorderSide(width:0.5 ,color:Colors.black12)
          )
        ),
        child: Text('火爆专区'),
   );
  
```

### [#](https://jspang.com/posts/2019/03/01/flutter-shop.html#warp流式布局的使用)Warp流式布局的使用

当看到下面的火爆商品列表时，很多小伙伴会想到`GridView Widget`，其实`GridView`组件的性能时很低的，毕竟网格的绘制不难么简单，所以这里使用了Warp来进行布局。`Warp`是一种流式布局。

可以先把火爆专区数据作成`List<Widget>`,然后再进行`Warp`布局。

```text
//火爆专区子项
  Widget _wrapList(){

    if(hotGoodsList.length!=0){
       List<Widget> listWidget = hotGoodsList.map((val){
          
          return InkWell(
            onTap:(){print('点击了火爆商品');},
            child: 
            Container(
              width: ScreenUtil().setWidth(372),
              color:Colors.white,
              padding: EdgeInsets.all(5.0),
              margin:EdgeInsets.only(bottom:3.0),
              child: Column(
                children: <Widget>[
                  Image.network(val['image'],width: ScreenUtil().setWidth(375),),
                  Text(
                    val['name'],
                    maxLines: 1,
                    overflow:TextOverflow.ellipsis ,
                    style: TextStyle(color:Colors.pink,fontSize: ScreenUtil().setSp(26)),
                  ),
                  Row(
                    children: <Widget>[
                      Text('￥${val['mallPrice']}'),
                      Text(
                        '￥${val['price']}',
                        style: TextStyle(color:Colors.black26,decoration: TextDecoration.lineThrough),
                        
                      )
                    ],
                  )
                ],
              ), 
            )
           
          );

      }).toList();

      return Wrap(
        spacing: 2,
        children: listWidget,
      );
    }else{
      return Text(' ');
    }
  }
```

有了标题和商品列表组件，我们就可以把这两个组件组合起来了，当然你不组合也是完全可以的。

```text
  //火爆专区组合
  Widget _hotGoods(){

    return Container(
          
          child:Column(
            children: <Widget>[
              hotTitle,
               _wrapList(),
            ],
          )   
    );
  }
```

## [#](https://jspang.com/posts/2019/03/01/flutter-shop.html#第20节：首页上拉加载更多功能的制作)第20节：首页上拉加载更多功能的制作

这节课学习一下上拉加载效果，其实现在上拉加载的插件有很多，但是还没有一个插件可以说完全一枝独秀，我也找了一个插件，这个插件的优点就是服务比较好，作者能及时回答大家的问题。我觉的选插件也是选人，人对了，插件就对了。

### flutter_easyrefresh简介

**flutter_easyrefresh官方简介：**

> 正如名字一样，EasyRefresh很容易就能在Flutter应用上实现下拉刷新以及上拉加载操作，它支持几乎所有的Flutter控件，但前提是需要包裹成ScrollView。它的功能与Android的SmartRefreshLayout很相似，同样也吸取了很多三方库的优点。EasyRefresh中集成了多种风格的Header和Footer，但是它并没有局限性，你可以很轻松的自定义。使用Flutter强大的动画，甚至随便一个简单的控件也可以完成。EasyRefresh的目标是为Flutter打造一个强大，稳定，成熟的下拉刷新框架。

**flutter_easyrefresh优点:**

- 能够自定义酷炫的Header和Footer，也就是上拉和下拉的效果。
- 更新及时，不断在完善，录课截至时已经是v1.2.7版本了。
- 有一个辅导群，虽然文档不太完善，但是有辅导群和详细的案例。
- 回掉方法简单，这个具体可以看下面的例子。

**引入依赖**

直接在`pubspec.yaml`中的`dependencies`中进行引入，主要要用最新版本，文章中的版本不一定是最新版本。

```text
dependencies:
 flutter_easyrefresh: ^1.2.7
```

引入后，在要使用的页面用`import`引入`package`，代码如下：

```text
import 'package:flutter_easyrefresh/easy_refresh.dart';
```

### [#](https://jspang.com/posts/2019/03/01/flutter-shop.html#制作上拉加载效果)制作上拉加载效果

使用这个插件，要求我们必须是一个ListView，所以我们要改造以前的代码，改造成ListView。

```text
  return EasyRefresh(
      child: ListView(
        children: <Widget>[
            SwiperDiy(swiperDataList:swiperDataList ),   //页面顶部轮播组件
            TopNavigator(navigatorList:navigatorList),   //导航组件
            AdBanner(advertesPicture:advertesPicture), 
            LeaderPhone(leaderImage:leaderImage,leaderPhone: leaderPhone),  //广告组件  
            Recommend(recommendList:recommendList),    
            FloorTitle(picture_address:floor1Title),
            FloorContent(floorGoodsList:floor1),
            FloorTitle(picture_address:floor2Title),
            FloorContent(floorGoodsList:floor2),
            FloorTitle(picture_address:floor3Title),
            FloorContent(floorGoodsList:floor3),
            _hotGoods(),
            
          ],
    ) ,
    loadMore: ()async{
        print('开始加载更多');
        var formPage={'page': page};
        await  request('homePageBelowConten',formData:formPage).then((val){
          var data=json.decode(val.toString());
          List<Map> newGoodsList = (data['data'] as List ).cast();
          setState(() {
            hotGoodsList.addAll(newGoodsList);
            page++; 
          });
        });
      },
  );
  
  
}else{
  return Center(
    child: Text('加载中'),
    
  );
}
```

具体的解释我就在视频中进行了，因为这个还是比较复杂的。

### [#](https://jspang.com/posts/2019/03/01/flutter-shop.html#自定义上拉加载效果)自定义上拉加载效果

因为它自带的样式是蓝色的，与我们的界面不太相符，所以我们改造一下，它的底部上拉刷新效果。如果你有兴趣做出更炫酷的效果，可以自行查看一下Github，学习一下。

```text
  refreshFooter: ClassicsFooter(
        key:_footerKey,
        bgColor:Colors.white,
        textColor: Colors.pink,
        moreInfoColor: Colors.pink,
        showMore: true,
        noMoreText: '',
        moreInfo: '加载中',
        loadReadyText:'上拉加载....'

      ),
```

做到这步我们需要进行调试一下，然后看一下我们的效果。

本节总结：这节课主要学习了`easy_refresh`组件的介绍和使用，并结合项目案例做出了上拉加载的效果。

## [#](https://jspang.com/posts/2019/03/01/flutter-shop.html#第21节：列表页类别数据接口调试)第21节：列表页类别数据接口调试

首页的内容我们先告一段落，从这节课开始制作列表页。当然列表页也是这套教程的一个难点。但是小伙伴们也不要为难情绪，我们也会从简到难，逐步讲解。

从这个页面开始，我们的课程也会加大难度，比如数据全部要`model`和状态要使用`bloc`来管理。

### 禁止滑动的设置

上节课完成了上拉加载，但是小伙伴可能没发现一个小BUG，就是我们的首页导航区域采用了`GridView`，这个和我们的`ListView`上拉加载是冲突的，我们的组件没有智能到为我们辨认，所以我们可以直接禁用`GridView`的滚动。代码如下

```text
  physics: NeverScrollableScrollPhysics(),
```

### [#](https://jspang.com/posts/2019/03/01/flutter-shop.html#接口文件编写)接口文件编写

一个新的接口，需要把这个接口配置放到`/config/servvice_url.dart`文件中。记得写注释。

```text
 'getCategory': serviceUrl+'wxmini/getCategory', //商品类别信息
```

添加完成侯，就可以直接在`catgoery_page.dart`中进行使用了。为什么可以直接使用那？因为已经在`/servic/service_method.dart`中写了一个通用的方法。

### [#](https://jspang.com/posts/2019/03/01/flutter-shop.html#测试接口的可用性)测试接口的可用性

后台接口部分写完，需要作的第一件事就是测试接口是否可用，因为我也不能保证接口的完全可用。所以我希望大家能掌握这种最简单的测试方法。可用后我们再作后续操作，这样能减少代码调试的难度。

重新改写`catgory_page.dart`文件，先引入需要的dart文件。

```text
import 'package:flutter/material.dart'; 
import '../service/service_method.dart';
import 'dart:convert';
```

有了引入后，用快速方法生成一个`StatefulWidget`,再删除一些无用的代码。代码如下：

```text
class CategoryPage extends StatefulWidget {
  _CategoryPageState createState() => _CategoryPageState();
}

class _CategoryPageState extends State<CategoryPage> {

  @override
  Widget build(BuildContext context) {
    _getCategory();
    return Container(
        child: Center(
          child: Text('分类页面'),
        ),
    );
  }
}
```

然后在`_CategoryPageState`中加入一个内部方法，这个内部方法就是为了测试一下接口。(注意这就是一个最简单的方法)

```text
  void _getCategory()async{
    await request('getCategory').then((val){
          var data = json.decode(val.toString());
          print(data);
    });
  }
```

方法写完后，我们在build方法里直接使用就可以了。

```text
  @override
  Widget build(BuildContext context) {
    _getCategory();
    return Container(
        child: Center(
          child: Text('sssss'),
        ),
    );
  }
```

课程总结：本节课程内容虽然较少，只是为了调通数据接口，所以也是课程必要环境，希望小伙伴们一定要课后练习。

## [#](https://jspang.com/posts/2019/03/01/flutter-shop.html#第22节：json解析与复杂模型转换技巧)第22节：JSON解析与复杂模型转换技巧

其实转换成model类是有好处的，转换后可以减少上线后APP崩溃和出现异常，所以我们从这节课开始，要制作model类模型，然后用model的形式编辑UI界面。在这里我不讨论两种方法的好坏，这就跟你看小电影是喜欢看欧美还是喜欢看岛国的一样，欧美的可能粗狂豪爽一点，岛国的优美婉约一点。

### 类别json的分析

比如现在从后台得到了一串JSON数据：

```text
{"code":"0","message":"success","data":[{"mallCategoryId":"4","mallCategoryName":"白酒","bxMallSubDto":[{"mallSubId":"2c9f6c94621970a801626a35cb4d0175","mallCategoryId":"4","mallSubName":"名酒","comments":""},{"mallSubId":"2c9f6c94621970a801626a363e5a0176","mallCategoryId":"4","mallSubName":"宝丰","comments":""},{"mallSubId":"2c9f6c94621970a801626a3770620177","mallCategoryId":"4","mallSubName":"北京二锅头","comments":""},{"mallSubId":"2c9f6c94679b4fb10167f7cc035c15a8","mallCategoryId":"4","mallSubName":"大明","comments":null},{"mallSubId":"2c9f6c94679b4fb10167f7cc2af915a9","mallCategoryId":"4","mallSubName":"杜康","comments":null},{"mallSubId":"2c9f6c94679b4fb10167f7cc535115aa","mallCategoryId":"4","mallSubName":"顿丘","comments":null},{"mallSubId":"2c9f6c94679b4fb10167f7cc77b215ab","mallCategoryId":"4","mallSubName":"汾酒","comments":null},{"mallSubId":"2c9f6c94679b4fb10167f7cca72e15ac","mallCategoryId":"4","mallSubName":"枫林","comments":null},{"mallSubId":"2c9f6c94679b4fb10167f7cccae215ad","mallCategoryId":"4","mallSubName":"高粱酒","comments":null},{"mallSubId":"2c9f6c94679b4fb10167f7ccf0d915ae","mallCategoryId":"4","mallSubName":"古井","comments":null},{"mallSubId":"2c9f6c94679b4fb10167f7cd1d6715af","mallCategoryId":"4","mallSubName":"贵州大曲","comments":null},{"mallSubId":"2c9f6c94679b4fb10167f7cd3f2815b0","mallCategoryId":"4","mallSubName":"国池","comments":null},{"mallSubId":"2c9f6c94679b4fb10167f7cd5d3015b1","mallCategoryId":"4","mallSubName":"国窖","comments":null},{"mallSubId":"2c9f6c94679b4fb10167f7cd7ced15b2","mallCategoryId":"4","mallSubName":"国台","comments":null},{"mallSubId":"2c9f6c94679b4fb10167f7cd9b9015b3","mallCategoryId":"4","mallSubName":"汉酱","comments":null},{"mallSubId":"2c9f6c94679b4fb10167f7cdbfd215b4","mallCategoryId":"4","mallSubName":"红星","comments":null},{"mallSubId":"2c9f6c946891d16801689474e2a70081","mallCategoryId":"4","mallSubName":"怀庄","comments":null},{"mallSubId":"2c9f6c94679b4fb10167f7cdddf815b5","mallCategoryId":"4","mallSubName":"剑南春","comments":null},{"mallSubId":"2c9f6c94679b4fb10167f7cdfd4815b6","mallCategoryId":"4","mallSubName":"江小白","comments":null},{"mallSubId":"2c9f6c94679b4fb1016802277c37160e","mallCategoryId":"4","mallSubName":"金沙","comments":null},{"mallSubId":"2c9f6c94679b4fb10167f7ce207015b7","mallCategoryId":"4","mallSubName":"京宫","comments":null},{"mallSubId":"2c9f6c94679b4fb10167f7ce46d415b8","mallCategoryId":"4","mallSubName":"酒鬼","comments":null},{"mallSubId":"2c9f6c94679b4fb101680226de23160d","mallCategoryId":"4","mallSubName":"口子窖","comments":null},{"mallSubId":"2c9f6c94679b4fb10167f7ce705515b9","mallCategoryId":"4","mallSubName":"郎酒","comments":null},{"mallSubId":"2c9f6c94679b4fb10167f7ce989e15ba","mallCategoryId":"4","mallSubName":"老口子","comments":null},{"mallSubId":"2c9f6c94679b4fb10167f7cec30915bb","mallCategoryId":"4","mallSubName":"龙江家园","comments":null},{"mallSubId":"2c9f6c94679b4fb10167f7cef15c15bc","mallCategoryId":"4","mallSubName":"泸州","comments":null},{"mallSubId":"2c9f6c94679b4fb10167f7cf156f15bd","mallCategoryId":"4","mallSubName":"鹿邑大曲","comments":null},{"mallSubId":"2c9f6c94679b4fb10167f7cf425b15be","mallCategoryId":"4","mallSubName":"毛铺","comments":null},{"mallSubId":"2c9f6c94679b4fb10167f7cf9dc915c0","mallCategoryId":"4","mallSubName":"绵竹","comments":null},{"mallSubId":"2c9f6c94679b4fb10167f7cfbf1c15c1","mallCategoryId":"4","mallSubName":"难得糊涂","comments":null},{"mallSubId":"2c9f6c94679b4fb10167f7cfdd7215c2","mallCategoryId":"4","mallSubName":"牛二爷","comments":null},{"mallSubId":"2c9f6c94679b4fb10167f7cf71e715bf","mallCategoryId":"4","mallSubName":"茅台","comments":null},{"mallSubId":"2c9f6c94679b4fb10167f7d7eda715c3","mallCategoryId":"4","mallSubName":"绵竹","comments":null},{"mallSubId":"2c9f6c94679b4fb10167f7d96e5c15c4","mallCategoryId":"4","mallSubName":"难得糊涂","comments":null},{"mallSubId":"2c9f6c94679b4fb10167f7dab93b15c5","mallCategoryId":"4","mallSubName":"牛二爷","comments":null},{"mallSubId":"2c9f6c94679b4fb10167f7dae16415c6","mallCategoryId":"4","mallSubName":"牛栏山","comments":null},{"mallSubId":"2c9f6c94679b4fb10167f7db11cb15c7","mallCategoryId":"4","mallSubName":"前门","comments":null},{"mallSubId":"2c9f6c94679b4fb10167f7db430c15c8","mallCategoryId":"4","mallSubName":"全兴","comments":null},{"mallSubId":"2c9f6c94679b4fb10167f7db6cac15c9","mallCategoryId":"4","mallSubName":"舍得","comments":null},{"mallSubId":"2c9f6c94679b4fb10167f7db9a4415ca","mallCategoryId":"4","mallSubName":"双沟","comments":null},{"mallSubId":"2c9f6c94679b4fb10167f7dc30b815cb","mallCategoryId":"4","mallSubName":"水井坊","comments":null},{"mallSubId":"2c9f6c94679b4fb10167f7dc543e15cc","mallCategoryId":"4","mallSubName":"四特","comments":null},{"mallSubId":"2c9f6c94679b4fb10167f7dc765c15cd","mallCategoryId":"4","mallSubName":"潭酒","comments":null},{"mallSubId":"2c9f6c94679b4fb10167f7dc988a15ce","mallCategoryId":"4","mallSubName":"沱牌","comments":null},{"mallSubId":"2c9f6c94679b4fb10167f7dcba5a15cf","mallCategoryId":"4","mallSubName":"五粮液","comments":null},{"mallSubId":"2c9f6c94679b4fb10167f7dcd9e815d0","mallCategoryId":"4","mallSubName":"西凤","comments":null},{"mallSubId":"2c9f6c94679b4fb10167f7dcf6d715d1","mallCategoryId":"4","mallSubName":"习酒","comments":null},{"mallSubId":"2c9f6c94679b4fb10167f7dd11b215d2","mallCategoryId":"4","mallSubName":"小白杨","comments":null},{"mallSubId":"2c9f6c94679b4fb10167f7dd2f3c15d3","mallCategoryId":"4","mallSubName":"洋河","comments":null},{"mallSubId":"2c9f6c94679b4fb10167f7dd969115d4","mallCategoryId":"4","mallSubName":"伊力特","comments":null},{"mallSubId":"2c9f6c94679b4fb10167f7ddb16c15d5","mallCategoryId":"4","mallSubName":"张弓","comments":null},{"mallSubId":"2c9f6c94679b4fb10167f7ddd6c715d6","mallCategoryId":"4","mallSubName":"中粮","comments":null},{"mallSubId":"2c9f6c94679b4fb10167f7de126815d7","mallCategoryId":"4","mallSubName":"竹叶青","comments":null}],"comments":null,"image":"http://images.baixingliangfan.cn/firstCategoryPicture/20190131/20190131170036_4477.png"},{"mallCategoryId":"1","mallCategoryName":"啤酒","bxMallSubDto":[{"mallSubId":"2c9f6c946016ea9b016016f79c8e0000","mallCategoryId":"1","mallSubName":"百威","comments":""},{"mallSubId":"2c9f6c94608ff843016095163b8c0177","mallCategoryId":"1","mallSubName":"福佳","comments":""},{"mallSubId":"402880e86016d1b5016016db9b290001","mallCategoryId":"1","mallSubName":"哈尔滨","comments":""},{"mallSubId":"402880e86016d1b5016016dbff2f0002","mallCategoryId":"1","mallSubName":"汉德","comments":""},{"mallSubId":"2c9f6c946449ea7e01647cd6830e0022","mallCategoryId":"1","mallSubName":"崂山","comments":""},{"mallSubId":"2c9f6c946449ea7e01647cd706a60023","mallCategoryId":"1","mallSubName":"林德曼","comments":""},{"mallSubId":"2c9f6c94679b4fb10167f7e1411b15d8","mallCategoryId":"1","mallSubName":"青岛","comments":null},{"mallSubId":"2c9f6c94679b4fb10167f7e1647215d9","mallCategoryId":"1","mallSubName":"三得利","comments":null},{"mallSubId":"2c9f6c94679b4fb10167f7e182e715da","mallCategoryId":"1","mallSubName":"乌苏","comments":null},{"mallSubId":"2c9f6c9468118c9c016811ab16bf0001","mallCategoryId":"1","mallSubName":"雪花","comments":null},{"mallSubId":"2c9f6c9468118c9c016811aa6f440000","mallCategoryId":"1","mallSubName":"燕京","comments":null},{"mallSubId":"2c9f6c94679b4fb10167f7e19b8f15db","mallCategoryId":"1","mallSubName":"智美","comments":null}],"comments":null,"image":"http://images.baixingliangfan.cn/firstCategoryPicture/20190131/20190131170044_9165.png"},{"mallCategoryId":"2","mallCategoryName":"葡萄酒","bxMallSubDto":[{"mallSubId":"2c9f6c9460337d540160337fefd60000","mallCategoryId":"2","mallSubName":"澳大利亚","comments":""},{"mallSubId":"402880e86016d1b5016016e083f10010","mallCategoryId":"2","mallSubName":"德国","comments":""},{"mallSubId":"402880e86016d1b5016016df1f92000c","mallCategoryId":"2","mallSubName":"法国","comments":""},{"mallSubId":"2c9f6c94621970a801626a40feac0178","mallCategoryId":"2","mallSubName":"南非","comments":""},{"mallSubId":"2c9f6c94679b4fb10167f7e5c9a115dc","mallCategoryId":"2","mallSubName":"葡萄牙","comments":null},{"mallSubId":"2c9f6c94679b4fb10167f7e5e68f15dd","mallCategoryId":"2","mallSubName":"西班牙","comments":null},{"mallSubId":"2c9f6c94679b4fb10167f7e609f515de","mallCategoryId":"2","mallSubName":"新西兰","comments":null},{"mallSubId":"2c9f6c94679b4fb10167f7e6286a15df","mallCategoryId":"2","mallSubName":"意大利","comments":null},{"mallSubId":"2c9f6c94679b4fb10167f7e6486615e0","mallCategoryId":"2","mallSubName":"智利","comments":null},{"mallSubId":"2c9f6c94679b4fb10167f7e66c6815e1","mallCategoryId":"2","mallSubName":"中国","comments":null}],"comments":null,"image":"http://images.baixingliangfan.cn/firstCategoryPicture/20190131/20190131170053_878.png"},{"mallCategoryId":"3","mallCategoryName":"清酒洋酒","bxMallSubDto":[{"mallSubId":"402880e86016d1b5016016e135440011","mallCategoryId":"3","mallSubName":"清酒","comments":""},{"mallSubId":"402880e86016d1b5016016e171cc0012","mallCategoryId":"3","mallSubName":"洋酒","comments":""}],"comments":null,"image":"http://images.baixingliangfan.cn/firstCategoryPicture/20190131/20190131170101_6957.png"},{"mallCategoryId":"5","mallCategoryName":"保健酒","bxMallSubDto":[{"mallSubId":"2c9f6c94609a62be0160a02d1dc20021","mallCategoryId":"5","mallSubName":"黄酒","comments":""},{"mallSubId":"2c9f6c94648837980164883ff6980000","mallCategoryId":"5","mallSubName":"药酒","comments":""}],"comments":null,"image":"http://images.baixingliangfan.cn/firstCategoryPicture/20190131/20190131170110_6581.png"},{"mallCategoryId":"2c9f6c946449ea7e01647ccd76a6001b","mallCategoryName":"预调酒","bxMallSubDto":[{"mallSubId":"2c9f6c946449ea7e01647d02f6250026","mallCategoryId":"2c9f6c946449ea7e01647ccd76a6001b","mallSubName":"果酒","comments":""},{"mallSubId":"2c9f6c946449ea7e01647d031bae0027","mallCategoryId":"2c9f6c946449ea7e01647ccd76a6001b","mallSubName":"鸡尾酒","comments":""},{"mallSubId":"2c9f6c946449ea7e01647d03428f0028","mallCategoryId":"2c9f6c946449ea7e01647ccd76a6001b","mallSubName":"米酒","comments":""}],"comments":null,"image":"http://images.baixingliangfan.cn/firstCategoryPicture/20190131/20190131170124_4760.png"},{"mallCategoryId":"2c9f6c946449ea7e01647ccf3b97001d","mallCategoryName":"下酒小菜","bxMallSubDto":[{"mallSubId":"2c9f6c946449ea7e01647dc18e610035","mallCategoryId":"2c9f6c946449ea7e01647ccf3b97001d","mallSubName":"熟食","comments":""},{"mallSubId":"2c9f6c946449ea7e01647dc1d9070036","mallCategoryId":"2c9f6c946449ea7e01647ccf3b97001d","mallSubName":"火腿","comments":""},{"mallSubId":"2c9f6c946449ea7e01647dc1fc3e0037","mallCategoryId":"2c9f6c946449ea7e01647ccf3b97001d","mallSubName":"速冻食品","comments":""}],"comments":null,"image":"http://images.baixingliangfan.cn/firstCategoryPicture/20190131/20190131170133_4419.png"},{"mallCategoryId":"2c9f6c946449ea7e01647ccdb0e0001c","mallCategoryName":"饮料","bxMallSubDto":[{"mallSubId":"2c9f6c946449ea7e01647d09cbf6002d","mallCategoryId":"2c9f6c946449ea7e01647ccdb0e0001c","mallSubName":"茶饮","comments":""},{"mallSubId":"2c9f6c946449ea7e01647d09f7e8002e","mallCategoryId":"2c9f6c946449ea7e01647ccdb0e0001c","mallSubName":"水饮","comments":""},{"mallSubId":"2c9f6c946449ea7e01647d0a27e1002f","mallCategoryId":"2c9f6c946449ea7e01647ccdb0e0001c","mallSubName":"功能饮料","comments":""},{"mallSubId":"2c9f6c946449ea7e01647d0b1d4d0030","mallCategoryId":"2c9f6c946449ea7e01647ccdb0e0001c","mallSubName":"果汁","comments":""},{"mallSubId":"2c9f6c946449ea7e01647d14192b0031","mallCategoryId":"2c9f6c946449ea7e01647ccdb0e0001c","mallSubName":"含乳饮料","comments":""},{"mallSubId":"2c9f6c946449ea7e01647d24d9600032","mallCategoryId":"2c9f6c946449ea7e01647ccdb0e0001c","mallSubName":"碳酸饮料","comments":""}],"comments":null,"image":"http://images.baixingliangfan.cn/firstCategoryPicture/20190131/20190131170143_361.png"},{"mallCategoryId":"2c9f6c946449ea7e01647cd108b60020","mallCategoryName":"乳制品","bxMallSubDto":[{"mallSubId":"2c9f6c946449ea7e01647dd4ac8c0048","mallCategoryId":"2c9f6c946449ea7e01647cd108b60020","mallSubName":"常温纯奶","comments":""},{"mallSubId":"2c9f6c946449ea7e01647dd4f6a40049","mallCategoryId":"2c9f6c946449ea7e01647cd108b60020","mallSubName":"常温酸奶","comments":""},{"mallSubId":"2c9f6c946449ea7e01647dd51ab7004a","mallCategoryId":"2c9f6c946449ea7e01647cd108b60020","mallSubName":"低温奶","comments":""}],"comments":null,"image":"http://images.baixingliangfan.cn/firstCategoryPicture/20190131/20190131170151_9234.png"},{"mallCategoryId":"2c9f6c946449ea7e01647ccfddb3001e","mallCategoryName":"休闲零食","bxMallSubDto":[{"mallSubId":"2c9f6c946449ea7e01647dc51d93003c","mallCategoryId":"2c9f6c946449ea7e01647ccfddb3001e","mallSubName":"方便食品","comments":""},{"mallSubId":"2c9f6c946449ea7e01647dd204dc0040","mallCategoryId":"2c9f6c946449ea7e01647ccfddb3001e","mallSubName":"面包糕点","comments":""},{"mallSubId":"2c9f6c946449ea7e01647dd22f760041","mallCategoryId":"2c9f6c946449ea7e01647ccfddb3001e","mallSubName":"糖果巧克力","comments":""},{"mallSubId":"2c9f6c946449ea7e01647dd254530042","mallCategoryId":"2c9f6c946449ea7e01647ccfddb3001e","mallSubName":"膨化食品","comments":""},{"mallSubId":"2c9f6c94679b4fb10167f7fa132b15e7","mallCategoryId":"2c9f6c946449ea7e01647ccfddb3001e","mallSubName":"坚果炒货","comments":null},{"mallSubId":"2c9f6c94679b4fb10167f7f4bfc415e2","mallCategoryId":"2c9f6c946449ea7e01647ccfddb3001e","mallSubName":"肉干豆干","comments":null},{"mallSubId":"2c9f6c94679b4fb10167f7f5027a15e3","mallCategoryId":"2c9f6c946449ea7e01647ccfddb3001e","mallSubName":"饼干","comments":null},{"mallSubId":"2c9f6c94679b4fb10167f7f530fd15e4","mallCategoryId":"2c9f6c946449ea7e01647ccfddb3001e","mallSubName":"冲调","comments":null},{"mallSubId":"2c9f6c94683a6b0d016846b49436003b","mallCategoryId":"2c9f6c946449ea7e01647ccfddb3001e","mallSubName":"休闲水果","comments":null}],"comments":null,"image":"http://images.baixingliangfan.cn/firstCategoryPicture/20190131/20190131170200_7553.png"},{"mallCategoryId":"2c9f6c946449ea7e01647cd08369001f","mallCategoryName":"粮油调味","bxMallSubDto":[{"mallSubId":"2c9f6c946449ea7e01647dd2e8270043","mallCategoryId":"2c9f6c946449ea7e01647cd08369001f","mallSubName":"油/粮食","comments":""},{"mallSubId":"2c9f6c946449ea7e01647dd31bca0044","mallCategoryId":"2c9f6c946449ea7e01647cd08369001f","mallSubName":"调味品","comments":""},{"mallSubId":"2c9f6c946449ea7e01647dd35a980045","mallCategoryId":"2c9f6c946449ea7e01647cd08369001f","mallSubName":"酱菜罐头","comments":""}],"comments":null,"image":"http://images.baixingliangfan.cn/firstCategoryPicture/20181212/20181212115842_9733.png"},{"mallCategoryId":"2c9f6c9468a85aef016925444ddb271b","mallCategoryName":"积分商品","bxMallSubDto":[],"comments":null,"image":"http://images.baixingliangfan.cn/firstCategoryPicture/20190225/20190225232703_9950.png"}]}
```

我们可以使用这个网站格式化一下`JSON`数据，然后简单分析一下。

> http://www.bejson.com/

视频中我会带着你简单的分析一下这个接口的数据。

### [#](https://jspang.com/posts/2019/03/01/flutter-shop.html#模型层的建立)模型层的建立

把模型层单独放到一个文件夹里，然后建立一个`category.dart`文件。这个文件就是要结合`json`文件，形成的modle文件。文件里大量使用了dart中的 `factory`语法。

**工厂构造函数**

> factory 关键字的功能，当实现构造函数但是不想每次都创建该类的一个实例的时候使用。

工厂模式是我们最常用的实例化对象模式了，是用工厂方法代替new操作的一种模式。用简单明了的方式解释，模式上类似于面向对象的多态，用起来和静态方法差不多。高雅和低俗的结合，相当于听着贝多芬的交响乐《命运》，看着波多野结衣的岛国小电影，只要你爽，什么都可以。

我们先制作了一个大分类的`Class`,代码如下：

```text
class CategoryBigModel {
  String mallCategoryId;    //类别编号
  String mallCategoryName;  //类别名称
  List<dynamic> bxMallSubDto;        //小类列表
  String image;             //类别图片
  Null comments;          //列表描述

  //构造函数
  CategoryBigModel({
    this.mallCategoryId,
    this.mallCategoryName,
    this.comments,
    this.image,
    this.bxMallSubDto
  });

  //工厂模式-用这种模式可以省略New关键字
  factory CategoryBigModel.fromJson(dynamic json){

    return CategoryBigModel(
      mallCategoryId:json['mallCategoryId'],
      mallCategoryName:json['mallCategoryName'],
      comments:json['comments'],
      image:json['image'],
      bxMallSubDto:json['bxMallSubDto']
    );

  }
  
}
```

这个只是单个的一个大类信息的模型，但我们是一个列表，这时候就需要制作一个列表的模型，而这个List里边是我们定义的`CategoryBigModel`模型。简单理解就是先定义一个单项模型，然后再定义个列表的模型。

代码如下：

```text
class CategoryBigListModel {

  List<CategoryBigModel> data;
  CategoryBigListModel(this.data);
  factory CategoryBigListModel.formJson(List json){
    return CategoryBigListModel(
      json.map((i)=>CategoryBigModel.fromJson((i))).toList()
    );
  }
  
}
```

这样就建立好了一个模型，其实这个模型还可以继续建立，以后的课程中也会逐渐深入。这里到这里，相信大家都掌握了建立模型的方法。

### [#](https://jspang.com/posts/2019/03/01/flutter-shop.html#数据模型的使用)数据模型的使用

使用数据模型就简单很多了。直接声明变量，调用`formJson`方法就可以了。直接在`_getCategory()`方法里。记得先引入数据模型类，然后用`.`的形式进行输出了。

```text
import '../model/category.dart';
void _getCategory()async{
  await request('getCategory').then((val){
        var data = json.decode(val.toString());
        
        CategoryBigListModel list = CategoryBigListModel.formJson(data['data']);
        
        list.data.forEach((item)=>print(item.mallCategoryName));
        
  });
}
```

写完这些，你就可以在控制台看到结果了。如果是第一次接触数据模型，可能还是稍微有些绕的。

### [#](https://jspang.com/posts/2019/03/01/flutter-shop.html#json-to-dart的使用)json_to_dart的使用

如果我们得到一个特别复杂的`JSON`,有时候会无从下手开始写`Model`,这时候就可以使用一些辅助工具。我认为`json_to_dart`是比较好用的一个。它可以直接把json转换成dart类，然后进行一定的修改，就可以快乐的使用了。工作中我拿到一个json，都是先操作一下，然后再改的。算是一个小窍门吧。

请记住网址：

> https://javiercbk.github.io/json_to_dart/

本节总结:本节主要对分类页面的分类中的大类进行了分析，然后又学习了json转数据模型的方法，最后讲解了如何使用`json_to_dart`转换复杂模型的方法。

## [#](https://jspang.com/posts/2019/03/01/flutter-shop.html#第23节：列表页大类展示效果制作)第23节：列表页大类展示效果制作

上节课我们学习了数据模型的建立，这节学习一下如何把建立好的数据模型展示在UI界面上，特别是这种`List`形式的数据模型。

### 自动生成数据模型

上节课课再最后我讲了一个快速生成的方法，但是很多小伙伴都问我，生成后如何使用。所以就在这节详细讲一下平时自动生成Modle的使用方法。

首先我们到下面网址，自动生成model模型。

> https://javiercbk.github.io/json_to_dart/

然后一定根据自己的需要改一下名字，比如这里是类别Model，我们就改名为`CategoryModel`。

如果以后内容很多，记得不要类的名字重复，否则到时候不好找到问题。

### [#](https://jspang.com/posts/2019/03/01/flutter-shop.html#左侧动态菜单的建立)左侧动态菜单的建立

这里使用类的形式建立一个动态菜单，所以用快捷键stful，快速建立了一个名字为`LeftCategoryNav`的`StatefulWidget`。并声明了一个List数据，起名就叫list。具体代码如下：

```text
//左侧导航菜单
class LeftCategoryNav extends StatefulWidget {
  
  _LeftCategoryNavState createState() => _LeftCategoryNavState();
}

class _LeftCategoryNavState extends State<LeftCategoryNav> {
   List list=[];
   
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
```

把上节课的调用后台类别的方法拷贝到这里，并进行改写。注意这里我们使用了setState来改变lsit 的状态，这样我们从后台获取数据后，页面就会有数据。

```text
void _getCategory()async{
  await request('getCategory').then((val){
        var data = json.decode(val.toString());
          
          CategoryModel category= CategoryModel.fromJson(data);
        
        setState(() {
          list =category.data;

        });
  });
}
```

### [#](https://jspang.com/posts/2019/03/01/flutter-shop.html#编写大类子项)编写大类子项

把大类里的子项分成一个单独的方法，这样可以起到复用的作用。主要知识点是用模型的形式展示数据。

```text
Widget _leftInkWel(int index){
    return InkWell(
      onTap: (){},
      child: Container(
        height: ScreenUtil().setHeight(100),
        padding:EdgeInsets.only(left:10,top:20),
        decoration: BoxDecoration(
          color: Colors.white,
          border:Border(
            bottom:BorderSide(width: 1,color:Colors.black12)
          )
        ),
        child: Text(list[index].mallCategoryName,style: TextStyle(fontSize:ScreenUtil().setSp(28)),),
      ),
    );
}
```

### [#](https://jspang.com/posts/2019/03/01/flutter-shop.html#完善build方法)完善build方法

当子类别写好后，可以对build方法进行完善，build方法我们采用动态的`ListView`来写，代码如下：

```text
@override
Widget build(BuildContext context) {
  return Container(
        width: ScreenUtil().setWidth(180),
        decoration: BoxDecoration(
          border: Border(
            right: BorderSide(width: 1,color:Colors.black12)
          )
        ),
        child: ListView.builder(
          itemCount:list.length,
          itemBuilder: (context,index){
            return _leftInkWel(index);
          },
        ),
        
    
  );
}
```

我们希望获取数据只在Widget初始化的时候进行，所以再重写一个`initState`方法。

```text
@override
void initState() {
  _getCategory();
  super.initState();
}
```

写完这步，就可以进行预览了，如果一切正常的话，在分类页面也该已经展示出了大类的一个类别列表。

## [#](https://jspang.com/posts/2019/03/01/flutter-shop.html#第24节：provide状态管理基础)第24节：Provide状态管理基础

项目的商品类别页面将大量的出现类和类中间的状态变化，这就需要状态管理。现在Flutter的状态管理方案很多，redux、bloc、state、Provide。

- Scoped Model : 最早的状态管理方案，我刚学Flutter的时候就使用的这个，虽然还有公司在用，但是大部分已经选用其它方案了。
- Redux：现在国内用的最多，因为咸鱼团队一直在用，还出了自己`fish redux`。
- bloc：个人觉的比Redux简单，而且好用，特别是一个页面里的状态管理，用起来很爽。
- state：我们首页里已经简单接触，缺点是耦合太强，如果是大型应用，管理起来非常混乱。
- Provide：是在Google的Github下的一个项目，刚出现不久，所以可以推测他是Google的亲儿子，用起来也是相当的爽。

所以个人觉的`Flutter_provide`是目前最好的状态管理方案，那我们就采用这种方案来制作项目。

### flutter_Provide简介

Provide是Google官方推出的状态管理模式。官方地址为：https://github.com/google/flutter-provide

> A simple framework for state management in Flutter

个人看来`Provide`被设计为ScopedModel的代替品，并且允许我们更加灵活地处理数据类型和数据。

### [#](https://jspang.com/posts/2019/03/01/flutter-shop.html#使用provide)使用Provide

这节课就简单用`flutter_provide`进行一个简单的小实例，例子是这样的，我们在一个页面上增加了`Text`和一个`RaisedButton`.并且故意使用了`StatelessWidget`作了两个类。也就是估计作了一个不可变的页面，并且用两个类隔离了。然后我们要点击按钮，增加数字数量，也就是把状态打通。

**制作最基本的页面**

快速写一个最基本的页面，并且全部使用了`StatelessWidget`进行。

```text
import 'package:flutter/material.dart';


class CartPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:Center(
        child: Column(
         children: <Widget>[
           Number(),
           MyButton()
         ],
        ),
      )
    );
  }
}


class Number extends StatelessWidget {
  
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top:200),
      child:Text('0')
    );
  }
}


class MyButton extends StatelessWidget {
  
  @override
  Widget build(BuildContext context) {
    return Container(
      child:RaisedButton(
        onPressed: (){},
        child: Text('递增'),
      )
    );
  }
}
```

**添加依赖**

在`pubspec.yaml`中添加Provide的依赖。请使用最新版本。

```text
dependencies:
    provide: ^1.0.2
```

**创建Provide**

这个类似于创建一个state，但是为了跟`State`区分，我们叫创建`Provide`。新建一个provide文件夹，然后再里边新建一个`counter.dart`文件.代码如下:

```text
import 'package:flutter/material.dart';

class Counter with ChangeNotifier {
  int value =0 ;

  increment(){
    value++;
    notifyListeners();
  }
}
```

这里混入了`ChangeNotifier`，意思是可以不用管理听众。现在你可以看到数和操作数据的方法都在`Provide`中，很清晰的把业务分离出来了。通过`notifyListeners`可以通知听众刷新。

**将状态放入顶层**

先引入`provide`和`counter`：

```text
import 'package:provide/provide.dart';
import './provide/counter.dart';
```

然后进行将`provide`和`counter`引入程序顶层。

```text
void main(){
  var counter =Counter();
  var providers  =Providers();
  providers
    ..provide(Provider<Counter>.value(counter));
  runApp(ProviderNode(child:MyApp(),providers:providers));
}
```

ProviderNode封装了InheritWidget，并且提供了 一个providers容器用于放置状态。

**获取状态**

使用`Provide Widget`的形式就可以获取状态，比如现在获取数字的状态，代码如下。

```text
class Number extends StatelessWidget {
  

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top:200),
      child: Provide<Counter>(
        builder: (context,child,counter){
          return Text(
            '${counter.value}',
             style: Theme.of(context).textTheme.display1,
          );
        },
      ),
    );
  }
}
```

**修改状态**

直接编写按钮的单击事件，并调用provide里的方法，代码修改如下。

```text
class MyButton extends StatelessWidget {
  

  @override
  Widget build(BuildContext context) {
    return Container(
      child:RaisedButton(
        onPressed: (){
          Provide.value<Counter>(context).increment();
        },
        child: Text('递增'),
      )
    );
  }
}
```

### [#](https://jspang.com/posts/2019/03/01/flutter-shop.html#其它页面读取状态)其它页面读取状态

为了更进一步说明状态是共享的，在“会员中心”页面，我们也显示出这个数字，代码如下:

```text
import 'package:flutter/material.dart';
import 'package:provide/provide.dart';
import '../provide/counter.dart';

class MemberPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:Center(
        child: Provide<Counter>(
        builder: (context,child,counter){
          return Text(
            '${counter.value}',
             style: Theme.of(context).textTheme.display1,
          );
        },
      ),
      )
    );
  }
}
```

本节总结:通过本节终结，可以掌握`flutter_provide`的使用方法，并作了一个最简单的案例。如果你以前使用过其它状态管理方案，你就会知道`provide`到底有多爽了。所以建议小伙伴使用`Provide`来进行管理状态。

## [#](https://jspang.com/posts/2019/03/01/flutter-shop.html#第25节：列表页-使用provide控制子类-1)第25节：列表页_使用`Provide`控制子类-1

上节课已经学习了基础的`flutter_provide`用法，也作了一个最基本的案例。这节课我们就把学到的知识用到实战案例当中，点击列表页的大类，改变小类的效果，当然这个程序还是稍微有点复杂，所以我们分两节课来讲。这里建议，如果你对上节的知识还没有完全掌握，那你需要多看几遍上节课的视频。并做出课程中的效果。

### 编写二级分类UI

学到现在，编写任何UI应该都非常容易了，我这里就先给出代码了。具体的介绍就在视频中解释了。值得说的是，我们故意重新写了一个类，让我们的代码解耦，形成一个独立的小部件。

```text
//右侧小类类别

class RightCategoryNav extends StatefulWidget {
  _RightCategoryNavState createState() => _RightCategoryNavState();
}

class _RightCategoryNavState extends State<RightCategoryNav> {

  List list = ['名酒','宝丰','北京二锅头'];
  
  @override
  Widget build(BuildContext context) {
    
    return Container(
    
    
      child:Container(
            height: ScreenUtil().setHeight(80),
            width: ScreenUtil().setWidth(570),
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border(
                bottom: BorderSide(width: 1,color: Colors.black12)
              )
            ),
            child:ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: list.length,
              itemBuilder: (context,index){
                return _rightInkWell(list[index]);
              },
            )
          );
    );
  }

  Widget _rightInkWell(String item){

    return InkWell(
      onTap: (){},
      child: Container(
        padding:EdgeInsets.fromLTRB(5.0,10.0,5.0,10.0),
        
        child: Text(
          item,
          style: TextStyle(fontSize:ScreenUtil().setSp(28)),
        ),
      ),
    );
  }
```

### [#](https://jspang.com/posts/2019/03/01/flutter-shop.html#添加到界面中)添加到界面中

在`category_page.dart`的`CategoryPage`类的build方法里，加入右侧子类导航区域.

```text
Widget build(BuildContext context) {
  return Scaffold(
    appBar: AppBar(
      title: Text('商品分类'),
    ),
    body: Container(
      child: Row(
        children: <Widget>[
          LeftCategoryNav(),
          Column(
            children: <Widget>[
              RightCategoryNav()
            ],
          )
        ],
      ),
    ),
  );
}
```

编写完后，我们就应该能看到效果，但是现在数据都是写死的，还没有实现状态的控制，但是我也不想把视频录制的太长，所以这节课程就做到这里。 我也建议你跟着视频中的效果制作，然后马上继续下一节。

## [#](https://jspang.com/posts/2019/03/01/flutter-shop.html#第26节：列表页-使用provide控制子类-2)第26节：列表页_使用`Provide`控制子类-2

上节课已经进行了二级分类的UI布局，并且已经显示到了页面上。但是并没有实现交互效果，那这节课我们就通过`Provide`管理全局app的状态，实现二级分类和一级分类的交互效果吧。



### 编写二级分类的Provide文件

我们先设置一个子类的`provide`，在`lib/provide/`文件夹下，新建一个`child_category.dart`文件，这个文件就是控制子类的状态管理文件。代码如下：

```text
import 'package:flutter/material.dart';
import '../model/category.dart';

//ChangeNotifier的混入是不用管理听众
class ChildCategory with ChangeNotifier{

    List<BxMallSubDto> childCategoryList = [];

    getChildCategory(List list){
      childCategoryList=list;
      notifyListeners();
    }
}
```

引入了`category.dart`的model文件，这样就可以很好的对象化，先声明了一个泛型的List变量`childCategoryList`。然后做了个方法，进行赋值。（注意这种形式也是在工作中最常用的一种形式。）

### [#](https://jspang.com/posts/2019/03/01/flutter-shop.html#main里进行引入)main里进行引入

```text
import './provide/child_category.dart';

void main(){
    var childCategory=ChildCategory();
    providers
    ..provide(Provider<Counter>.value(counter))
    ..provide(Provider<ChildCategory>.value(childCategory));
}
```

### [#](https://jspang.com/posts/2019/03/01/flutter-shop.html#修改二级分类状态)修改二级分类状态

有了`Provide`类之后，就可以修改二级分类了，这时候修改左侧大类的`InkWell`中的onTap方法。 先引入`child_category.dart`文件和`provide.dart`

```text
onTap: () {
    var childList = list[index].bxMallSubDto;
  
    Provide.value<ChildCategory>(context).getChildCategory(childList);
},
```

编写好后，其实状态已经改变了，那接下来就可以设置二级分类的修改状态了。

### [#](https://jspang.com/posts/2019/03/01/flutter-shop.html#二级分类展现)二级分类展现

修改右侧二级分类的展示，这个先改变子项的接受数据。把原来的item，改成`item.mallSubName`，修改后的代码如下：

```text
 Widget _rightInkWell(BxMallSubDto item){

    return InkWell(
      onTap: (){},
      child: Container(
        padding:EdgeInsets.fromLTRB(5.0,10.0,5.0,10.0),
        
        child: Text(
          item.mallSubName,
          style: TextStyle(fontSize:ScreenUtil().setSp(28)),
        ),
      ),
    );
  }
```

单项修改好后哦，再修改build里的`Container`，我们需要在`Container`外边加入一个`Provide`组件，注意这里使用了泛型。

```text
Widget build(BuildContext context) {
  
  return Container(
    // child: Text('${childCategory.childCategoryList.length}'),
  
    child: Provide<ChildCategory>(
      builder: (context,child,childCategory){
        return Container(
          height: ScreenUtil().setHeight(80),
          width: ScreenUtil().setWidth(570),
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border(
              bottom: BorderSide(width: 1,color: Colors.black12)
            )
          ),
          child:ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: childCategory.childCategoryList.length,
            itemBuilder: (context,index){
              return _rightInkWell(childCategory.childCategoryList[index]);
            },
          )
        );
      },
    )
  );
}
```

修改步骤：

1. 在`Container Widget`外层加入一个`Provie widget`。
2. 修改`ListView Widget`的`itemCount`选项为`childCategory.childCategoryList.length`。
3. 修改`itemBuilder`里的传值选项为`return _rightInkWell(childCategory.childCategoryList[index]);`

### [#](https://jspang.com/posts/2019/03/01/flutter-shop.html#交互效果的设置)交互效果的设置

现在二级分类已经能跟随我们的点击发生变化了，但是大类还没有高亮显示，所以要作一下交互效果，这种交互效果跟其它类或者页面没什么关系，所以我们还是使用最简单的`setState`来实现了。 这个变化主要在`_leftInkWell`里，所以操作也基本在这个里边。

1. 先声明一个变量，用于控制是否高亮显示`bool isClick=false;`。
2. 让`_leftInkWell`接收一个变量，变量是ListView传递过来的`Widget _leftInkWel(int index)`
3. 声明一个全局的变量`var listIndex = 0; //索引`
4. 对比index和listIndex`isClick=(index==listIndex)?true:false;`.
5. 修改为动态显示背景颜色`color: isClick?Colors.black26:Colors.white,`

全部代码如下：

```text
import 'package:flutter/material.dart';
import '../service/service_method.dart';
import 'dart:convert';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import '../model/category.dart';
import 'package:provide/provide.dart';
import '../provide/child_category.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';

class CategoryPage extends StatefulWidget {
  _CategoryPageState createState() => _CategoryPageState();
}

class _CategoryPageState extends State<CategoryPage> {
  // CategoryBigListModel listCategory = CategoryBigListModel([]);

  @override
Widget build(BuildContext context) {
  return Scaffold(
    appBar: AppBar(
      title: Text('商品分类'),
    ),
    body: Container(
      child: Row(
        children: <Widget>[
          LeftCategoryNav(),
          Column(
            children: <Widget>[
              RightCategoryNav()
            ],
          )
        ],
      ),
    ),
  );
}
}

//左侧导航菜单
class LeftCategoryNav extends StatefulWidget {
  _LeftCategoryNavState createState() => _LeftCategoryNavState();
}

class _LeftCategoryNavState extends State<LeftCategoryNav> {
  List list = [];
  var listIndex = 0; //索引

  @override
  void initState() {
    _getCategory();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: ScreenUtil().setWidth(180),
      decoration: BoxDecoration(
          border: Border(right: BorderSide(width: 1, color: Colors.black12))),
      child: ListView.builder(
        itemCount: list.length,
        itemBuilder: (context, index) {
          return _leftInkWel(index);
        },
      ),
    );
  }

  Widget _leftInkWel(int index) {
    bool isClick=false;
    isClick=(index==listIndex)?true:false;

    return InkWell(
      onTap: () {

         setState(() {
           listIndex=index;
         });
         var childList = list[index].bxMallSubDto;
        
         Provide.value<ChildCategory>(context).getChildCategory(childList);
      },
      child: Container(
        height: ScreenUtil().setHeight(100),
        padding: EdgeInsets.only(left: 10, top: 20),
        decoration: BoxDecoration(
            color: isClick?Colors.black26:Colors.white,
            border:
                Border(bottom: BorderSide(width: 1, color: Colors.black12))),
        child: Text(
          list[index].mallCategoryName,
          style: TextStyle(fontSize: ScreenUtil().setSp(28)),
        ),
      ),
    );
  }

  //得到后台大类数据
  void _getCategory() async {
    await request('getCategory').then((val) {
      var data = json.decode(val.toString());

      CategoryModel category = CategoryModel.fromJson(data);

      setState(() {
        list = category.data;
      });

       Provide.value<ChildCategory>(context).getChildCategory( list[0].bxMallSubDto);

      print(list[0].bxMallSubDto);

      list[0].bxMallSubDto.forEach((item) => print(item.mallSubName));
    });
  }
}

//右侧小类类别

class RightCategoryNav extends StatefulWidget {
  _RightCategoryNavState createState() => _RightCategoryNavState();
}

class _RightCategoryNavState extends State<RightCategoryNav> {

  
  
  @override
Widget build(BuildContext context) {
  
  return Container(
    // child: Text('${childCategory.childCategoryList.length}'),
  
    child: Provide<ChildCategory>(
      builder: (context,child,childCategory){
        return Container(
          height: ScreenUtil().setHeight(80),
          width: ScreenUtil().setWidth(570),
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border(
              bottom: BorderSide(width: 1,color: Colors.black12)
            )
          ),
          child:ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: childCategory.childCategoryList.length,
            itemBuilder: (context,index){
              return _rightInkWell(childCategory.childCategoryList[index]);
            },
          )
        );
      },
    )
  );
}

  Widget _rightInkWell(BxMallSubDto item){

    return InkWell(
      onTap: (){},
      child: Container(
        padding:EdgeInsets.fromLTRB(5.0,10.0,5.0,10.0),
        
        child: Text(
          item.mallSubName,
          style: TextStyle(fontSize:ScreenUtil().setSp(28)),
        ),
      ),
    );
  }
}
```

**课程总结:**

通过三节课的学习，你应该能基本掌握状态管理和界面交互效果改变的用法了，需要说明的是，状态管理在工作中有很高的作用，所以必须要掌握好，如果你还不能自己写出视频中的效果，我建议多练习几遍。这是Flutter技术的一个瓶颈，所以必须要掌握好。

## [#](https://jspang.com/posts/2019/03/01/flutter-shop.html#第27节：列表页现有bug的完善)第27节：列表页现有Bug的完善

这节先解决上节课遗留的小问题，作为一个有工匠精神的老司机，写程序一定要尽善尽美，所以把现有程序的Bug解决一下。

### 进入分类页面后小类无数据BUG

修改刚进入页面没有子类数据的方案非常简单，只要在进入页面后的`_getCategory`里在等到大类数据后，把第一个小类的数据同时进行状态修改。

代码如下:

```text
  //得到后台大类数据
  void _getCategory() async {
    await request('getCategory').then((val) {
      var data = json.decode(val.toString());

      CategoryModel category = CategoryModel.fromJson(data);

      setState(() {
        list = category.data;
      });

       Provide.value<ChildCategory>(context).getChildCategory( list[0].bxMallSubDto);
    });
  }
```

### [#](https://jspang.com/posts/2019/03/01/flutter-shop.html#反白显示颜色过重，使用rgbo颜色。)反白显示颜色过重，使用RGBO颜色。

这个直接使用Flutter里的RGBO模式就可以了，当然你也完全可以使用`Colors.black12`，但是为了让小伙伴见到更多的代码，我们这里采用RGBO的模式。在`_leftInkWell`中`Container`里设置颜色。代码如下：

```text
 color: isClick?Color.fromRGBO(236, 238, 239, 1.0):Colors.white,
```

全部代码如下：

```text
child: Container(
  height: ScreenUtil().setHeight(100),
  padding: EdgeInsets.only(left: 10, top: 20),
  decoration: BoxDecoration(
      color: isClick?Color.fromRGBO(236, 238, 239, 1.0):Colors.white,
      border:
          Border(bottom: BorderSide(width: 1, color: Colors.black12))),
  child: Text(
    list[index].mallCategoryName,
    style: TextStyle(fontSize: ScreenUtil().setSp(28)),
    
  ),
),
```

### [#](https://jspang.com/posts/2019/03/01/flutter-shop.html#添加子类“全部”按钮)添加子类“全部”按钮

我们可以看到，小程序上在二级分类上是有“全部”字样的，但我们作的这里并没有。其实加上这个全部也非常简单，只要我们在状态管理，改变状态的方法`getChildCategory`里，现加入一个全部的`BxMallSubDto`对象就可以了。

代码部分就是修改`provide/child_Category.dart`的`getchildCategory`方法。思路是声明一个all对象，然后进行赋值，复制后组成List赋给`childCategoryList`。然后把list添加到`childCategoryList`里。

全部代码：

```text
import 'package:flutter/material.dart';
import '../model/category.dart';

//ChangeNotifier的混入是不用管理听众
class ChildCategory with ChangeNotifier{

    List<BxMallSubDto> childCategoryList = [];



    getChildCategory(List<BxMallSubDto> list){
      BxMallSubDto all=  BxMallSubDto();
      all.mallSubId='00';
      all.mallCategoryId='00';
      all.mallSubName = '全部';
      all.comments = 'null';
      childCategoryList=[all];
      childCategoryList.addAll(list);   
      notifyListeners();
    }
}
```

这时候就可以使用了，把基本的Bug已经解决掉了。下节课我们开始作商品分类的列表页。

## [#](https://jspang.com/posts/2019/03/01/flutter-shop.html#第28节-列表页-商品列表接口调试)第28节:列表页_商品列表接口调试

这节课的主要内容就是调通商品分类页里的商品列表接口，这个接口是这套视频中最复杂也最重要的接口。接口包括上拉加载、大类切换和小类切换的互动，虽然复杂，小伙伴们也不要担心，我们会尽量讲的细致和简单，让每个伙伴都可以学会。

### 配置URL路径

对于后台接口的调试，应该有所了解了，第一步就是配置后台接口的路径到统一的配置文件中，这样方便以后的维护。

打开`lib\config\service_ulr.dart`文件，再最下面加上商品分类的商品列表接口路径，现在的配置文件，代码如下:

```text
const servicePath={
  'homePageContext': serviceUrl+'wxmini/homePageContent', // 商家首页信息
  'homePageBelowConten': serviceUrl+'wxmini/homePageBelowConten', //商城首页热卖商品拉取
  'getCategory': serviceUrl+'wxmini/getCategory', //商品类别信息
  'getMallGoods': serviceUrl+'wxmini/getMallGoods', //商品分类的商品列表
};
```

配置好后，保存文件。

### [#](https://jspang.com/posts/2019/03/01/flutter-shop.html#测试大类商品列表接口)测试大类商品列表接口

因为在前面的课程中的`lib\service\service_method.dart`文件中写了一个统一的方法，所以这里直接调试就可以了。在`lib\pages\category_page.dart`文件里，新建一个`CategoryGoodsList`类，这个类我们也将用状态管理的放心进行管理，所以这个类并没有什么其它的耦合，不接收任何参数。

```text
//商品列表，可以上拉加载

class CategoryGoodsList extends StatefulWidget {
  @override
  _CategoryGoodsListState createState() => _CategoryGoodsListState();
}

class _CategoryGoodsListState extends State<CategoryGoodsList> {

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text('商品列表'),
    );
  }

}
```

有了类以后，我们写一个内部获取后台数据的方法`_getGoodList`。先声明了一个变量`data`，用于放入传递的值。然后再把参数传递过去。具体代码如下:

```text
  void _getGoodList()async {
    var data={
      'categoryId':'4',
      'categorySubId':"",
      'page':1
    };
    await request('getMallGoods',formData:data ).then((val){
        var data = json.decode(val.toString());
        print('分类商品列表：>>>>>>>>>>>>>${data}');
    });

  }
```

然后我们在`initState`中调用一下：

```text
  @override
  void initState() {
    _getGoodList();
    super.initState();
  }
```

### [#](https://jspang.com/posts/2019/03/01/flutter-shop.html#调式代码如下)调式代码如下

为了方便小伙伴学习，这里给出全部代码：

```text
//商品列表，可以上拉加载

class CategoryGoodsList extends StatefulWidget {
  @override
  _CategoryGoodsListState createState() => _CategoryGoodsListState();
}

class _CategoryGoodsListState extends State<CategoryGoodsList> {

  @override
  void initState() {
    _getGoodList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text('商品列表'),
    );
  }

  void _getGoodList()async {
    var data={
      'categoryId':'4',
      'categorySubId':"",
      'page':1
    };
    await request('getMallGoods',formData:data ).then((val){
        var data = json.decode(val.toString());
        print('分类商品列表：>>>>>>>>>>>>>${data}');
    });

  }
}
```

写好后，如果一切正常应该可以在终端中看到输出的结果，如果有正常的列表结果输出，说明一切正常。

## [#](https://jspang.com/posts/2019/03/01/flutter-shop.html#第29节-列表页-商品列表数据模型的建立)第29节: 列表页_商品列表数据模型的建立

这节课我们先用快速的方法，生成我们商品分类李的商品列表数据模型，然后根据数据模型修改一下,读取后台的方法。

### 商品列表页数据模型

这里还是使用快速生成的方法，利用`https://javiercbk.github.io/json_to_dart/`,直接生成。

我先给出一段JSON数据，当然你页可以自己抓取，这非常的容易。

```text
{"code":"0","message":"success","data":[{"image":"http://images.baixingliangfan.cn/compressedPic/20190116145309_40.jpg","oriPrice":2.50,"presentPrice":1.80,"goodsName":"哈尔滨冰爽啤酒330ml","goodsId":"3194330cf25f43c3934dbb8c2a964ade"},{"image":"http://images.baixingliangfan.cn/compressedPic/20190115185215_1051.jpg","oriPrice":2.00,"presentPrice":1.80,"goodsName":"燕京啤酒8°330ml","goodsId":"522a3511f4c545ab9547db074bb51579"},{"image":"http://images.baixingliangfan.cn/compressedPic/20190121102419_9362.jpg","oriPrice":1.98,"presentPrice":1.80,"goodsName":"崂山清爽8°330ml","goodsId":"bbdbd5028cc849c2998ff84fb55cb934"},{"image":"http://images.baixingliangfan.cn/compressedPic/20180712181330_9746.jpg","oriPrice":2.50,"presentPrice":1.90,"goodsName":"雪花啤酒8°清爽330ml","goodsId":"87013c4315e54927a97e51d0645ece76"},{"image":"http://images.baixingliangfan.cn/compressedPic/20180712180233_4501.jpg","oriPrice":2.50,"presentPrice":2.20,"goodsName":"崂山啤酒8°330ml","goodsId":"86388a0ee7bd4a9dbe79f4a38c8acc89"},{"image":"http://images.baixingliangfan.cn/compressedPic/20190116164250_1839.jpg","oriPrice":2.50,"presentPrice":2.30,"goodsName":"哈尔滨小麦王10°330ml","goodsId":"d31a5a337d43433385b17fe83ce2676a"},{"image":"http://images.baixingliangfan.cn/compressedPic/20180712181139_2653.jpg","oriPrice":2.70,"presentPrice":2.50,"goodsName":"三得利清爽啤酒10°330ml","goodsId":"74a1fb6adc1f458bb6e0788c4859bf54"},{"image":"http://images.baixingliangfan.cn/compressedPic/20190121162731_3928.jpg","oriPrice":2.75,"presentPrice":2.50,"goodsName":"三得利啤酒7.5度超纯啤酒330ml","goodsId":"d52fa8ba9a5f40e6955be9e28a764f34"},{"image":"http://images.baixingliangfan.cn/compressedPic/20180712180452_721.jpg","oriPrice":4.50,"presentPrice":3.70,"goodsName":"青岛啤酒11°330ml","goodsId":"a42c0585015540efa7e9642ec1183940"},{"image":"http://images.baixingliangfan.cn/compressedPic/20190121170407_7423.jpg","oriPrice":4.40,"presentPrice":4.00,"goodsName":"三得利清爽啤酒500ml 10.0°","goodsId":"94ec3df73f4446b5a5f0d80a8e51eb9d"},{"image":"http://images.baixingliangfan.cn/compressedPic/20180712181427_6101.jpg","oriPrice":4.50,"presentPrice":4.00,"goodsName":"雪花勇闯天涯啤酒8°330ml","goodsId":"d80462faab814ac6a7124cec3b868cf7"},{"image":"http://images.baixingliangfan.cn/compressedPic/20180717151537_3425.jpg","oriPrice":4.90,"presentPrice":4.10,"goodsName":"百威啤酒听装9.7°330ml","goodsId":"91a849140de24546b0de9e23d85399a3"},{"image":"http://images.baixingliangfan.cn/compressedPic/20190121101926_2942.jpg","oriPrice":4.95,"presentPrice":4.50,"goodsName":"崂山啤酒8°500ml","goodsId":"3758bbd933b145f2a9c472bf76c4920c"},{"image":"http://images.baixingliangfan.cn/compressedPic/20180712175422_518.jpg","oriPrice":5.00,"presentPrice":4.50,"goodsName":"百威3.6%大瓶9.7°P460ml","goodsId":"dc32954b66814f40977be0255cfdacca"},{"image":"http://images.baixingliangfan.cn/compressedPic/20180717151454_4834.jpg","oriPrice":5.00,"presentPrice":4.50,"goodsName":"青岛啤酒大听装500ml","goodsId":"fc85510c3af7428dbf1cb0c1bcb43711"},{"image":"http://images.baixingliangfan.cn/compressedPic/20180712181007_4229.jpg","oriPrice":5.50,"presentPrice":5.00,"goodsName":"三得利金纯生啤酒580ml 9°","goodsId":"14bd89f066ca4949af5e4d5a1d2afaf8"},{"image":"http://images.baixingliangfan.cn/compressedPic/20190121100752_4292.jpg","oriPrice":6.60,"presentPrice":6.00,"goodsName":"哈尔滨啤酒冰纯白啤（小麦啤酒）500ml","goodsId":"89bccd56a8e9465692ccc469cd4b442e"},{"image":"http://images.baixingliangfan.cn/compressedPic/20180712175656_777.jpg","oriPrice":7.20,"presentPrice":6.60,"goodsName":"百威啤酒500ml","goodsId":"3a94dea560ef46008dad7409d592775d"},{"image":"http://images.baixingliangfan.cn/compressedPic/20180712180754_2838.jpg","oriPrice":7.78,"presentPrice":7.00,"goodsName":"青岛啤酒皮尔森10.5°330ml","goodsId":"97adb29137fb47689146a397e5351926"},{"image":"http://images.baixingliangfan.cn/compressedPic/20190116164149_2165.jpg","oriPrice":7.78,"presentPrice":7.00,"goodsName":"青岛全麦白啤11°500ml","goodsId":"f78826d3eb0546f6a2e58893d4a41b43"}]}
```

先复制上边的JSON，然后把复制的代码粘贴到`https://javiercbk.github.io/json_to_dart/`中，得到快速生成的Model类，在model文件夹下，新建一个文件`categoryGoodsList.dart`,这时候我们需要修改一下代码，防止产生冲突。修改完成的代码如下:

```text
class CategoryGoodsListModel {
  String code;
  String message;
  List<CategoryListData> data;

  CategoryGoodsListModel({this.code, this.message, this.data});

  CategoryGoodsListModel.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    message = json['message'];
    if (json['data'] != null) {
      data = new List<CategoryListData>();
      json['data'].forEach((v) {
        data.add(new CategoryListData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['code'] = this.code;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class CategoryListData {
  String image;
  double oriPrice;
  double presentPrice;
  String goodsName;
  String goodsId;

  CategoryListData(
      {this.image,
      this.oriPrice,
      this.presentPrice,
      this.goodsName,
      this.goodsId});

  CategoryListData.fromJson(Map<String, dynamic> json) {
    image = json['image'];
    oriPrice = json['oriPrice'];
    presentPrice = json['presentPrice'];
    goodsName = json['goodsName'];
    goodsId = json['goodsId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['image'] = this.image;
    data['oriPrice'] = this.oriPrice;
    data['presentPrice'] = this.presentPrice;
    data['goodsName'] = this.goodsName;
    data['goodsId'] = this.goodsId;
    return data;
  }
}
```

### [#](https://jspang.com/posts/2019/03/01/flutter-shop.html#修改-getgoodlist方法)修改`_getGoodList`方法

我们Model类做好后，需要在`lib\pages\category_page.dart`里进行引入，引入代码为：

```text
import '../model/categoryGoodsList.dart';
```

引入后修改`_getGoodList`方法，主要是让从后台得到的数据，可以使用数据模型。

```text
  void _getGoodList()async {
    var data={
      'categoryId':'4',
      'categorySubId':"",
      'page':1
    };
    await request('getMallGoods',formData:data ).then((val){
        var  data = json.decode(val.toString());
        CategoryGoodsListModel goodsList=  CategoryGoodsListModel.fromJson(data);
        setState(() {
         list= goodsList.data;
        });
        print('>>>>>>>>>>>>>>>>>>>:${list[0].goodsName}');
    });
  }
```

写完后测试一下，如果可以在控制台输出，想要的结果，说明我们的Model类建立完成了。

我们紧接着学习下一节，把我们的UI界面制作一下，为了小伙伴们看着更方便，所以拆成了两节。

## [#](https://jspang.com/posts/2019/03/01/flutter-shop.html#第30接：列表页-商品列表ui布局)第30接：列表页_商品列表UI布局

接上节课，其实我觉的小伙伴们对布局一定是没有问题了，所以我把布局这节课单独拿出来了，小伙伴完全可以不看这节课的内容，自己写出一个自己喜欢的布局效果。但是为了保证课程的完整性，所以这节必须进行录制，防止有些小伙伴做不出来这个效果。

我们在首页的时候已经使用Wrap的布局方式制作火爆专区列表，这节课如果还用Wrap的形式就没有什么意思了，所以这里使用ListView的形式，可能跟模仿的小程序稍微有些不同，但我们的目标是学知识。

### 商品图片方法编写

我们把这个列表拆分成三个内部方法，分别是商品图片、商品名称和商品价格。这样拆分可以减少耦合和维护难度。

先来制作图片的内部方法,代码如下：

```text
  Widget _goodsImage(index){

    return  Container(
      width: ScreenUtil().setWidth(200),
      child: Image.network(list[index].image),
    );

  }
```

### [#](https://jspang.com/posts/2019/03/01/flutter-shop.html#商品名称方法编写)商品名称方法编写

这个我们直接返回一个`Container`，然后在里边子组件里放一个`Text`，需要对Text进行一些样式设置，防止越界。

```text
  Widget _goodsName(index){
    return Container( 
      padding: EdgeInsets.all(5.0),
      width: ScreenUtil().setWidth(370),
      child: Text(
        list[index].goodsName,
        maxLines: 2,
        overflow: TextOverflow.ellipsis,
        style: TextStyle(fontSize: ScreenUtil().setSp(28)),
        ),
      );
  }
```

### [#](https://jspang.com/posts/2019/03/01/flutter-shop.html#商品价格方法编写)商品价格方法编写

商品价格我们在`Container`里放置一个`Row`,这样就能实现同一排显示，具体可以查看代码。

```text
  Widget _goodsPrice(index){
    return  Container( 
      margin: EdgeInsets.only(top:20.0),
      width: ScreenUtil().setWidth(370),
      child:Row(
        children: <Widget>[
            Text(
              '价格:￥${list[index].presentPrice}',
              style: TextStyle(color:Colors.pink,fontSize:ScreenUtil().setSp(30)),
              ),
            Text(
              '￥${list[index].oriPrice}',
              style: TextStyle(
                color: Colors.black26,
                decoration: TextDecoration.lineThrough
              ),
            )
        ]
      )
    );
  }
```

### [#](https://jspang.com/posts/2019/03/01/flutter-shop.html#把方法进行组合)把方法进行组合

把一个列表项分成了好几个方法，现在需要把每一个方法进行组合。具体代码如下，我会在视频中进行详细讲解。

```text
  Widget _ListWidget(int index){

    return InkWell(
      onTap: (){},
      child: Container(
        padding: EdgeInsets.only(top: 5.0,bottom: 5.0),
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border(
            bottom: BorderSide(width: 1.0,color: Colors.black12)
          )
        ),
        
        child: Row(
          children: <Widget>[
            _goodsImage(index)
           ,
            Column(
              children: <Widget>[
                _goodsName(index),
                _goodsPrice(index)
              ],
            )
          ],
        ),
      )
    );

  }
```

### [#](https://jspang.com/posts/2019/03/01/flutter-shop.html#listview的构建)ListView的构建

组合完成后，在build方法里，使用ListView来显示表单，记得要正确设置宽和高。

```text
 @override
  Widget build(BuildContext context) {
    return Container(
      width: ScreenUtil().setWidth(570) ,
      height: ScreenUtil().setHeight(1000),
      child: ListView.builder(
        itemCount: list.length,
        itemBuilder: (context,index){
          return _ListWidget(index);
        },
      )
    );
  }
```

构建好后，就可以进行测试了。然后再根据你想要的效果进行微调。需要注意的是，你完全可以根据你自己的喜好做出更漂亮的页面。

## [#](https://jspang.com/posts/2019/03/01/flutter-shop.html#第31节：列表页-商品列表交互效果制作)第31节：列表页_商品列表交互效果制作

现在页面布局已经基本完成，接下来就要作商品分类页的各种交互效果了，当我们熟练掌握了Provide的状态管理后，这些交互页变的相当容易。但为了实现交互效果，还是需要把页面代码进行重新规划一下的，让页面符合状态管理的规范的。

### 制作商品列表的Provide

制作Provide是有一个小技巧的，就是页面什么元素需要改变，你就制作什么的`provide`类，比如现在我们要点击大类，改变商品列表，实质改变的就是`List`的值，那只制作商品列表List的`Provide`就可以了。

在`lib/proive/`文件夹下，新建一个`category_goods_list.dart`文件。

```text
import 'package:flutter/material.dart';
import '../model/categoryGoodsList.dart';


class CategoryGoodsListProvide with ChangeNotifier{

    List<CategoryListData> goodsList = [];
  
    //点击大类时更换商品列表
    getGoodsList(List<CategoryListData> list){
           
      goodsList=list;   
      notifyListeners();
    }
}
```

先引入了model中的`categoryGoodsList.dart`文件，管理的状态就是`goodsList`变量，我们通关过一个方法`getGoodsList`来改变状态。这样一个`Provide`类就制作完成了。

### [#](https://jspang.com/posts/2019/03/01/flutter-shop.html#将状态放入顶层)将状态放入顶层

当`Provide`编程完成以后，需要把写好的状态管理放到`main.dart`中，我司叫它为放入顶层，就是全部页面想用这个状态都可以获得。代码如下:

```text
void main(){
  var childCategory= ChildCategory();
  var categoryGoodsListProvide= CategoryGoodsListProvide();

  var counter =Counter();
  var providers  =Providers();
  providers
    ..provide(Provider<ChildCategory>.value(childCategory))
    ..provide(Provider<CategoryGoodsListProvide>.value(categoryGoodsListProvide))
    ..provide(Provider<Counter>.value(counter));

  runApp(ProviderNode(child:MyApp(),providers:providers));
}
```

先声明一个`categoryGoodsListProvide`变量，然后放入顶层就可以了。

### [#](https://jspang.com/posts/2019/03/01/flutter-shop.html#修改category-page-dart页面)修改category_page.dart页面

这个页面需要伤筋动骨，进行彻底修改结构，步骤较多，请按步骤一步步完成。

**1.引入provide文件**

在`lib/pages/category_page.dart`文件最上面引入刚写的`provide`.

```text
import '../provide/category_goods_list.dart';
```

**2.修改_getGoodsList方法**

上节课为了布局，把得到商品列表数据的方法，放到了商品列表类里。现在需要把这个方法放到我们的CategoryPage类里，作为一个内部方法，因为我们要在点击大类时，调用后台接口和更新状态。

```text
 //得到商品列表数据
   void _getGoodList({String categoryId})async {
     
    var data={
      'categoryId':categoryId==null?'4':categoryId,
      'categorySubId:'',
      'page':1
    };
    
    await request('getMallGoods',formData:data ).then((val){
        var  data = json.decode(val.toString());
        CategoryGoodsListModel goodsList=  CategoryGoodsListModel.fromJson(data);
        Provide.value<CategoryGoodsListProvide>(context).getGoodsList(goodsList.data);
       
    });
  }
```

首先方法要增加一个可选参数，就是大类ID，如果没有大类ID，我们默认为4，有了参数后到后台获得数据，获得后使用`Provide`改变状态。

**3.使用_getGoodList方法**

修改完这个方法后，可以在每次点击大类的时候进行调用。代码如下：

```text
  onTap: () {

      setState(() {
        listIndex=index;
      });
      var childList = list[index].bxMallSubDto;
      var categoryId= list[index].mallCategoryId;
    
      Provide.value<ChildCategory>(context).getChildCategory(childList);
      _getGoodList(categoryId:categoryId );
  },
```

这段代码，先声明了一个类别ID`categoryId`,然后调用了`_getGoodList()`方法，调用方法时要传递categoryId参数。

4.修改商品列表代码

这个部分的代码修改要多一点，要把原来的setState模式，换成provide模式，所以很多地方都有所不同，但是我们的布局代码时不需要改的。

先去掉list ，然后用`Provide widget`来监听变化，修改类里的子方法，多接收一个List参数，命名为`newList`，每个子方法都要加入，这里提醒不要使用state，否则会报错。

修改后的代码如下：

```text
class CategoryGoodsList extends StatefulWidget {
  @override
  _CategoryGoodsListState createState() => _CategoryGoodsListState();
}

class _CategoryGoodsListState extends State<CategoryGoodsList> {

  

  @override
  Widget build(BuildContext context) {

     
   
    return Provide<CategoryGoodsListProvide>(
        builder: (context,child,data){
          return Container(
            width: ScreenUtil().setWidth(570) ,
            height: ScreenUtil().setHeight(1000),
            child:ListView.builder(
                itemCount: data.goodsList.length,
                itemBuilder: (context,index){
                  return _ListWidget(data.goodsList,index);
                },
              ) ,
          );

       },
      
      
      
    );
  }

 

  Widget _ListWidget(List newList,int index){

  

    return InkWell(
      onTap: (){},
      child: Container(
        padding: EdgeInsets.only(top: 5.0,bottom: 5.0),
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border(
            bottom: BorderSide(width: 1.0,color: Colors.black12)
          )
        ),
        
        child: Row(
          children: <Widget>[
            _goodsImage(newList,index)
           ,
            Column(
              children: <Widget>[
                _goodsName(newList,index),
                _goodsPrice(newList,index)
              ],
            )
          ],
        ),
      )
    );

  }

  Widget _goodsImage(List newList,int index){

    return  Container(
      width: ScreenUtil().setWidth(200),
      child: Image.network(newList[index].image),
    );

  }

  Widget _goodsName(List newList,int index){
    return Container( 
      padding: EdgeInsets.all(5.0),
      width: ScreenUtil().setWidth(370),
      child: Text(
        newList[index].goodsName,
        maxLines: 2,
        overflow: TextOverflow.ellipsis,
        style: TextStyle(fontSize: ScreenUtil().setSp(28)),
        ),
      );
  }

  Widget _goodsPrice(List newList,int index){
    return  Container( 
      margin: EdgeInsets.only(top:20.0),
      width: ScreenUtil().setWidth(370),
      child:Row(
        children: <Widget>[
            Text(
              '价格:￥${newList[index].presentPrice}',
              style: TextStyle(color:Colors.pink,fontSize:ScreenUtil().setSp(30)),
              ),
            Text(
              '￥${newList[index].oriPrice}',
              style: TextStyle(
                color: Colors.black26,
                decoration: TextDecoration.lineThrough
              ),
            )
        ]
      )
    );
  }


}
```

总结：这节课算是Provide的高级应用了，如果这个状态管理小伙伴都很熟练了，至少Flutter的状态管理这个知识点是没有问题了。我们下节课要晚上子类和商品列表的互动，当然也是使用状态管理了。

## [#](https://jspang.com/posts/2019/03/01/flutter-shop.html#第32节：列表页-小类高亮交互效果制作)第32节：列表页_小类高亮交互效果制作

这节课主要学习小类高亮交互效果的实现，通过几节课的练习，应该对状态管理有了比较深刻的理解。我建议小伙伴们可以先不看视频自己作一下，检验一下自己的学习能力。

### Expanded Widget的使用

Expanded Widget 是让子Widget有伸缩能力的小部件，它继承自`Flexible`,用法也差不多。那为什么要单独拿出来讲一下Expanded Widget那？我们在首页布局和列表页布局时都遇到了高度适配的问题，很多小伙伴出现了高度溢出的BUG，所以这节课开始前先解决一下这个问题。

修改 `Category_page.dart`里的商品列表页面，不再约束高了，而是使用`Expanded Widget`包裹外层，修改后的代码如下:

```
class _CategoryGoodsListState extends State<CategoryGoodsList> {

  @override
  Widget build(BuildContext context) {
    return Provide<CategoryGoodsListProvide>(
      builder: (context,child,data){
        return Expanded(
            child: Container(
            width: ScreenUtil().setWidth(570),
            child: ListView.builder(
              itemCount: data.goodsList.length,
              itemBuilder: (context,index){
                return _listWidget(data.goodsList, index);
              },
            ),
          ),
        );
 
      },
    );
    
  }
  //... ...
}
```



### 小类高亮效果制作

由于高亮效果也受到大类的控制，不仅仅是子类别的控制，所以这个效果也要用到状态管理来制作。这个状态很简单，没必要单独写一个`Provide`，所以直接使用以前的类就可以，我们直接在`provide/child_category.dart`里修改。修改的代码为：

```diff
import 'package:flutter/material.dart';
import '../model/category.dart';

//ChangeNotifier 的混入是不用管理听众
class ChildCategory with ChangeNotifier {
  List<BxMallSubDto> childCategoryList = [];
+  int childIndex = 0;

+  //点击大类时更换
  getChildCategory(List<BxMallSubDto> list) {
+
+    childIndex = 0;
    BxMallSubDto all = BxMallSubDto();
    all.mallSubId = '00';
    all.mallCategoryId = '00';
    all.comments = 'null';
    all.mallSubName = '全部';

    childCategoryList = [all]; //把all加到开头
    childCategoryList.addAll(list);

    childCategoryList = list;
    notifyListeners();
  }
+  //改变子类索引
+  changeChildIndex(index) {
+   childIndex = index;
+   notifyListeners();
+ }
}
```

然后就可以修改UI部分了，UI部分主要是增加索引参数，然后进行判断。

1. 先把`_rghtInkWell`方法增加一个接收参数`int index`.这就是修改变量的索引值。

```text
Widget _rightInkWell(int index,BxMallSubDto item)
```

1. 定义是否高亮变量，再根据状态进行赋值

```text
   bool isCheck = false;
   isCheck =(index==Provide.value<ChildCategory>(context).childIndex)?true:false;
```

3.点击时修改状态

```text
onTap: (){
    Provide.value<ChildCategory>(context).changeChildIndex(index);
},
```

4.用`isCheck`判断是否高亮

```text
color:isCheck?Colors.pink:Colors.black ),
```

到这里，我们的子类高亮就制作完成了，并且当更换大类时，子类自动更改为第一个高亮。

修改的全部代码如下：

```diff
class _RightCategoryNavState extends State<RightCategoryNav> {
  @override
  Widget build(BuildContext context) {

    //List list = ['名酒','宝丰', '北京二锅头', '舍得','五粮液','茅台','散白'];
    return Provide<ChildCategory>(
      builder: (context,child, childCategory){
        return Container(
          child: Container(
            height: ScreenUtil().setHeight(80),
            width: ScreenUtil().setWidth(570),
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border(
                bottom: BorderSide(width: 1, color: Colors.black12)
              )
            ),
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: childCategory.childCategoryList.length,
              itemBuilder: (context,index) {
-                return _rightInkWell(childCategory.childCategoryList[index]);
+                return _rightInkWell(index,childCategory.childCategoryList[index]);
               },

            ),
          ),
        );
      },
    );
    
    
    
  }

 
-  Widget _rightInkWell(BxMallSubDto item) {
+  Widget _rightInkWell(int index, BxMallSubDto item) {
     
+    bool isClick = false;
+    isClick = (index == Provide.value<ChildCategory>(context).childIndex) ? true : false;
 
     return InkWell(
-      onTap: (){ },
+      onTap: (){ 
+        Provide.value<ChildCategory>(context).changeChildIndex(index);
+      },
       child: Container(
         padding: EdgeInsets.fromLTRB(5.0, 10.0, 5.0, 10.0),
         child: Text(
           item.mallSubName,
-          style: TextStyle(fontSize: ScreenUtil().setSp(28)),
+          style: TextStyle(
+            fontSize: ScreenUtil().setSp(28), 
+            color: isClick ? Colors.pink : Colors.black12
+            ),
         ),
       ),
     );
	}
	//... ...
}
```



到这里，我们的子类高亮就制作完成了，并且当更换大类时，子类自动更改为第一个高亮。

## [#](https://jspang.com/posts/2019/03/01/flutter-shop.html#第33节-列表页-子类和商品列表切换)第33节:列表页_子类和商品列表切换

其实点击大类切换商品列表效果如果你会了，那点击小类切换商品列表效果几乎是一样。只有很小的改动。

### 修改Provide类

先改动一下`child_ategory.dart`的Provide类，增加一个大类ID，然后在更改大类的时候改变ID。

```diff
import 'package:flutter/material.dart';
import '../model/category.dart';


//ChangeNotifier的混入是不用管理听众
class ChildCategory with ChangeNotifier{

    List<BxMallSubDto> childCategoryList = [];
    int childIndex = 0;
    String categoryId = '4';
  


    //点击大类时更换
-  getChildCategory(List<BxMallSubDto> list) {
-
+  getChildCategory(List<BxMallSubDto> list, String id) {
+    categoryId = id;

      childIndex=0;
      BxMallSubDto all=  BxMallSubDto();
      all.mallSubId='00';
      all.mallCategoryId='00';
      all.mallSubName = '全部';
      all.comments = 'null';
      childCategoryList=[all];
      childCategoryList.addAll(list);   
      notifyListeners();
    }
    //改变子类索引
    changeChildIndex(index){
       childIndex=index;
       notifyListeners();
    }
}
```

### [#](https://jspang.com/posts/2019/03/01/flutter-shop.html#修改调用getchildcategory放)修改调用getChildCategory放

增加了参数，以前的调用方法也就都不对了，所以需要修改一下。直接用搜索功能就可以找到`getChildCategory`方法，一共两处，直接修改就可以了

```diff
   Widget _leftInkWell(int index) {
     bool isClick = false;
     isClick = (index == listIndex)? true : false;
     return InkWell(
       onTap: (){
         setState(() {
           listIndex = index;
         });
         var childList = list[index].bxMallSubDto;
         var categoryId = list[index].mallCategoryId;
-        Provide.value<ChildCategory>(context).getChildCategory(childList);
+        Provide.value<ChildCategory>(context).getChildCategory(childList,categoryId);
         _getGoodsList(categoryId: categoryId);
       },
//... ...


   void _getCategory()async{
     await request('getCategory').then((val){
       var data = json.decode(val.toString());
       CategoryModel category = CategoryModel.fromJson(data);
       setState((){
         list = category.data;
       });
-      Provide.value<ChildCategory>(context).getChildCategory(list[0].bxMallSubDto);
+      Provide.value<ChildCategory>(context).getChildCategory(list[0].bxMallSubDto, list[0].mallCategoryId);
     });
   }
//...
```

### [#](https://jspang.com/posts/2019/03/01/flutter-shop.html#增加getgoodslist方法)增加getGoodsList方法

拷贝`_getGoodsList`方法到子列表类里边，然后把传递参数换成子类的参数`categorySubId`.代码如下：

```diff
 class _RightCategoryNavState extends State<RightCategoryNav> {
 //... ...
+  void _getGoodsList(String categorySubId) async {
+    var data = {
+      'categoryId': Provide.value<ChildCategory>(context).categoryId,
+      'CategorySubId':categorySubId,
+      'page':1
+    };
+    await request('getMallGoods',formData: data).then((val){
+      var data = json.decode(val.toString());
+      CategoryGoodsListModel goodsList = CategoryGoodsListModel.fromJson(data);
+      Provide.value<CategoryGoodsListProvide>(context).getGoodsList(goodsList.data);
+    });
+  }
// ... ...
}

```

### [#](https://jspang.com/posts/2019/03/01/flutter-shop.html#调用方法改版列表)调用方法改版列表

当点击子类时，调用这个方法，并传入子类ID。

```diff
  Widget _rightInkWell(int index, BxMallSubDto item) {
    
    bool isClick = false;
    isClick = (index == Provide.value<ChildCategory>(context).childIndex) ? true : false;

    return InkWell(
      onTap: (){ 
        Provide.value<ChildCategory>(context).changeChildIndex(index);
+        _getGoodsList(item.mallSubId);
      },
      child: Container(
        padding: EdgeInsets.fromLTRB(5.0, 10.0, 5.0, 10.0),
        child: Text(
          item.mallSubName,
          style: TextStyle(
            fontSize: ScreenUtil().setSp(28), 
            color: isClick ? Colors.pink : Colors.black12
            ),
        ),
      ),
    );
  }

```

## [#](https://jspang.com/posts/2019/03/01/flutter-shop.html#第34节：列表页-小bug的修复)第34节：列表页_小Bug的修复

在列表页还是有小Bug的，这节课我们就利用几分钟，进行修复一下.



### 子类没有商品时报错

有些小类别里是没有商品的，这时候就会报错。解决这个错误非常简单，只要进行判断就可以了。

**1.判断状态管理时是否存在数据**

首先你要在修改状态的时候，就进行一次判断，方式类型不对，导致整个app崩溃。也就是在点击小类的ontap方法后，当然这里调用了`_getGoodList()`方法。代码如下：

```diff
class _RightCategoryNavState extends State<RightCategoryNav> {  
	///...
  	//得到商品列表数据
   void _getGoodList(String categorySubId) {
     
    var data={
      'categoryId':Provide.value<ChildCategory>(context).categoryId,
      'categorySubId':categorySubId,
      'page':1
    };
    
    request('getMallGoods',formData:data ).then((val){
        var  data = json.decode(val.toString());
+        
        CategoryGoodsListModel goodsList=  CategoryGoodsListModel.fromJson(data);        
-      Provide.value<CategoryGoodsListProvide>(context).getGoodsList(goodsList.data);
+      if (goodsList.data == null) {
+        Provide.value<CategoryGoodsListProvide>(context).getGoodsList([]);
+      } else {
+        Provide.value<CategoryGoodsListProvide>(context).getGoodsList(goodsList.data);
+      }
+      
    });
  }
  ///...
}
```

**2.判断界面输出时是不是有数据**

这个主要时给用户一个友好的界面提示，如果没有数据，要提示用户。修改的是商品列表类的`build`方法，代码如下：

```diff
class _CategoryGoodsListState extends State<CategoryGoodsList> {
	   @override
   Widget build(BuildContext context) {
     return Provide<CategoryGoodsListProvide>(
       builder: (context,child,data){
-        return  Expanded(
-            child: Container(
-            width: ScreenUtil().setWidth(570),
-            height: ScreenUtil().setHeight(1000),
-            child: ListView.builder(
-              itemCount: data.goodsList.length,
-              itemBuilder: (context,index){
-                return _listWidget(data.goodsList, index);
-              },
+        if (data.goodsList.length > 0) {
+          return  Expanded(
+              child: Container(
+              width: ScreenUtil().setWidth(570),
+              height: ScreenUtil().setHeight(1000),
+              child: ListView.builder(
+                itemCount: data.goodsList.length,
+                itemBuilder: (context,index){
+                  return _listWidget(data.goodsList, index);
+                },
+              ),
             ),
-          ),
-        );
+          );
+        } else {
+          return Text('暂时没有数据');
+        }
+        
         
         
       },
     );

}
```

### [#](https://jspang.com/posts/2019/03/01/flutter-shop.html#把子类id也provide化)把子类ID也Provide化

现在的子类ID，我们还没有形成状态，用的是普通的setState，如果要做下拉刷新，那setState肯定是不行的，因为这样就进行跨类了，没办法传递过去。

1.首先修改`provide/child_category.dart`类，增加一个状态变量`subId`,然后在两个方法里都进行修改,代码如下：

```diff
 import 'package:flutter/material.dart';
 import '../model/category.dart';
 
 //ChangeNotifier 的混入是不用管理听众
 class ChildCategory with ChangeNotifier {
   List<BxMallSubDto> childCategoryList = [];
   int childIndex = 0; //子类高亮索引
   String categoryId = '4'; //大类ID
+  String subId = ''; //小类ID
 
   //点击大类时更换
   getChildCategory(List<BxMallSubDto> list, String id) {
     categoryId = id;
     childIndex = 0;
+    subId = ''; //点击大类时，把子类ID清空
+
     BxMallSubDto all = BxMallSubDto();
     all.mallSubId = '00';
     all.mallCategoryId = '00';
     all.comments = 'null';
     all.mallSubName = '全部';
 
     childCategoryList = [all]; //把all加到开头
     childCategoryList.addAll(list);
 
     childCategoryList = list;
     notifyListeners();
   }
 
   //改变子类索引
-  changeChildIndex(index) {
+  changeChildIndex(int index,String id) {
+    //传递两个参数，使用新传递的参数给状态赋值
     childIndex = index;
+    subId = id;
     notifyListeners();
   }
 }

```

这就为以后我们作上拉加载效果打下了基础。这节学完，你应该对Proive的有了深刻的理解，并且达到工作水平。

## [#](https://jspang.com/posts/2019/03/01/flutter-shop.html#第35节-列表页-上拉加载功能的制作)第35节:列表页_上拉加载功能的制作

这节主要制作一下列表页的上拉加载更多功能，因为在首页的视频中，已经讲解了上拉加载更多的效果，所以我们不会再着重讲解语法，而重点会放在上拉加载和Provide结合的方法。小伙伴们学习的侧重点也应该是状态管理的应用。

### 增加page和noMoreText到Provide里

因为无论切换大类或者小类的时候，都需要把page变成1，所以需要在`provide/child_category.dart`里新声明一个page变量.`noMoreText`主要用来控制是否显示更多和如果没有数据了，不再向后台请求数据。每一次后台数据的请求都是宝贵的。

```text
int page=1;  //列表页数，当改变大类或者小类时进行改变
String noMoreText=''; //显示更多的标识
```

声明在切换大类和切换小类的时候都把page变成1，代码如下：

```text
//点击大类时更换
    getChildCategory(List<BxMallSubDto> list,String id){
      isNewCategory=true;
      categoryId=id;
      childIndex=0;
      //------------------关键代码start
      page=1;
      noMoreText = ''; 
      //------------------关键代码end
      subId=''; //点击大类时，把子类ID清空
      noMoreText='';
      BxMallSubDto all=  BxMallSubDto();
      all.mallSubId='00';
      all.mallCategoryId='00';
      all.mallSubName = '全部';
      all.comments = 'null';
      childCategoryList=[all];
      childCategoryList.addAll(list);   
      notifyListeners();
    }
    //改变子类索引 ,
    changeChildIndex(int index,String id){
      isNewCategory=true;
      //传递两个参数，使用新传递的参数给状态赋值
       childIndex=index;
       subId=id;
       //------------------关键代码start
       page=1;
       noMoreText = ''; //显示更多的表示
       //------------------关键代码end
       noMoreText='';
       notifyListeners();
    }
```

还需要写一个增加page数量的方法，用来实现每次上拉加载后，page随之加一，代码如下:

```text
    //增加Page的方法f
    addPage(){
      page++;
    }
```

在制作一个改变`noMoreText`方法。

```text
    //改变noMoreText数据  
    changeNoMore(String text){
      noMoreText=text;
      notifyListeners();
    }
```

最终的`child_category.dart`的文件变化情况为：

```diff
import 'package:flutter/material.dart';
import '../model/category.dart';

//ChangeNotifier 的混入是不用管理听众
class ChildCategory with ChangeNotifier {
  List<BxMallSubDto> childCategoryList = [];
  int childIndex = 0; //子类高亮索引
  String categoryId = '4'; //大类ID
  String subId = ''; //小类ID
+  int page = 1;//列表页数，当改变大类或者小类时进行改变
+  String noMoreText = '';//显示更多的标识

  //点击大类时更换
  getChildCategory(List<BxMallSubDto> list, String id) {
    categoryId = id;
    childIndex = 0;
    subId = ''; //点击大类时，把子类ID清空

+    //-------------关键代码start
+    page = 1;
+    noMoreText = '';
+    //-------------关键代码end

    BxMallSubDto all = BxMallSubDto();
    all.mallSubId = '00';
    all.mallCategoryId = '00';
    all.comments = 'null';
    all.mallSubName = '全部';

    print('list_length:${list.length}');
    childCategoryList = [all]; //把all加到开头
    childCategoryList.addAll(list);
    print('childCategoryList_length:${childCategoryList.length}');

    // childCategoryList = list;
    notifyListeners();
  }

  //改变子类索引
  changeChildIndex(int index,String id) {
    //传递两个参数，使用新传递的参数给状态赋值
    childIndex = index;
    subId = id;
+    //-------------关键代码start
+    page = 1;
+    noMoreText = ''; //显示更多的表示
+    //-------------关键代码end
    notifyListeners();
  }
+
+  //增加Page的 方法
+  addPage(){
+    page++;
+    //print('page=${page}');
+  }
+
+  changeNoMore(String text) {
+    noMoreText = text;
+    notifyListeners();
+  }
}
```



### [#](https://jspang.com/posts/2019/03/01/flutter-shop.html#增加easyrefresh组件)增加EasyRefresh组件

在`category_page.dart`里增加EasyRefresh组件，首先需要使用import进行引入。

```text
import 'package:flutter_easyrefresh/easy_refresh.dart';
```

引入之后，可以直接使用`EasyRefresh`进行包裹，然后加上各种需要的参数，这个部分已经在前几节课讲过了，这里就不作过多的讲解了。

```diff
@override
  Widget build(BuildContext context) {
    return Provide<CategoryGoodsListProvide>(
        builder: (context,child,data){
          
          
          if(data.goodsList.length>0){
             return Expanded(
                child:Container(
                  width: ScreenUtil().setWidth(570) ,
+                  child:EasyRefresh(
+                    refreshFooter: ClassicsFooter(
+                      key:_footerKey,
+                      bgColor:Colors.white,
+                      textColor:Colors.pink,
+                      moreInfoColor: Colors.pink,
+                      showMore:true,
+                      noMoreText:Provide.value<ChildCategory>(context).noMoreText,
+                      moreInfo:'加载中',
+                      loadReadyText:'上拉加载'
+                    ),
                    child:ListView.builder(
                      itemCount: data.goodsList.length,
                      itemBuilder: (context,index){
                        return _ListWidget(data.goodsList,index);
                      },
                    ) ,
+                    loadMore: ()async{
+                        print('没有更多了.......');
+                    },
                  )
                  
                ) ,
              ); 
          }else{
            return  Text('暂时没有数据');
          }
       },

    );
  }
```

### [#](https://jspang.com/posts/2019/03/01/flutter-shop.html#修改请求数据的方法)修改请求数据的方法

这个类中也需要一个去后台请求数据的方法，这个方法要求从Provide里读出三个参数，大类ID，小类ID和页数。代码如下:

```diff
+  //上拉加载更多的方法
+  void _getMoreList(){
+     
+    Provide.value<ChildCategory>(context).addPage();
+     var data={
+      'categoryId':Provide.value<ChildCategory>(context).categoryId,
+      'categorySubId':Provide.value<ChildCategory>(context).subId,
+      'page':Provide.value<ChildCategory>(context).page
+    };
+    
+    request('getMallGoods',formData:data ).then((val){
+        var  data = json.decode(val.toString());
+        CategoryGoodsListModel goodsList=  CategoryGoodsListModel.fromJson(data);
+       
+        if(goodsList.data==null){
+         Provide.value<ChildCategory>(context).changeNoMore('没有更多了');
+        }else{
+           
+          Provide.value<CategoryGoodsListProvide>(context).addGoodsList(goodsList.data);
+          
+        }
+    });
+
+
+  }
```

每次都先调用增加页数的方法，这样请求的数据就是最新的，当没有数据的时候要把`noMoreText`设置成‘没有更多了’。

### [#](https://jspang.com/posts/2019/03/01/flutter-shop.html#切换类别返回顶部)切换类别返回顶部

到目前为止，我们应该可以正常展示上拉加载更多的方法了，但是还有一个小Bug，切换大类或者小类的时候，我们的页面没有回到顶部，这个其实很好解决。再build的Provide的构造器里加入下面的代码就可以了。

```text
try{
  if(Provide.value<ChildCategory>(context).page==1){
    scrollController.jumpTo(0.0);
  }
}catch(e){
  print('进入页面第一次初始化：${e}');
}
          
```

当然你还要再列表类里进行声明`scrollController`,如果你不声明是没办法使用的。

```text
var scrollController=new ScrollController();
```

声明完成后，给ListView加上`controller`属性。

```text
child:ListView.builder(
  controller: scrollController,
  itemCount: data.goodsList.length,
  itemBuilder: (context,index){
    return _ListWidget(data.goodsList,index);
  },
) ,
```

这时候再进行测试，应该就可以了。这节课就到这里，虽然还有些小Bug，但是总体效果已经制作完成了。

最终的`category_page.dart`文件的修改为：

```diff
class _CategoryGoodsListState extends State<CategoryGoodsList> {
  // List list = [];
  GlobalKey<RefreshIndicatorState> _footerkey = new GlobalKey<RefreshIndicatorState>();

+  var scrollController = new ScrollController();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Provide<CategoryGoodsListProvide>(
      builder: (context,child,data){

+        try {
+          if (Provide.value<ChildCategory>(context).page == 1) {
+            //列表位置，放到最上边
+            scrollController.jumpTo(0.0);
+          }
+        } catch (e) {
+          print('进入页面第一次初始化：${e}');
+        }

        if (data.goodsList.length > 0) {
          return  Expanded(
              child: Container(
              width: ScreenUtil().setWidth(570),
              child: EasyRefresh(
                footer: ClassicalFooter(
                  key: _footerkey,
                  bgColor: Colors.white,
                  textColor: Colors.pink,
                  infoColor: Colors.pink,
                  noMoreText: Provide.value<ChildCategory>(context).noMoreText,
                  infoText: '加载中',
                  loadReadyText: '上拉加载',
                ),
+                child: ListView.builder(
+                  controller: scrollController,
+                  itemCount: data.goodsList.length,
+                  itemBuilder: (context,index){
+                    return _listWidget(data.goodsList, index);
+                  },
+                ),
                
                onLoad: ()async{
                  /// 上拉加载的响应
                  print('上拉加载更多.....');
                  _getMoreList();
                },
              ),
              
               
            ),
          );
        } else {
          return Text('暂时没有数据');
        }
 
      },
    );
    
  }
}
```



## [#](https://jspang.com/posts/2019/03/01/flutter-shop.html#第36节：fluttertoast组件的介绍)第36节：Fluttertoast组件的介绍

在APP的使用过程中，对用户的友好提示是必不可少的，比如当列表页上拉加载更多的时候，到达了数据的底部，没有更多数据了，就要给用户一个友好的提示。但是这种提示又不能影响用户的使用，这节课就介绍一个轻提示组件给大家`FlutterToast`。



### Fluttertoast 组件简介

这是一个第三方组件，目前版本是3.0.1，当你学习的时候可以到Github上查找最新版本。讲课时此插件又200Star。

> GitHub地址：https://github.com/PonnamKarthik/FlutterToast

这个组件我觉的还时比较好用的，提供了样式自定义，而且自带的效果页是很酷炫的。所以我推荐了这个组件。

### [#](https://jspang.com/posts/2019/03/01/flutter-shop.html#如何使用fluttertoast)如何使用Fluttertoast

首先需要在`pubspec.yaml`中进行引入Fluttertoast组件（也叫保持依赖，也叫包管理），主要版本号，请使用最新的，这里不保证时最新版本。

```text
fluttertoast: ^3.1.3
```

引入后在需要使用的页面使用`import`引入,引入代码如下：

```text
import 'package:fluttertoast/fluttertoast.dart';
```

### [#](https://jspang.com/posts/2019/03/01/flutter-shop.html#fluttertoast使用方法)Fluttertoast使用方法

在需要使用的地方直接可以使用，如下代码：

```diff
//上拉加载更多的方法
  void _getMoreList() {
    Provide.value<ChildCategory>(context).addPage(); //增加Page的 方法
    
    var page =  Provide.value<ChildCategory>(context).page;  
    print('page=${page}'); //打印page
    var data = {
      'categoryId': Provide.value<ChildCategory>(context).categoryId,
      'categorySubId': Provide.value<ChildCategory>(context).subId,
      'page': page,
    };

    request('getMallGoods',formData: data).then((val){
      var data = json.decode(val.toString());

      CategoryGoodsListModel goodsList = CategoryGoodsListModel.fromJson(data);
      
      ///测试代码
      if (Provide.value<CategoryGoodsListProvide>(context).goodsList.length > 0) {
        goodsList.data = null;
      }
      //
      if (goodsList.data == null) {
+        Fluttertoast.showToast(
+          msg: "已经到底了",
+          toastLength: Toast.LENGTH_SHORT,
+          gravity: ToastGravity.CENTER,
+          backgroundColor: Colors.pink,
+          textColor: Colors.white,
+          fontSize: 16.0
+        );
        Provide.value<ChildCategory>(context).changeNoMore('没有更多了');
      } else {
        Provide.value<CategoryGoodsListProvide>(context).getMoreList(goodsList.data);
      }
    });
  }
```

- msg：提示的文字，String类型。
- toastLength: 提示的样式，主要是长度，有两个值可以选择：`Toast.LENGTH_SHORT`：短模式，就是比较短。`Toast.LENGTH_LONG`: 长模式，就是比较长。
- gravity：提示出现的位置，分别是上中下，三个选项。`ToastGravity.TOP`顶部提示，`ToastGravit.CENTER`中部提示，`ToastGravity.BOTTOM`底部提示。
- bgcolor: 背景颜色，跟从Flutter颜色。
- textcolor：文字的颜色。
- fontSize： 文字的大小。

### [#](https://jspang.com/posts/2019/03/01/flutter-shop.html#小bug的处理)小Bug的处理

在列表页还存在着一个小Bug，就是当我们选择子类别后，然后返回全部，这时候会显示没有数据，这个主要是我们在Provide里构造虚拟类别时，传递的参数不对，只要把参数修改成空就可以了。

打开`provide/child_category.dart`，修改`getChildCateg()`方法。 修改代码如下：

```diff
//点击大类时更换
getChildCategory(List<BxMallSubDto> list,String id){
  isNewCategory=true;
  categoryId=id;
  childIndex=0;
  page=1;
  subId=''; //点击大类时，把子类ID清空
  noMoreText='';
  BxMallSubDto all=  BxMallSubDto();
-    all.mallSubId = '00';
+    all.mallSubId = '';//不设置子类
  all.mallCategoryId='00';
  all.mallSubName = '全部';
  all.comments = 'null';
  childCategoryList=[all];
  childCategoryList.addAll(list);   
  notifyListeners();
}
```

这节课主要学习了FlutterToast组件的使用。这个组件虽然很简单，但是在开发中少不了。所以在这里给小伙伴进行了一个详细的讲解。

## 第37节：路由_fluro引入和商品详细页建立

Flutter本身提供了路由机制，作个人的小型项目，完全足够了。但是如果你要作企业级开发，可能就会把入口文件变得臃肿不堪。而再Flutter问世之初，就已经了企业级路由方案fluro。

### flutter_fluro简介

fluro简化了Flutter的路由开发，也是目前Flutter生态中最成熟的路由框架。

> GitHub地址：https://github.com/theyakka/fluro

它出现的比较早啊，是目前用户最多的Flutter路由解决方案，目前Github上有将近1000Star，可以说是相当了不起了。

### [#](https://jspang.com/posts/2019/03/01/flutter-shop.html#建立商品详情页面)建立商品详情页面

在学习Fluro之前，我们先建立一个商品详情页面，当然我们只是为了调通路由代码，所以尽量简化代码。在page文件夹下，建立一个`details_page. dart`文件，然后写入下面的代码：

```text
import 'package:flutter/material.dart';

class DetailsPage extends StatelessWidget {
  final String goodsId;
  DetailsPage(this.goodsId);

  @override
  Widget build(BuildContext context) {
    return Container(
      child:Text('商品ID为：${goodsId}')
      
    );
  }
}
```

这里使用了静态组件，测试也没必要使用动态组件，然后组件接收一个goodsId参数，接收参数我们使用了构造方法，因为新版的Flutter已经不在要求key值，所以没必要再写了。

### [#](https://jspang.com/posts/2019/03/01/flutter-shop.html#引入fluro)引入fluro

在`pubspec.yaml`文件里，直接注册版本依赖，代码如下。

```text
dependencies:
 fluro: "^1.5.1"
```

如果你这个版本下载不下来，你也可以使用git的方式注册依赖，这样页是可以下载包的(这也是小伙伴提的一个问题)，代码如下：

```text
dependencies:
 fluro:
   git: git://github.com/theyakka/fluro.git
```

在项目的入口文件，也就是`main.dart`中引入，代码如下：

```text
import 'package:fluro/fluro.dart';
```

通过上面的三步，就算把Fluro引入到项目中了，下面就可以开心的使用了。这就好比，衣服脱了，剩下就看你怎么玩了。

总结：我们把路由`flutter_fluro`分4节课来讲，这样调理更清晰，虽然每节课程的代码不多，但是很好理解。

## [#](https://jspang.com/posts/2019/03/01/flutter-shop.html#第38节：路由-fluro中handler文件编写)第38节：路由_fluro中Handler文件编写

handler就是每个路由的规则，编写handler就是配置路由规则，比如我们要传递参数，参数的值是什么，这些都需要在Handler中完成。



### 初始化Fluro

现在可以进行使用了，使用时需要先在Build方法里进行初始化,其实就是把对象new出来。

```diff
import 'package:flutter/material.dart';
import './pages/index_page.dart';

import 'package:provide/provide.dart';
import './provide/counter.dart';
import './provide/child_category.dart';
import './provide/category_goods_list.dart';
+import 'package:fluro/fluro.dart';

void main() {
  var counter = Counter();
  var childCategory = ChildCategory();
  var categorygoodsListProvide = CategoryGoodsListProvide();

  var providers = Providers();
+  final router = Router();
  //... ...
}
```

### [#](https://jspang.com/posts/2019/03/01/flutter-shop.html#编写rotuer-handler)编写rotuer_handler

handler相当于一个路由的规则，比如我们要到详细页面，这时候就需要传递商品的ID，那就要写一个handler。这次我按照大型企业级真实项目开发来部署项目目录和文件，把路由全部分开，Handler单独写成一个文件。 新建一个`routers`文件夹，然后新建`router_handler.dart`文件

```text
import 'package:flutter/material.dart';
import 'package:fluro/fluro.dart';
import '../pages/details_page.dart';


Handler detailsHanderl =Handler(
  handlerFunc: (BuildContext context,Map<String,List<String>> params){
    String goodsId = params['id'].first;
    print('index>details goodsID is ${goodsId}');
    return DetailsPage(goodsId);

  }
);
```

这样一个Handler就写完了。Hanlder的编写是路由中最重要的一个环境，知识点也是比较多的，这里我们学的只是最简单的一个Handler编写，以后会随着课程的增加，我们会再继续深入讲解Handler的编写方法。

## [#](https://jspang.com/posts/2019/03/01/flutter-shop.html#第39节：路由-fluro的路由配置和静态化)第39节：路由_fluro的路由配置和静态化

Hanlder只是对每个路由的独立配置文件，fluro当然还需要一个总体配置文件。这节课就来学习一下fluro总体配置文件的编写。这样配置好后，我们还需要一个静态化文件，方便我们在UI页面进行使用。



### 配置路由

我们还需要对路由有一个总体的配置，比如跟目录，出现不存在的路径如何显示，工作中我们经常把这个文件单独写一个文件。在`routes.dart`里，新建一个`routes.dart`文件。

代码如下:

```text
import 'package:flutter/material.dart';
import './router_handler.dart';
import 'package:fluro/fluro.dart';

class Routes{
  static String root='/';
  static String detailsPage = '/detail';
  static void configureRoutes(Router router){
    router.notFoundHandler= new Handler(
      handlerFunc: (BuildContext context,Map<String,List<String>> params){
        print('ERROR====>ROUTE WAS NOT FONUND!!!');
      }
    );

    router.define(detailsPage,handler:detailsHandler);
  }

}
```

这段代码在视频中有详细的解释，这里就作过多的文字介绍了。

### [#](https://jspang.com/posts/2019/03/01/flutter-shop.html#把fluro的router静态化)把Fluro的Router静态化

这一步就是为了使用方便，直接把Router进行静态化，这样在任何一个页面都可以直接进行使用了。`routers`文件目录下新建一个`application.dart`，代码如下：

```text
import 'package:fluro/fluro.dart';

class Application{
  static Router router;
}
```

总结：这节课完成后，我们基本就把Fluro的路由配置好了，这样的配置虽然稍显复杂，但是跟层次和条理化，扩展性也很强。所以小伙伴们也要练习一下。

## [#](https://jspang.com/posts/2019/03/01/flutter-shop.html#第40节：路由-fluro的全局注入和使用)第40节：路由_fluro的全局注入和使用

通过3节课的学习，已经把路由配置好了，但是如果想正常使用，还需要在`main.dart`文件里进行全局注入。注入后就可以爽快的使用了，配置好后的使用方法也是非常简单的。 

###  把路由注册到顶层

打开`main.dart`文件，首页引入`routes.dart`和`application.dart`文件，代码如下：

```text
import './routers/routes.dart';
import './routers/application.dart';
```

引入后需要进行赋值，进行注入程序。这里展示主要build代码。

```diff
 import 'package:flutter/material.dart';
 import './pages/index_page.dart';
 
 import 'package:provide/provide.dart';
 import './provide/counter.dart';
 import './provide/child_category.dart';
 import './provide/category_goods_list.dart';
 import 'package:fluro/fluro.dart';
+import './routers/routers.dart';
+import './routers/application.dart';
 
 void main() {
   var counter = Counter();
   var childCategory = ChildCategory();
   var categorygoodsListProvide = CategoryGoodsListProvide();
 
   var providers = Providers();
-  final router = Router();
 
   providers
   ..provide(Provider<Counter>.value(counter))
   ..provide(Provider<CategoryGoodsListProvide>.value(categorygoodsListProvide))
   ..provide(Provider<ChildCategory>.value(childCategory));//进行依赖
 
   runApp(ProviderNode(child: MyApp(), providers: providers));
 }
 
 class MyApp extends StatelessWidget {
   @override
   Widget build(BuildContext context) {
+    
+    final router = Router();
+    Routes.configureRoutes(router);
+    Application.router = router;
+
     return Container(
       child: MaterialApp(
         title: '百姓生活+',
+        onGenerateRoute: Application.router.generator,
         debugShowCheckedModeBanner: false,
         theme: ThemeData(
           primarySwatch: Colors.pink,
         ),
         home: IndexPage(),
       ),
     );
   }
 }
//... ...
```

上面代码就是注入整个程序，让我们在任何页面直接引入`application.dart`就可以使用。

### [#](https://jspang.com/posts/2019/03/01/flutter-shop.html#在首页使用) 在首页使用

前戏终于完成，现在就可以痛痛快快大干一场了。现在要在首页里使用路由，直接在首页打开商品详细页面。

在`home_page.dart`先引入`application.dart`文件：

```text
import './routers/application.dart';
```

然后再火爆专区的列表中使用配置好的路由，打开商品详细页面`details_page.dart`。

打开`home_page.dart`文件，找到火爆专区列表`_wrapList()`里的`ontap`事件，然后在`ontap`事件中直接使用`application`进行跳转，代码如下：

```diff
//... ...   
   //火爆专区子项
   Widget _wrapList(){
     if (hotGoodsList.length != 0) {
       List<Widget> listWidget = hotGoodsList.map((val){
         return InkWell(
           onTap: (){
             ///点击了火爆商品
             print('点击了火爆商品');
-            Application.router.navigateTo(context,"/detail?id=${val['goodsId']}");
+            Application.router.navigateTo(context, "/detail?id=${val['goodsId']}");
             
           },
//... ...
```

这时候可以测试一下，如果一切正常，应该可以打开商品详细页面了，当然这时候的商品详细页面实在是太丑了。

## [#](https://jspang.com/posts/2019/03/01/flutter-shop.html#第41节：详细页-后台数据接口调试) 第41节：详细页_后台数据接口调试

开始作商品详细页，这节课主要是调通商品信息页的后端接口和制作数据模型。我们完全安装真实项目的开发目录接口和文件组织来进行开发。

###  建立商品详细模型

我们还是用快速生成的方式建立一下商品详细页的接口模型，有这样一段从后端获取的JSON，直接用快速生成的方式，把这段JSON生成模型，然后进行必要的修改。

JSON如下:

```text
{"code":"0","message":"success","data":{"goodInfo":{"image5":"","amount":10000,"image3":"","image4":"","goodsId":"ed675dda49e0445fa769f3d8020ab5e9","isOnline":"yes","image1":"http://images.baixingliangfan.cn/shopGoodsImg/20190116/20190116162618_2924.jpg","image2":"","goodsSerialNumber":"6928804011173","oriPrice":3.00,"presentPrice":2.70,"comPic":"http://images.baixingliangfan.cn/compressedPic/20190116162618_2924.jpg","state":1,"shopId":"402880e860166f3c0160167897d60002","goodsName":"可口可乐500ml/瓶","goodsDetail":"<img src=\"http://images.baixingliangfan.cn/shopGoodsDetailImg/20171224/20171224081109_5060.jpg\" width=\"100%\" height=\"auto\" alt=\"\" /><img src=\"http://images.baixingliangfan.cn/shopGoodsDetailImg/20171224/20171224081109_1063.jpg\" width=\"100%\" height=\"auto\" alt=\"\" /><img src=\"http://images.baixingliangfan.cn/shopGoodsDetailImg/20171224/20171224081110_8029.jpg\" width=\"100%\" height=\"auto\" alt=\"\" /><img src=\"http://images.baixingliangfan.cn/shopGoodsDetailImg/20171224/20171224081110_1074.jpg\" width=\"100%\" height=\"auto\" alt=\"\" /><img src=\"http://images.baixingliangfan.cn/shopGoodsDetailImg/20171224/20171224081110_8439.jpg\" width=\"100%\" height=\"auto\" alt=\"\" /><img src=\"http://images.baixingliangfan.cn/shopGoodsDetailImg/20171224/20171224081110_6800.jpg\" width=\"100%\" height=\"auto\" alt=\"\" />"},"goodComments":[{"SCORE":5,"comments":"果断卸载，2.5个小时才送到","userName":"157******27","discussTime":1539491266336}],"advertesPicture":{"PICTURE_ADDRESS":"http://images.baixingliangfan.cn/advertesPicture/20190113/20190113134955_5825.jpg","TO_PLACE":"1"}}}
```

复制上面的的代码，代开下面的地址，利用JSON代码，快速生成MOdel模型。

> https://javiercbk.github.io/json_to_dart/

在`lib/model`文件夹下新建立`details.dart`文件，然后把生成的代码拷贝到下面。

```text
class DetailsModel {
  String code;
  String message;
  DetailsGoodsData data;

  DetailsModel({this.code, this.message, this.data});

  DetailsModel.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    message = json['message'];
    data = json['data'] != null ? new DetailsGoodsData.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['code'] = this.code;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data.toJson();
    }
    return data;
  }
}

class DetailsGoodsData {
  GoodInfo goodInfo;
  List<GoodComments> goodComments;
  AdvertesPicture advertesPicture;

  DetailsGoodsData({this.goodInfo, this.goodComments, this.advertesPicture});

  DetailsGoodsData.fromJson(Map<String, dynamic> json) {
    goodInfo = json['goodInfo'] != null
        ? new GoodInfo.fromJson(json['goodInfo'])
        : null;
    if (json['goodComments'] != null) {
      goodComments = new List<GoodComments>();
      json['goodComments'].forEach((v) {
        goodComments.add(new GoodComments.fromJson(v));
      });
    }
    advertesPicture = json['advertesPicture'] != null
        ? new AdvertesPicture.fromJson(json['advertesPicture'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.goodInfo != null) {
      data['goodInfo'] = this.goodInfo.toJson();
    }
    if (this.goodComments != null) {
      data['goodComments'] = this.goodComments.map((v) => v.toJson()).toList();
    }
    if (this.advertesPicture != null) {
      data['advertesPicture'] = this.advertesPicture.toJson();
    }
    return data;
  }
}

class GoodInfo {
  String image5;
  int amount;
  String image3;
  String image4;
  String goodsId;
  String isOnline;
  String image1;
  String image2;
  String goodsSerialNumber;
  double oriPrice;
  double presentPrice;
  String comPic;
  int state;
  String shopId;
  String goodsName;
  String goodsDetail;

  GoodInfo(
      {this.image5,
      this.amount,
      this.image3,
      this.image4,
      this.goodsId,
      this.isOnline,
      this.image1,
      this.image2,
      this.goodsSerialNumber,
      this.oriPrice,
      this.presentPrice,
      this.comPic,
      this.state,
      this.shopId,
      this.goodsName,
      this.goodsDetail});

  GoodInfo.fromJson(Map<String, dynamic> json) {
    image5 = json['image5'];
    amount = json['amount'];
    image3 = json['image3'];
    image4 = json['image4'];
    goodsId = json['goodsId'];
    isOnline = json['isOnline'];
    image1 = json['image1'];
    image2 = json['image2'];
    goodsSerialNumber = json['goodsSerialNumber'];
    oriPrice = json['oriPrice'];
    presentPrice = json['presentPrice'];
    comPic = json['comPic'];
    state = json['state'];
    shopId = json['shopId'];
    goodsName = json['goodsName'];
    goodsDetail = json['goodsDetail'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['image5'] = this.image5;
    data['amount'] = this.amount;
    data['image3'] = this.image3;
    data['image4'] = this.image4;
    data['goodsId'] = this.goodsId;
    data['isOnline'] = this.isOnline;
    data['image1'] = this.image1;
    data['image2'] = this.image2;
    data['goodsSerialNumber'] = this.goodsSerialNumber;
    data['oriPrice'] = this.oriPrice;
    data['presentPrice'] = this.presentPrice;
    data['comPic'] = this.comPic;
    data['state'] = this.state;
    data['shopId'] = this.shopId;
    data['goodsName'] = this.goodsName;
    data['goodsDetail'] = this.goodsDetail;
    return data;
  }
}

class GoodComments {
  int sCORE;
  String comments;
  String userName;
  int discussTime;

  GoodComments({this.sCORE, this.comments, this.userName, this.discussTime});

  GoodComments.fromJson(Map<String, dynamic> json) {
    sCORE = json['SCORE'];
    comments = json['comments'];
    userName = json['userName'];
    discussTime = json['discussTime'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['SCORE'] = this.sCORE;
    data['comments'] = this.comments;
    data['userName'] = this.userName;
    data['discussTime'] = this.discussTime;
    return data;
  }
}

class AdvertesPicture {
  String pICTUREADDRESS;
  String tOPLACE;

  AdvertesPicture({this.pICTUREADDRESS, this.tOPLACE});

  AdvertesPicture.fromJson(Map<String, dynamic> json) {
    pICTUREADDRESS = json['PICTURE_ADDRESS'];
    tOPLACE = json['TO_PLACE'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['PICTURE_ADDRESS'] = this.pICTUREADDRESS;
    data['TO_PLACE'] = this.tOPLACE;
    return data;
  }
}
```

### [#](https://jspang.com/posts/2019/03/01/flutter-shop.html#provide建立) Provide建立

在实际开发中，我们是将业务逻辑和UI表现分开的，所以线建立一个Provide文件，所有业务逻辑将写在`Provide`里，然后`pages`文件夹里只写UI层面的东西。这样就把业务逻辑和UI进行了分离。

在`lib/provide/`文件夹下新建立一个`details_info.dart`文件，这个文件就是写商品详细页相关的业务逻辑的。

```text
import 'package:flutter/material.dart';
import '../model/details.dart';
import '../service/service_method.dart';
import 'dart:convert';

class DetailsInfoProvide with ChangeNotifier{
  
   DetailsModel goodsInfo =null;

  //从后台获取商品信息

  getGoodsInfo(String id ){
    var formData = { 'goodId':id, };
    
    request('getGoodDetailById',formData:formData).then((val){
      var responseData= json.decode(val.toString());
      print(responseData);
      goodsInfo=DetailsModel.fromJson(responseData);
      
      notifyListeners();
    });
   

  }

}
```

先引入刚建立好的Model，然后引入`service_method.dart`文件。声明`DetailsInfoProvide`l类，在类里边声明一个`DetailsModel`类型的 goodsInfo变量，初始值甚至成null，然后写一个从后台获取数据的方法,命名为`getGoodsInfo`。

### [#](https://jspang.com/posts/2019/03/01/flutter-shop.html#在ui调试接口) 在UI调试接口

直接在pages文件夹的`details_page.dart`文件里，写一个`_getBackInfo`方法，然后在build方法里使用一下。 如果控制台打印出商品详细的数据，说明接口已经调通。

```text
  void _getBackInfo(BuildContext context )async{
      await  Provide.value<DetailsInfoProvide>(context).getGoodsInfo(goodsId);
      print('加载完成............');
  }
```

总结：从这节课开始你的重点不应该放到Flutter语法生，要把重点放在项目的组织和分离上。

## [#](https://jspang.com/posts/2019/03/01/flutter-shop.html#第42节：详细页ui主页面架构搭建) 第42节：详细页UI主页面架构搭建

上节课已经把详细页大体的业务结构和跟后台的数据接口调通了，这节课开始搭建页面的UI。会把一个详细页分为6个主要部分来编写，也就是说把一个页面拆成六个大组件，并在不同的页面中。



### [#](https://jspang.com/posts/2019/03/01/flutter-shop.html#details-page页面的编写) details_page页面的编写

这个页面已经建立好了，在`lib/pages/`目录下，我们主要修改`build`方法。代码如下，视频中我会一行行进行解释。

```diff
   @override
   Widget build(BuildContext context) {
-    return Container(
-      child: Text('商品ID：${goodsId}'),
+    
+    return Scaffold(
+      appBar: AppBar(
+        leading: IconButton(
+          icon: Icon(Icons.arrow_back),
+          onPressed: (){
+            Navigator.pop(context);
+          },
+        ),
+        title: Text('商品详细页'),
+      ),
+
+      body: FutureBuilder(
+        future: _getBackInfo(context),
+        builder: (context, snapshot) {
+          if (snapshot.hasData) {
+            return Container(
+              child: Column(
+                children: <Widget>[
+                  Text('商品ID：${goodsId}')
+                ],
+              ),
+            );
+          } else {
+            return Text('加载中.......');
+          }
+        },
+      ),
     );
   }
//... ...
 }
```

在body区域,使用了`FutureBuilder Widget` ，可以实现异步建在的效果。并且在可以判断`snapshot.hasData`进行判断是否在加载还是在加载中。

### [#](https://jspang.com/posts/2019/03/01/flutter-shop.html#getbackinfo方法的修改) _getBackInfo方法的修改

在build方法里使用了`FutureBuilder`部件，所以使用的后台得到数据的方法，也要相应的做出修改，要最后返回一个Future 部件。代码如下:

```diff
-  void _getBackInfo(BuildContext context) async {
+  Future _getBackInfo(BuildContext context) async {
+    await Provide.value<DetailsInfoProvide>(context).getGoodsInfo(goodsId);
+    //print('加载完成.......');
+    return '完成加载';
  }
```

在这里给出所有代码方便你学习：

```dart
import 'package:flutter/material.dart';
import 'package:provide/provide.dart';
import '../provide/details_info.dart';



class DetailsPage extends StatelessWidget {
  final String goodsId;
  DetailsPage(this.goodsId);

  @override
  Widget build(BuildContext context) {
    
       return Scaffold(
         appBar: AppBar(
            leading: IconButton(
              icon:Icon(Icons.arrow_back),
              onPressed: (){
                print('返回上一页');
                Navigator.pop(context);
              },
              ),
            title: Text('商品详细页'),
          ),
          body:FutureBuilder(
            future: _getBackInfo(context) ,
            builder: (context,snapshot){
              if(snapshot.hasData){
                  return Container(
                    child:Row(
                          children: <Widget>[
                            
                          ],
                    )
                  );
              }else{
                  return Text('加载中........');
              }
            }
          )
       );

       
    
  }

  Future _getBackInfo(BuildContext context )async{
      await  Provide.value<DetailsInfoProvide>(context).getGoodsInfo(goodsId);
      return '完成加载';
  }
}
```

总结:这节课主要是把商品详细页的首页制作好，制作好以后会把商品详细页进行拆分，拆分成不同的组件到不同的文件中，虽然这很绕，但是在公司中的开发就是这样的。细致的差分适合于大型项目多人开发。最后由组长组合成一个页面。

## [#](https://jspang.com/posts/2019/03/01/flutter-shop.html#第43节：路由-补充首页跳转到详细页) 第43节：路由_补充首页跳转到详细页

前几节课只把首页的“火爆专区”加了跳转，这节课内容正好不多，就把其它需要加跳转到详细页的位置都加上跳转。需要注意的是，这些都需要加入context，上下文文件。

###  轮播图加入跳转

直接打开`home_page.dart`找到轮播图组件，在`ontap`里，加入下面的代码。

```diff
 //首页轮播组件
 class SwiperDiy extends StatelessWidget {
   final List swiperDataList;
   SwiperDiy({Key key, this.swiperDataList}): super(key:key);
 
   @override
   Widget build(BuildContext context) {
     return Container(
       height: ScreenUtil().setHeight(333),
       width: ScreenUtil().setWidth(750),
       child: Swiper(
         itemBuilder: (BuildContext context, int index){
-          return Image.network('${swiperDataList[index]['image']}',fit: BoxFit.fill,);
+          return InkWell(
+            onTap: (){
+              Application.router.navigateTo(context, "/detail?id=${swiperDataList[index]['goodsId']}");
+            },
+            child: Image.network('${swiperDataList[index]['image']}',fit: BoxFit.fill,),
+          );
         },
         itemCount: swiperDataList.length,
         pagination: new SwiperPagination(),
         autoplay: true,
       ),
     );
   }
 }

```

### [#](https://jspang.com/posts/2019/03/01/flutter-shop.html#商品推荐加入跳转) 商品推荐加入跳转

同样在商品推荐的`_item`内部方法里的`onTap`中加入下面代码。

```diff
-  Widget _item(index){
+  Widget _item(context, index){
     return InkWell(
-      onTap: (){},
+      onTap: (){
+        Application.router.navigateTo(context, "/detail?id=${recommendList[index]['goodsId']}");
+      },
       child: Container(
         height: ScreenUtil().setHeight(330),
         width: ScreenUtil().setWidth(250),
         padding: EdgeInsets.all(8.0),
         decoration:BoxDecoration(
           color:Colors.white,
           border:Border(
             left: BorderSide(width:0.5,color:Colors.black12)
           )
         ),
         child: Column(    //列
           children: <Widget>[
             Image.network(recommendList[index]['image']),
             Text('￥${recommendList[index]['mallPrice']}'),
             Text(
               '￥${recommendList[index]['price']}',
               style: TextStyle(
                 decoration: TextDecoration.lineThrough,
                 color:Colors.grey
               ),
             )
           ],
         ),
       ),
     );
   }
 
   Widget _recommedList(){
 
     return Container(
       height: ScreenUtil().setHeight(330),
       child: ListView.builder(
         scrollDirection: Axis.horizontal,
         itemCount: recommendList.length,
         itemBuilder: (context,index){
-          return _item(index);
+          return _item(context,index);
         },
       ),
     );
   }
```

### [#](https://jspang.com/posts/2019/03/01/flutter-shop.html#楼层加入跳转) 楼层加入跳转

在楼层方法的`_goodsItem`中的`onTap`方法中加入下面的代码.

```diff
 //楼层商品组件
 class FloorContent extends StatelessWidget {
   final List floorGoodsList;
 
   const FloorContent({Key key, this.floorGoodsList}) : super(key: key);
 
   @override
   Widget build(BuildContext context) {
     return Container(
       child: Column(
         children: <Widget>[
-          _firstRow(),
-          _otherGoods()
+          _firstRow(context),
+          _otherGoods(context)
         ],
       ),
     );
   }
 
-  Widget _firstRow() {
+  Widget _firstRow(context) {
     return Row(
       children: <Widget>[
-        _goodsItem(floorGoodsList[0]),
+        _goodsItem(context, floorGoodsList[0]),
         Column(
           children: <Widget>[
-            _goodsItem(floorGoodsList[1]),
-            _goodsItem(floorGoodsList[2]),
+            _goodsItem(context, floorGoodsList[1]),
+            _goodsItem(context, floorGoodsList[2]),
           ],
         )
       ],
     );
   }
 
-  Widget _otherGoods(){
+  Widget _otherGoods(context){
     return Row(
       children: <Widget>[
-        _goodsItem(floorGoodsList[3]),
-        _goodsItem(floorGoodsList[4]),
+        _goodsItem(context, floorGoodsList[3]),
+        _goodsItem(context, floorGoodsList[4]),
       ],
     );
   }
 
-  Widget _goodsItem(Map goods) {
+  Widget _goodsItem(BuildContext context, Map goods) {
     return Container(
       width: ScreenUtil().setWidth(375),
       child: InkWell(
         onTap: (){
-          print('点击了楼层商品');
+          Application.router.navigateTo(context, "/detail?id=${goods['goodsId']}");
         },
         child: Image.network(goods['image']),
       ),
     );
   }

```

总结:我本来觉的这个小伙伴可以自己加入进来，但是还是有很多小伙伴遇到了麻烦，那为了能让每个人都做出视频中的效果，这节课作为一个补充。

## [#](https://jspang.com/posts/2019/03/01/flutter-shop.html#第44节：详细页-首屏自定义widget编写) 第44节：详细页_首屏自定义Widget编写

这节课把详细页首屏独立出来，这样业务逻辑更具体，以后也会降低维护成本。最主要的是主UI文件不会变的臃肿不堪。

###  建立文件和引入资源

在`/lib/pages/`文件夹下面，新建一个文件夹，命名为`details_page`,然后进入文件夹，新建立文件`details_top_area.dart`。意思是商品详细页的顶部区域。

然后用`import`引入如下文件:

```text
import 'package:flutter/material.dart';
import 'package:provide/provide.dart';
import '../../provide/details_info.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
```

然后用快速生成的方法，新建一个`StatelessWidget`的类。

```text
class DetailsTopArea extends StatelessWidget {
    
}
```

先不管build方法，通过分析，我们把这个首屏页面进行一个组件方法的拆分。

### [#](https://jspang.com/posts/2019/03/01/flutter-shop.html#商品图片方法) 商品图片方法

直接写一个内部方法，然后返回一个商品图片就可以了，代码如下:

```dart
  //商品图片
  Widget _goodsImage(url){
    return  Image.network(
        url,
        width:ScreenUtil().setWidth(740) 
    );

  }
```

### [#](https://jspang.com/posts/2019/03/01/flutter-shop.html#商品名称方法) 商品名称方法

```dart
  //商品名称
  Widget _goodsName(name){

      return Container(
        width: ScreenUtil().setWidth(730),
        padding: EdgeInsets.only(left:15.0),
        child: Text(
          name,
          maxLines: 1,
          style: TextStyle(
            fontSize: ScreenUtil().setSp(30)
          ),
        ),
      );
  }
```

### [#](https://jspang.com/posts/2019/03/01/flutter-shop.html#编号方法) 编号方法

```dart
  Widget _goodsNum(num){
    return  Container(
      width: ScreenUtil().setWidth(730),
      padding: EdgeInsets.only(left:15.0),
      margin: EdgeInsets.only(top:8.0),
      child: Text(
        '编号:${num}',
        style: TextStyle(
          color: Colors.black26
        ),
      ),
      
    );
  }
```

### [#](https://jspang.com/posts/2019/03/01/flutter-shop.html#build方法编写) Build方法编写

再build方法的最外层，使用了`Provde Widget`，目的就是当状态发生变化时页面也进行变化。在`Provide`的构造器里，声明了一个`goodsInfo`变量，再通过Provide得到变量。然后进行UI的组合编写。

代码如下:

```text
  Widget build(BuildContext context) {
    return Provide<DetailsInfoProvide>(

      builder:(context,child,val){
        var goodsInfo=Provide.value<DetailsInfoProvide>(context).goodsInfo.data.goodInfo;

        if(goodsInfo != null){

           return Container(
                color: Colors.white,
                padding: EdgeInsets.all(2.0),
                child: Column(
                  children: <Widget>[
                      _goodsImage( goodsInfo.image1),
                      _goodsName( goodsInfo.goodsName ),  
                      _goodsNum(goodsInfo.goodsSerialNumber),
                      _goodsPrice(goodsInfo.presentPrice,goodsInfo.oriPrice)
                  ],
                ),
              );

        }else{
          return Text('正在加载中......');
        }
      }
    );
  }
```

为了方便学习，现在给出总体代码：

```dart
import 'package:flutter/material.dart';
import 'package:provide/provide.dart';
import '../../provide/details_info.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

//商品详情页的首屏区域，包括图片、商品名称，商品价格，商品编号的UI展示
class DetailsTopArea extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Provide<DetailsInfoProvide>(

      builder:(context,child,val){
        var goodsInfo=Provide.value<DetailsInfoProvide>(context).goodsInfo.data.goodInfo;

        if(goodsInfo != null){

           return Container(
                color: Colors.white,
                padding: EdgeInsets.all(2.0),
                child: Column(
                  children: <Widget>[
                      _goodsImage( goodsInfo.image1),
                      _goodsName( goodsInfo.goodsName ),  
                      _goodsNum(goodsInfo.goodsSerialNumber),
                      _goodsPrice(goodsInfo.presentPrice,goodsInfo.oriPrice)
                  ],
                ),
              );

        }else{
          return Text('正在加载中......');
        }
      }
    );
  }

  //商品图片
  Widget _goodsImage(url){
    return  Image.network(
        url,
        width:ScreenUtil().setWidth(740) 
    );

  }

  //商品名称
  Widget _goodsName(name){

      return Container(
        width: ScreenUtil().setWidth(730),
        padding: EdgeInsets.only(left:15.0),
        child: Text(
          name,
          maxLines: 1,
          style: TextStyle(
            fontSize: ScreenUtil().setSp(30)
          ),
        ),
      );
  }

  //商品编号

  Widget _goodsNum(num){
    return  Container(
      width: ScreenUtil().setWidth(730),
      padding: EdgeInsets.only(left:15.0),
      margin: EdgeInsets.only(top:8.0),
      child: Text(
        '编号:${num}',
        style: TextStyle(
          color: Colors.black26
        ),
      ),
      
    );
  }

  //商品价格方法

  Widget _goodsPrice(presentPrice,oriPrice){

    return  Container(
      width: ScreenUtil().setWidth(730),
      padding: EdgeInsets.only(left:15.0),
      margin: EdgeInsets.only(top:8.0),
      child: Row(
        children: <Widget>[
          Text(
            '￥${presentPrice}',
            style: TextStyle(
              color:Colors.pinkAccent,
              fontSize: ScreenUtil().setSp(40),

            ),

          ),
          Text(
            '市场价:￥${oriPrice}',
            style: TextStyle(
              color: Colors.black26,
              decoration: TextDecoration.lineThrough
            ),
                
            
            )
        ],
      ),
    );

  }
  

}
```

### [#](https://jspang.com/posts/2019/03/01/flutter-shop.html#加入到ui当中) 加入到UI当中

现在这个首屏组件算是编写好，就可以在主UI文件中`lib/pages/details_page.dart`中进行引入，并展现出来了。

```text
import './details_page/details_top_area.dart';
```

引入后，在build方法里的column部件中进行加入下面的代码.

```diff
           body:FutureBuilder(
             future: _getBackInfo(context) ,
             builder: (context,snapshot){
               if(snapshot.hasData){
                   return Container(
                    child: Column(
                      children: <Widget>[
-                      
+                        DetailsTopArea(),
                      ],
                    ),
                  );       
        
               }else{
                   return Text('加载中........');
               }
               }
             )

```

总结:本节课的内容比较多，都是些Flutter页面制作的实战方法，希望小伙伴们动手制作，都能实现出完美的效果。

## [#](https://jspang.com/posts/2019/03/01/flutter-shop.html#第45节：详细页-说明区域ui编写) 第45节：详细页_说明区域UI编写

这节先把说明区域给制作出来，当然这部分也单独的独立出来。然后再自己学一个`tabBar Widget`。对！你没有听错，就是自己写，不用官方自带的。学习吗，就是要变态的折磨自己，现在不是流行盘吗。那我们也要有盘的心态，赏玩Flutter。

###  说明区域制作

首先在`lib/pages/details_page`文件夹下，建立`details_explain`文件。建立好后，先引入所需要的文件,代码如下：

```dart
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
```

然后生成一个`StatelessWidget`，然后就是编写UI样式了，整体艾玛如下。

```dart
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';


class DetailsExplain extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
       color:Colors.white,
       margin: EdgeInsets.only(top: 10),
       width: ScreenUtil().setWidth(750),
       padding: EdgeInsets.all(10.0),
       child: Text(
         '说明：> 急速送达 > 正品保证',
         style: TextStyle(
           color:Colors.red,
           fontSize:ScreenUtil().setSp(30) ),
      )
    );
  }
}
```

编写好以后，可以到`details_page.dart`里进行引用和使用，先进行引用。

```dart
import './details_page/details_explain.dart';
```

然后在build方法body区域的Column中引用，代码如下，关注关键代码即可。

```diff
body:FutureBuilder(
  future: _getBackInfo(context) ,
  builder: (context,snapshot){
    if(snapshot.hasData){
        return Container(
          child:Column(
                children: <Widget>[
                    DetailsTopArea(),
+                    DetailsExplain(),
                ],
          )
        );
    }else{
        return Text('加载中........');
    }
  }
)
```

这步完成后就可以进行预览效果了，看看效果是不是自己想要的。

总结：这节课内容很少，但绝对不是混集数，原计划的60集如果不够，我会把集数调多，保证把规划的知识点都讲了。

## [#](https://jspang.com/posts/2019/03/01/flutter-shop.html#第46节：详细页-自建tabbar-widget) 第46节：详细页_自建TabBar Widget

这节课自己建一个`tabBar Widget`，而不用Flutter自带的`tabBar widget`。对！你没有听错，就是自己写，不用官方自带的。学习吗，就是要变态的折磨自己，现在不是流行盘吗。那我们也要有盘的心态，赏玩Flutter。这几天我也花了60大洋买了一个文玩核桃，准备学着盘完一下，磨一下放浪不羁的心性。

###  tabBar编写技巧

在`lib/pages/details_page`文件夹下，新建一个`details_tabbar.dart`文件。

这个文件主要是写bar区域的UI和交互效果，就算这样简单的业务逻辑，也进行了分离。

先打开`provide`文件夹下的`details_info.dart`文件，进行修改。需要增加两个变量,用来控制那个Tab被选中。

```text
   bool isLeft = true;
   bool isRight = false;
```

然后在文件的最下方加入一个方法，用来改变选中的值，这个方法先这样写，以后会随着业务的增加而继续补充和改变.

```text
  //改变tabBar的状态
  changeLeftAndRight(String changeState){
    if(changeState=='left'){
      isLeft=true;
      isRight=false;
    }else{
      isLeft=false;
      isRight=true;
    }
     notifyListeners();

  }
```

Provide文件编写好以后，就可以打开刚才建立好的`details_tabbar.dart`文件进行编写了。

先把所需要的文件进行引入：

```text
mport 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provide/provide.dart';
import '../../provide/details_info.dart';
```

然后用快捷方法生成一个`StatelessWidget`,在build方法的下方，写入一个返回Widget的方法，代码如下：

```text
  Widget _myTabBarLeft(BuildContext context,bool isLeft){
    return InkWell(
      onTap: (){
      
        Provide.value<DetailsInfoProvide>(context).changeLeftAndRight('left');
      },
      child: Container(
       
        padding:EdgeInsets.all(10.0),
        alignment: Alignment.center,
        width: ScreenUtil().setWidth(375),
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border(
            bottom: BorderSide(
              width: 1.0,
              color: isLeft?Colors.pink:Colors.black12 
            )
          )
        ),
        child: Text(
          '详细',
          style: TextStyle(
            color:isLeft?Colors.pink:Colors.black 
          ),
        ),
      ),
    );
  }
```

这个方法就是详细的bar，然后再复制这段代码，修改成右边的bar。

```dart
Widget _myTabBarRight(BuildContext context,bool isRight){
    return InkWell(
      onTap: (){
      
        Provide.value<DetailsInfoProvide>(context).changeLeftAndRight('right');
      },
      child: Container(
         
        padding:EdgeInsets.all(10.0),
        alignment: Alignment.center,
        width: ScreenUtil().setWidth(375),
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border(
            bottom: BorderSide(
              width: 1.0,
              color: isRight?Colors.pink:Colors.black12 
            )
          )
        ),
        child: Text(
          '评论',
          style: TextStyle(
            color:isRight?Colors.pink:Colors.black 
          ),
        ),
      ),
    );
  }
```

两个方法当然是一个合并成一个方法的，这样会放到所有代码实现之后，我们进行代码的优化。现在要作的是把build方法写好。代码如下：

```dart
Widget build(BuildContext context) {
return Provide<DetailsInfoProvide>(
  builder: (context,child,val){
    var isLeft= Provide.value<DetailsInfoProvide>(context).isLeft;
    var isRight =Provide.value<DetailsInfoProvide>(context).isRight;
    
    return Container(
      margin: EdgeInsets.only(top: 15.0),
      child: Column(
        children: <Widget>[
          Row(
            children: <Widget>[
              _myTabBarLeft(context,isLeft),
              _myTabBarRight(context,isRight)
            ],
          ),
        ],


      ),
      
    ) ;
  },
  
); 
}
```

为了方便你学习，这里给出所有的`details_tabbar.dart`文件，代码如下：

```dart
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provide/provide.dart';
import '../../provide/details_info.dart';

class DetailsTabBar extends StatelessWidget {
  
    Widget build(BuildContext context) {
    return Provide<DetailsInfoProvide>(
      builder: (context,child,val){
        var isLeft= Provide.value<DetailsInfoProvide>(context).isLeft;
        var isRight =Provide.value<DetailsInfoProvide>(context).isRight;
       
        return Container(
          margin: EdgeInsets.only(top: 15.0),
          child: Column(
            children: <Widget>[
              Row(
                children: <Widget>[
                  _myTabBarLeft(context,isLeft),
                  _myTabBarRight(context,isRight)
                ],
              ),
            ],


          ),
          
        ) ;
      },
      
    ); 
  }

  Widget _myTabBarLeft(BuildContext context,bool isLeft){
    return InkWell(
      onTap: (){
      
        Provide.value<DetailsInfoProvide>(context).changeLeftAndRight('left');
      },
      child: Container(
       
        padding:EdgeInsets.all(10.0),
        alignment: Alignment.center,
        width: ScreenUtil().setWidth(375),
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border(
            bottom: BorderSide(
              width: 1.0,
              color: isLeft?Colors.pink:Colors.black12 
            )
          )
        ),
        child: Text(
          '详细',
          style: TextStyle(
            color:isLeft?Colors.pink:Colors.black 
          ),
        ),
      ),
    );
  }
  Widget _myTabBarRight(BuildContext context,bool isRight){
    return InkWell(
      onTap: (){
      
        Provide.value<DetailsInfoProvide>(context).changeLeftAndRight('right');
      },
      child: Container(
         
        padding:EdgeInsets.all(10.0),
        alignment: Alignment.center,
        width: ScreenUtil().setWidth(375),
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border(
            bottom: BorderSide(
              width: 1.0,
              color: isRight?Colors.pink:Colors.black12 
            )
          )
        ),
        child: Text(
          '评论',
          style: TextStyle(
            color:isRight?Colors.pink:Colors.black 
          ),
        ),
      ),
    );
  }

}
```

### [#](https://jspang.com/posts/2019/03/01/flutter-shop.html#把tabbar引入项目) 把TabBar引入项目

打开`details_page.dart`文件，然后把`detals_tabbar.dart`文件进行引入。

```text
import './details_page/details_tabBar.dart';
```

然后再coloumn部分加入就可以了

```dart
child:Column(
      children: <Widget>[
          DetailsTopArea(),
          DetailsExplain(),
          DetailsTabBar()
      ],
)
```

总结:这节的内容还是比较多的，重点是如何不用Flutter自带UI自己实现页面交互效果。希望小伙伴们多多练习。

## [#](https://jspang.com/posts/2019/03/01/flutter-shop.html#第47节：详细页-flutter-html插件的使用) 第47节：详细页_Flutter_html插件的使用

在详细页里的商品详细部分，是由图片和HTML组成的。但是Flutter本身是不支持Html的解析的，所以需要找个轮子，我之前用的是`flutter_webView_plugin`，但是效果不太好。经过大神网友推荐，最终选择了`flutter_html`.

###  首次进入详细页Bug处理

在第一次进入进入详细页的时候，会有错误出现，页面也会变成一篇红色，当然这只是一瞬间。所以很多小伙伴没有看出来，但是如果你注意控制台，就会看出这个错误提示。

这个问题的主要原因是没有使用异步方法，所以在Provide里使用一下异步就可以解决。代码如下:

```text
  //从后台获取商品数据
  getGoodsInfo(String id) async{
    var formData = {'goodId':id};
    await request('getGoodDetailById',formData:formData).then((val){
      var responseData= json.decode(val.toString());
      goodsInfo = DetailsModle.fromJson(responseData);
      notifyListeners();

    });

  }
```

### [#](https://jspang.com/posts/2019/03/01/flutter-shop.html#flutter-html介绍) flutter_html介绍

`flutter_html`是一个可以解析静态html标签的Flutter Widget，现在支持超过70种不同的标签。

> github地址：https://github.com/Sub6Resources/flutter_html

也算是目前支持html标签比较多的插件了，先进行插件的依赖注册，打开`pubspec.yaml`文件。在dependencies里边，加入下面的代码:

```text
flutter_html: ^0.9.6
```

如果你不是跟着教程走的，你需要到github上看一下最新的版本，然后使用最新的版本。

### [#](https://jspang.com/posts/2019/03/01/flutter-shop.html#代码的编写) 代码的编写

当依赖和包下载好以后，直接在`lib/pages/details_page`文件夹下建立一个`detals_web.dart`文件。

建立好后，先引入依赖包。

```text
import 'package:flutter/material.dart';
import 'package:provide/provide.dart';
import '../../provide/details_info.dart';
import 'package:flutter_html/flutter_html.dart';
```

然后写一个`StatelessWidget`，在他的build方法里，声明一个变量goodsDetail，然后用`Provide`的获得值。有了值之后直接使用Html Widget 就可以显示出来了。

```text
import 'package:flutter/material.dart';
import 'package:provide/provide.dart';
import '../../provide/details_info.dart';
import 'package:flutter_html/flutter_html.dart';

class DetailsWeb extends StatelessWidget {
  
  @override
  Widget build(BuildContext context) {
    var goodsDetail=Provide.value<DetailsInfoProvide>(context).goodsInfo.data.goodInfo.goodsDetail;
    return Container(
        child: Html(
          data:goodsDetail
        ),
    
      
    );
  }
}
```

这节课我们先不写什么业务逻辑，只是学习一下这个组件就可以。下节课我们在完善具体的业务逻辑。

### [#](https://jspang.com/posts/2019/03/01/flutter-shop.html#加入到details-page-dart种) 加入到`details_page.dart`种

先引入刚才编写的`details_web.dart`文件。

```text
import './details_page/details_web.dart';
```

然后在`column`的`children`数组中加入`DetailsWeb()`。

```text
children: <Widget>[
    DetailsTopArea(),
    DetailsExplain(),
    DetailsTabBar(),
    //关键代码-------------start
    DetailsWeb()
    //关键代码-------------end
],
```

如果出现溢出问题，那直接把`Column`换成`ListView`就可以了。

这些都做完了，就可以简单看一下效果了，应该还是很完美的。那需要注意的是，这只是为了讲课每节课都有一个节点，以后还会改动UI代码和业务逻辑增加。

## [#](https://jspang.com/posts/2019/03/01/flutter-shop.html#第48节：详细页-详情和评论切换效果制作) 第48节：详细页_详情和评论切换效果制作

这节主要制作一下商品详情和评论页面的切换交互效果，思路是利用`Provide`进行业务处理，然后根据状态进行判断返回不同的Widget。

###  嵌套Provide组件

在build返回里，的return部分，嵌套一个`Provide`组件。然后在builder里取得`isLieft`的值，如果值为`true`，那说明点击了商品详情，如果是`false`，那说明点击了评论的`tabBar`。

全部代码如下:

```dart
import 'package:flutter/material.dart';
import 'package:provide/provide.dart';
import '../../provide/details_info.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DetailsWeb extends StatelessWidget {
  
  @override
  Widget build(BuildContext context) {
    var goodsDetail=Provide.value<DetailsInfoProvide>(context).goodsInfo.data.goodInfo.goodsDetail;
    
   
      return  Provide<DetailsInfoProvide>(
        
        builder: (context,child,val){
           var isLeft = Provide.value<DetailsInfoProvide>(context).isLeft;
           if(isLeft){
             return  Container(
                  child: Html(
                    data:goodsDetail
                  ),
              );
           }else{
            return Container(
              width: ScreenUtil().setWidth(750),
              padding: EdgeInsets.all(10),
              alignment: Alignment.center,
              child:Text('暂时没有数据')
            );
           }
        },
      );
      
  }
}
```

我看了小程序中，大部分都是没有商品评论的，而且商品评论的代码也没有什么新的知识点，所以这里就写成固定的内容。如果感兴趣的小伙伴可以自己完成此部分的编写。

总结，到目前位置，详细页面的主要制作已经完成。只是还缺少一个底部的购买按钮。

## [#](https://jspang.com/posts/2019/03/01/flutter-shop.html#第49节：详细页页-stack作底部操作栏) 第49节：详细页页_Stack作底部操作栏

在详细页面底部是有一个操作栏一直在底部的，主要用于进行加入购物车、直接购买商品和进入购物车页面。制作这个只要需要使用`Stack`组件就可以了。

###  Stack组件介绍

Stack组件是层叠组件，里边的每一个子控件都是定位或者不定位，定位的子控件是被`Positioned Widget`进行包裹的。

比如现在改写之前的`details_page.dart`文件，在`ListView`的外边包裹`Stack Widget`。修改的代码如下。

```diff
import 'package:flutter/material.dart';
import 'package:provide/provide.dart';
import '../provide/details_info.dart';
import './details_page/details_top_area.dart';
import './details_page/details_explain.dart';
import './details_page/details_tabBar.dart';
import './details_page/details_web.dart';



class DetailsPage extends StatelessWidget {
  final String goodsId;
  DetailsPage(this.goodsId);
  
   @override
  Widget build(BuildContext context) {
    
       return Scaffold(
         appBar: AppBar(
            leading: IconButton(
              icon:Icon(Icons.arrow_back),
              onPressed: (){
                print('返回上一页');
                Navigator.pop(context);
              },
              ),
            title: Text('商品详细页'),
          ),
                     body:FutureBuilder(
             future: _getBackInfo(context) ,
             builder: (context,snapshot){
               if(snapshot.hasData){
-                  return Container(
-                    child: ListView(
-                      children: <Widget>[
-                        DetailsTopArea(),
-                        DetailsExplain(),
-                        DetailsTabbar(),
-                        DetailsWeb(),
-                      ],
-                    ),
-                  );       
+                
+                  return Stack(
+                    children: <Widget>[
+                      ListView(
+                        children: <Widget>[
+                          DetailsTopArea(),
+                          DetailsExplain(),
+                          DetailsTabbar(),
+                          DetailsWeb(),
+                        ],
+                      ),
+                      Positioned(
+                        bottom: 0,
+                        left: 0,
+                        child:Text('测试'),
+                      )
+                    ],
+                  );
+                         
               }else{
                   return Text('加载中........');
               }
               }
             )

       );
  }

  Future _getBackInfo(BuildContext context )async{
      await  Provide.value<DetailsInfoProvide>(context).getGoodsInfo(goodsId);
      return '完成加载';
  }

}
```

修改完成后，就可以看一下效果了。是不是已经实现了层叠效果了。

### [#](https://jspang.com/posts/2019/03/01/flutter-shop.html#制作底部工具栏) 制作底部工具栏

这个工具栏我们使用Flutter自带的`bottomNavBar`是没办法实现的，所以，我们才用了Stack，把他固定在页面底部。然后我们还需要新建立一个页面，在`lib/pages/details_page`文件夹下，新建立一个`details_bottom.dart`文件。

在这个文件中，我们才用了`Row`布局，然后使用`Containter`进行了精准的控制，最终实现了想要的结果。代码如下：

```dart
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';


class DetailsBottom extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
       width:ScreenUtil().setWidth(750),
       color: Colors.white,
       height: ScreenUtil().setHeight(80),
       child: Row(
         children: <Widget>[
           InkWell(
             onTap: (){},
             child: Container(
                width: ScreenUtil().setWidth(110) ,
                alignment: Alignment.center,
                child:Icon(
                      Icons.shopping_cart,
                      size: 35,
                      color: Colors.red,
                    ), 
              ) ,
           ),
           InkWell(
             onTap: (){},
             child: Container(
               alignment: Alignment.center,
               width: ScreenUtil().setWidth(320),
               height: ScreenUtil().setHeight(80),
               color: Colors.green,
               child: Text(
                 '加入购物车',
                 style: TextStyle(color: Colors.white,fontSize: ScreenUtil().setSp(28)),
               ),
             ) ,
           ),
           InkWell(
             onTap: (){},
             child: Container(
               alignment: Alignment.center,
               width: ScreenUtil().setWidth(320),
               height: ScreenUtil().setHeight(80),
               color: Colors.red,
               child: Text(
                 '马上购买',
                 style: TextStyle(color: Colors.white,fontSize: ScreenUtil().setSp(28)),
               ),
             ) ,
           ),
         ],
       ),
    );
  }
}
```

### [#](https://jspang.com/posts/2019/03/01/flutter-shop.html#加入到页面中) 加入到页面中

写完这个Widget后，需要在商品详细页`details_page.dart`里先用`import`引入。

```text
import './details_page/details_bottom.dart';
```

然后把组件放到`Positioned`里，代码如下：

```diff
Positioned(
  bottom: 0,
  left: 0,
-  child:Text('测试'),
+  child: DetailsBottom(),
)
```

总结:这节课完成后，我们商品详细页的大部分交互效果就已经完成了，下节课开始，我们要制作购物车的效果了。希望小伙伴们能耐心的把商品详细页的代码完成。

## [#](https://jspang.com/posts/2019/03/01/flutter-shop.html#第50节-持久化-shared-preferences基础1) 第50节:持久化_shared_preferences基础1

购物车中的一项功能是持久化，就是我们关掉APP，下次进入后，还是可以显示出我们放入购物车的商品。但是这些商品不和后台进行数据交互，前台如果使用`sqlite`又显得太重，还要懂SQL知识。所以在购物车页面我们采用`shared_preferences`来进行持久化，它是简单的键-值的操作。

> 单词：
> preference [ˈprefrəns] n. 偏爱，倾向；优先权



###  认识`shared_preferences`

`shared_preferences`是一个Flutter官方出的插件，它的主要作用就是可以`key-value`的形式来进行APP可客户端的持久化。

> GitHub地址:https://github.com/flutter/plugins/tree/master/packages/shared_preferences

项目包依赖设置

既然是插件，使用前需要在`pubspec.yaml`里进行依赖设置，直接在`dependencies`里加入下面的代码:

```text
shared_preferences: ^0.5.1
```

课程编写是`0.5.1`是最新版本，你学习时请使用最新版本。写完以来后，需要进行下载`package`。

### [#](https://jspang.com/posts/2019/03/01/flutter-shop.html#shared-preferences-增加方法) shared_preferences 增加方法

先来看看`shared_preferences`如何进行增加所存储的`key-value`值。删除购物车页面以前的代码，在这个页面进行新知识的学习。

先引入几个必要的包，使用`shared_preferences`前是要用import进行引入的。

```text
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
```

然后用快速生成的方法`stful`，生成一个`StatefulWidget`类，起类名叫`CartPage`。在类里声明一个变量`testList`。

```text
  List<String> testList =[];
```

此时代码如下：

```dart
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';


class CartPage extends StatefulWidget {
  @override
  _CartPageState createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {

  List<String> testList =[];
  @override
  Widget build(BuildContext context) {
    return Container(

    );
  }
}
```

### [#](https://jspang.com/posts/2019/03/01/flutter-shop.html#编写增加方法) 编写增加方法

我们在类里声明一个内部方法`add`,代码如下:

```dart
  void _add() async {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String temp="技术胖是最胖的!";
      testList.add(temp);
      prefs.setStringList('testInfo', testList);
      _show();
  }
```

### [#](https://jspang.com/posts/2019/03/01/flutter-shop.html#编写显示方法) 编写显示方法

```dart
  void _show() async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
        if(prefs.getStringList('testInfo')!=null){
            testList=prefs.getStringList('testInfo');
        }
       
    });
  }
```

### [#](https://jspang.com/posts/2019/03/01/flutter-shop.html#编写删除方法) 编写删除方法

```dart
 void _clear() async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    //prefs.clear(); //全部清空
    prefs.remove('testInfo'); //删除key键
    setState((){
      testList=[];
    });
  }
```

### [#](https://jspang.com/posts/2019/03/01/flutter-shop.html#build方法编写-2) build方法编写

有了这些方法，我们只要在build里加入一个`ListView`再加上两个按钮就可以了。

```dart
@override
  Widget build(BuildContext context) {
    _show();  //每次进入前进行显示
    return Container(

      child:Column(
        children: <Widget>[
          Container(
            height: 500.0,
            child: ListView.builder(
                itemCount:testList.length ,
                itemBuilder: (context,index){
                  return ListTile(
                    title: Text(testList[index]),
                  );
                },
              ) ,
          ),
         
          RaisedButton(
            onPressed: (){_add();},
            child: Text('增加'),
          ),
          RaisedButton(
            onPressed: (){_clear();},
            child: Text('清空'),
          ),
        ],
      )
       
    );
  }
```

这样就完成了所有代码的编写，但这节课并不是为了做出什么效果，而是学会`shared_preferences`的增删改查操作。

## [#](https://jspang.com/posts/2019/03/01/flutter-shop.html#第51节：购物车-添加商品) 第51节：购物车_添加商品

从这节课开始，就正式开始制作购物车部分的内容了。这也算是本套视频最复杂的一个章节，也是我们基本掌握Flutter实战技巧关键的一个章节，当然我会还是采用UI代码和业务逻辑完全分开的形式，让代码完全解耦。

###  Provide的建立

因为要UI和业务进行分离，所以还是需要先建立一个`Provide`文件,在`lib/provide/`文件夹下，建立一个`cart.dart`文件。

先引入下面三个文件和包:

```text
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
```

引进后建立一个类，并在里边写一个字符串变量（后期会换成对象）。代码如下：

```text
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class CartProvide with ChangeNotifier{

  String cartString="[]";

}
```

### [#](https://jspang.com/posts/2019/03/01/flutter-shop.html#添加商品到购物车) 添加商品到购物车

先来制作把商品添加到购物车的方法。思路是这样的，利用`shared_preferences`可以保存字符串的特点，我们先把`List`传换成字符串，然后操作的时候，我们再转换回来。说简单点就是持久化的只是一串字符串，然后需要操作的时候，我们变成List，操作List的每一项就可以了。

在`cart.dart`中添加：

```text
  save(goodsId,goodsName,count,price,images) async{
    //初始化SharedPreferences
    SharedPreferences prefs = await  SharedPreferences.getInstance();
    cartString=prefs.getString('cartInfo');  //获取持久化存储的值
    //判断cartString是否为空，为空说明是第一次添加，或者被key被清除了。
    //如果有值进行decode操作
    var temp=cartString==null?[]:json.decode(cartString.toString());
    //把获得值转变成List
    List<Map> tempList= (temp as List).cast();
    //声明变量，用于判断购物车中是否已经存在此商品ID
    var isHave= false;  //默认为没有
    int ival=0; //用于进行循环的索引使用
    tempList.forEach((item){//进行循环，找出是否已经存在该商品
      //如果存在，数量进行+1操作
      if(item['goodsId']==goodsId){
        tempList[ival]['count']=item['count']+1;
        isHave=true;
      }
      ival++;
    });
    //  如果没有，进行增加
    if(!isHave){
      tempList.add({
        'goodsId':goodsId,
        'goodsName':goodsName,
        'count':count,
        'price':price,
        'images':images
      });
    }
    //把字符串进行encode操作，
    cartString= json.encode(tempList).toString();
    print(cartString);
    prefs.setString('cartInfo', cartString);//进行持久化
   
  }
```

### [#](https://jspang.com/posts/2019/03/01/flutter-shop.html#清空购物车) 清空购物车

为了测试方便，再顺手写一个清空购物车的方法，这个还没有谨慎思考，只是为了测试使用。

```text
  remove() async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    //prefs.clear();//清空键值对
    prefs.remove('cartInfo');
    print('清空完成-----------------');
    notifyListeners();
  }
```

### [#](https://jspang.com/posts/2019/03/01/flutter-shop.html#注册全局依赖) 注册全局依赖

到`main.dart`文件中注册全局依赖，先引入`cart.dart`文件.

```text
import './provide/cart.dart';
```

然后在main区域进行声明

```text
var cartProvide = CartProvide();
```

进行注入:

```text
..provide(Provider<CartProvide>.value(cartProvide))
```

### [#](https://jspang.com/posts/2019/03/01/flutter-shop.html#业务逻辑加入到ui) 业务逻辑加入到UI

在`details_bottom.dart`文件里，加入`Provide`，先进行引入。

```dart
import 'package:provide/provide.dart';
import '../../provide/cart.dart';
import '../../provide/details_info.dart';
```

然后声明`provide`的save方法中需要的参数变量。

```diff
class DetailsBottom extends StatelessWidget {
  
  @override
  Widget build(BuildContext context) {
+    var goodsInfo = Provide.value<DetailsInfoProvide>(context).goodsInfo.data.goodInfo;
+    var goodsId = goodsInfo.goodsId;
+    var goodsName = goodsInfo.goodsName;
+    var count = 1;
+    var price = goodsInfo.presentPrice;
+    var images = goodsInfo.image1;
    return Container(
      width: ScreenUtil().setWidth(750),
      color: Colors.white,
      height: ScreenUtil().setHeight(80),
// ...
```

然后在“加入购物车”的按钮的`onTap`方法中，加入下面代码.

```dart
onTap: ()async {
  await Provide.value<CartProvide>(context).save(goodsID,goodsName,count,price,images);
  },
```

先暂时把“马上购买”按钮方式清除购物车的方法，方便我们测试。

```dart
onTap: ()async{
  await Provide.value<CartProvide>(context).remove();
},
```

做完这个写，我们就要查看一下效果了，看看是否可以真的持久化。

## [#](https://jspang.com/posts/2019/03/01/flutter-shop.html#第52节：购物车-建立数据模型) 第52节：购物车_建立数据模型

上节课使用了字符串进行持久化，然后输出的时候都是Map，但是在真实工作中为了减少异常的发生，都要进行模型化处理，就是把Map转变为对象。

###  建立模型文件

得到的购物车数据，如下：

```text
{"goodsId":"2171c20d77c340729d5d7ebc2039c08d","goodsName":"五粮液52°500ml","count":1,"price":830.0,"images":"http://images.baixingliangfan.cn/shopGoodsImg/20181229/20181229211422_8507.jpg"}
```

拷贝到自动生成mode的页面上,网址是：

> https://javiercbk.github.io/json_to_dart/

生成后，在model文件夹下，建立一个新文件`cartInfo.dart`，然后把生成的mode文件进行改写，代码如下:

```dart
class CartInfoMode {
  String goodsId;
  String goodsName;
  int count;
  double price;
  String images;

  CartInfoMode(
      {this.goodsId, this.goodsName, this.count, this.price, this.images});

  CartInfoMode.fromJson(Map<String, dynamic> json) {
    goodsId = json['goodsId'];
    goodsName = json['goodsName'];
    count = json['count'];
    price = json['price'];
    images = json['images'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['goodsId'] = this.goodsId;
    data['goodsName'] = this.goodsName;
    data['count'] = this.count;
    data['price'] = this.price;
    data['images'] = this.images;
    return data;
  }
}
```

这个相对于以前其它Model文件简单很多。其实你完全可以手写练习一下。

### [#](https://jspang.com/posts/2019/03/01/flutter-shop.html#在provide里使用模型) 在provide里使用模型

有了模型文件之后，需要先引入`provide`里，然后进行改造。引入刚刚写好的模型层文件。

```text
import '../model/cartInfo.dart';
```

在`provide`类的最上部新声明一个List变量，这就是购物车页面用于显示的购物车列表了.

```dart
List<CartInfoMode> cartList=[];
```

然后改造save方法，让他支持模型类，但是要注意，原来的字符串不要改变，因为`shared_preferences`不持支对象的持久化。

```dart
  save(goodsId,goodsName,count,price,images) async{
    //初始化SharedPreferences
    SharedPreferences prefs = await  SharedPreferences.getInstance();
    cartString=prefs.getString('cartInfo');  //获取持久化存储的值
    //判断cartString是否为空，为空说明是第一次添加，或者被key被清除了。
    //如果有值进行decode操作
    var temp=cartString==null?[]:json.decode(cartString.toString());
    //把获得值转变成List
    List<Map> tempList= (temp as List).cast();
    //声明变量，用于判断购物车中是否已经存在此商品ID
    var isHave= false;  //默认为没有
    int ival=0; //用于进行循环的索引使用
    tempList.forEach((item){//进行循环，找出是否已经存在该商品
      //如果存在，数量进行+1操作
      if(item['goodsId']==goodsId){
        tempList[ival]['count']=item['count']+1;
         //关键代码-----------------start
        cartList[ival].count++;
         //关键代码-----------------end
        isHave=true;
      }
      ival++;
    });
    //  如果没有，进行增加
    if(!isHave){
       //关键代码-----------------start
          Map<String, dynamic> newGoods={
             'goodsId':goodsId,
            'goodsName':goodsName,
            'count':count,
            'price':price,
            'images':images
          };
          tempList.add(newGoods);
          cartList.add(new CartInfoMode.fromJson(newGoods));
       //关键代码-----------------end
    }
    //把字符串进行encode操作，
    cartString= json.encode(tempList).toString();
    print(cartString);
    print(cartList.toString());
    prefs.setString('cartInfo', cartString);//进行持久化
    notifyListeners();
  }
```

### [#](https://jspang.com/posts/2019/03/01/flutter-shop.html#得到购物车中商品方法) 得到购物车中商品方法

有了增加方法，我们还需要写一个得到购物车中的方法，现在就学习一下结合Model如何得到持久化的数据。

```dart
  //得到购物车中的商品
  getCartInfo() async {
     SharedPreferences prefs = await SharedPreferences.getInstance();
     //获得购物车中的商品,这时候是一个字符串
     cartString=prefs.getString('cartInfo'); 
     //把cartList进行初始化，防止数据混乱 
     cartList=[];
     //判断得到的字符串是否有值，如果不判断会报错
     if(cartString==null){
       cartList=[];
     }else{
       List<Map> tempList= (json.decode(cartString.toString()) as List).cast();
       tempList.forEach((item){
          cartList.add(new CartInfoMode.fromJson(item));
       });

     }
      notifyListeners();
  }
```

有了这个方法，下节课就可以开心的布局页面了，再也不用在终端里看结果了。

## [#](https://jspang.com/posts/2019/03/01/flutter-shop.html#第53节：购物车-大体结构布局) 第53节：购物车_大体结构布局

这节课终于可以不再忍受终端中查看结果的苦恼了，开始制作页面。其实在实际开发中也有很多这样的情况。就是先得到数据，再调试页面。



### [#](https://jspang.com/posts/2019/03/01/flutter-shop.html#页面基本结构搭建) 页面基本结构搭建

`cart_page.dart`先建立页面的基本接口，还是使用脚手架组件`Scaffold`来进行操作。代码如下：

```dart
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:provide/provide.dart';
import '../provide/cart.dart';


class CartPage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('购物车'),
      ),
      body:Text('测试')
    );
  }
}
```

再body区域我们使用`Future Widget`，因为就算是本地持久化，还是有一个时间的，当然这个时间可能你肉眼看不见。不过这样控制台可能会把错误信息返回回来。

```dart
  body: FutureBuilder(
    future:_getCartInfo(context),
    builder: (context,snapshot){
      List cartList=Provide.value<CartProvide>(context).cartList;
      if(snapshot.hasData){
       
      }else{
        return Text('正在加载');
      }
    },
  ),
  );
  }
```

### [#](https://jspang.com/posts/2019/03/01/flutter-shop.html#future方法编写) Future方法编写

使用了`Future`组件，自然需要一个返回Future的方法了，在这个方法里，我们使用`Provide`取出本地持久化的数据，然后进行变化。

```dart
  Future<String> _getCartInfo(BuildContext context) async{
     await Provide.value<CartProvide>(context).getCartInfo();
     return 'end';
  }
```

### [#](https://jspang.com/posts/2019/03/01/flutter-shop.html#用listview简单输出) 用ListView简单输出

```dart
return ListView.builder(
  itemCount: cartList.length,
  itemBuilder: (context,index){
    return ListTile(
      title:Text(cartList[index].goodsName)
    );
  },
);
```

到这步后，就可以简单的进行预览，当然页面还是很丑的，下节课会继续进行美化。会把列表的子项单独拿出一个文件，这样会降低以后的维护成本。

## [#](https://jspang.com/posts/2019/03/01/flutter-shop.html#第54节：购物车-商品列表子项组件编写) 第54节：购物车_商品列表子项组件编写

上节课已经把购物车页面的大体结构编写好，并且也可以获得购物车中的商品列表信息了，但是页面依然丑陋，这节课继续上节课完成子项的UI美化.

### [#](https://jspang.com/posts/2019/03/01/flutter-shop.html#编写购物车单项方法) 编写购物车单项方法

为了以后维护方便，我们还是采用单独编写的方式，把购物车里边的每一个子项统一作一个组件出来。

现在`lib\pages`下建立一个新文件夹`cart_page`，然后在新文件夹下面家里一个`cart_item.dart`文件。先引入几个必要的文件.

```text
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../model/cartInfo.dart';
```

然后声明一个stateLessWidget 类，名字叫`CartItem`并设置接收参数，这里的接收参数就是`cartInfo`对象，也就是每个购物车商品的子项。代码如下:

```dart
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../model/cartInfo.dart';

class CartItem extends StatelessWidget {
  final CartInfoMode item;
  CartItem(this.item);

  @override
  Widget build(BuildContext context) {
    print(item);
    return Container(
        margin: EdgeInsets.fromLTRB(5.0,2.0,5.0,2.0),
        padding: EdgeInsets.fromLTRB(5.0,10.0,5.0,10.0),
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border(
            bottom: BorderSide(width:1,color:Colors.black12)
          )
        ),
        child: Row(
          children: <Widget>[
          
          ],
        ),
      );
  }



}
```

### [#](https://jspang.com/posts/2019/03/01/flutter-shop.html#编写多选按钮方法) 编写多选按钮方法

```dart
//多选按钮
  Widget _cartCheckBt(item){
    return Container(
      child: Checkbox(
        value: true,
        activeColor:Colors.pink,
        onChanged: (bool val){},
      ),
    );
  }
```

### [#](https://jspang.com/posts/2019/03/01/flutter-shop.html#编写商品图片方法) 编写商品图片方法

```dart
//商品图片 
  Widget _cartImage(item){
    
    return Container(
      width: ScreenUtil().setWidth(150),
      padding: EdgeInsets.all(3.0),
      decoration: BoxDecoration(
        border: Border.all(width: 1,color:Colors.black12)
      ),
      child: Image.network(item.images),
    );
  }
```

### [#](https://jspang.com/posts/2019/03/01/flutter-shop.html#编写商品名称方法) 编写商品名称方法

```dart
//商品名称
  Widget _cartGoodsName(item){
    return Container(
      width: ScreenUtil().setWidth(300),
      padding: EdgeInsets.all(10),
      alignment: Alignment.topLeft,
      child: Column(
        children: <Widget>[
          Text(item.goodsName)
        ],
      ),
    );
  }
```

### [#](https://jspang.com/posts/2019/03/01/flutter-shop.html#编写商品价格方法) 编写商品价格方法

```dart
//商品价格
  Widget _cartPrice(item){

    return Container(
        width:ScreenUtil().setWidth(150) ,
        alignment: Alignment.centerRight,
        
        child: Column(
          children: <Widget>[
            Text('￥${item.price}'),
            Container(
              child: InkWell(
                onTap: (){},
                child: Icon(
                  Icons.delete_forever,
                  color: Colors.black26,
                  size: 30,
                ),
              ),
            )
          ],
        ),
      );
  }
```

### [#](https://jspang.com/posts/2019/03/01/flutter-shop.html#进行整合) 进行整合

这些组件写好以后，我们可以进行一个整合。

```dart
child: Row(
  children: <Widget>[
    _cartCheckBt(item),
    _cartImage(item),
    _cartGoodsName(item),
    _cartPrice(item)
  ],
),
```

为了方便学习，全部代码如下：

```dart
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../model/cartInfo.dart';

class CartItem extends StatelessWidget {
  final CartInfoMode item;
  CartItem(this.item);

  @override
  Widget build(BuildContext context) {
    print(item);
    return Container(
        margin: EdgeInsets.fromLTRB(5.0,2.0,5.0,2.0),
        padding: EdgeInsets.fromLTRB(5.0,10.0,5.0,10.0),
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border(
            bottom: BorderSide(width:1,color:Colors.black12)
          )
        ),
        child: Row(
          children: <Widget>[
            _cartCheckBt(item),
            _cartImage(item),
            _cartGoodsName(item),
            _cartPrice(item)
          ],
        ),
      );
  }
  //多选按钮
  Widget _cartCheckBt(item){
    return Container(
      child: Checkbox(
        value: true,
        activeColor:Colors.pink,
        onChanged: (bool val){},
      ),
    );
  }
  //商品图片 
  Widget _cartImage(item){
    
    return Container(
      width: ScreenUtil().setWidth(150),
      padding: EdgeInsets.all(3.0),
      decoration: BoxDecoration(
        border: Border.all(width: 1,color:Colors.black12)
      ),
      child: Image.network(item.images),
    );
  }
  //商品名称
  Widget _cartGoodsName(item){
    return Container(
      width: ScreenUtil().setWidth(300),
      padding: EdgeInsets.all(10),
      alignment: Alignment.topLeft,
      child: Column(
        children: <Widget>[
          Text(item.goodsName)
        ],
      ),
    );
  }

  //商品价格
  Widget _cartPrice(item){

    return Container(
        width:ScreenUtil().setWidth(150) ,
        alignment: Alignment.centerRight,
        
        child: Column(
          children: <Widget>[
            Text('￥${item.price}'),
            Container(
              child: InkWell(
                onTap: (){},
                child: Icon(
                  Icons.delete_forever,
                  color: Colors.black26,
                  size: 30,
                ),
              ),
            )
          ],
        ),
      );
  }

}
```

## [#](https://jspang.com/posts/2019/03/01/flutter-shop.html#第55节-购物车-制作底部结算栏的ui) 第55节:购物车_制作底部结算栏的UI

这节课主要布局一下底部操作栏。这个使用了`Stack Widget`，由于以前视频中学过，所以做起来也就没那么难了，但是还是有很多样式需要我们书写，以保证完成一个美观的购物车页面的。

###  建立底部结算栏页面

在`lib/pages/cart_page`文件夹下，新建一个`cart_bottom.dart`文件。文件建立好以后，先引入下面的基础`package`。

```text
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
```

引入完成后，用快捷的方式建立一个`StatelessWidget`，建立后，我们使用`Row`来进行总体布局，并给`Container`一些必要的修饰.代码如下:

```dart
class CartBottom extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(5.0),
      color: Colors.white,
      width: ScreenUtil().setWidth(750),
      child: Row(
        children: <Widget>[
        
        ],
      ),
    );
  }
}
```

这就完成了一个底部结算栏的大体结构确定，大体结构完成后，我们还是把里边的细节，拆分成不同的方法返回对象的组件。

### [#](https://jspang.com/posts/2019/03/01/flutter-shop.html#全选按钮方法) 全选按钮方法

先来制作全选按钮方法，这个外边采用`Container`，里边使用了一个Row，这样能很好的完成横向布局的需求.

```dart
  //全选按钮
  Widget selectAllBtn(){
    return Container(
      child: Row(
        children: <Widget>[
          Checkbox(
            value: true,
            activeColor: Colors.pink,
            onChanged: (bool val){},
          ),
          Text('全选')
        ],
      ),
    );
  }
```

### [#](https://jspang.com/posts/2019/03/01/flutter-shop.html#合计区域方法) 合计区域方法

合计区域由于布局对齐方式比较复杂，所以这段代码虽然很简单，但是代码设计的样式比较多，需要你有很好的样式编写能力.代码如下：

```dart
  // 合计区域
  Widget allPriceArea(){

    return Container(
      width: ScreenUtil().setWidth(430),
      alignment: Alignment.centerRight,
      child: Column(
        children: <Widget>[
          Row(
            children: <Widget>[
              Container(
                alignment: Alignment.centerRight,
                width: ScreenUtil().setWidth(280),
                child: Text(
                  '合计:',
                  style:TextStyle(
                    fontSize: ScreenUtil().setSp(36)
                  )
                ), 
              ),
              Container(
                 alignment: Alignment.centerLeft,
                width: ScreenUtil().setWidth(150),
                child: Text(
                  '￥1922',
                  style:TextStyle(
                    fontSize: ScreenUtil().setSp(36),
                    color: Colors.red,
                  )
                ),
                
              )
             
              
            ],
          ),
          Container(
            width: ScreenUtil().setWidth(430),
            alignment: Alignment.centerRight,
            child: Text(
              '满10元免配送费，预购免配送费',
              style: TextStyle(
                color: Colors.black38,
                fontSize: ScreenUtil().setSp(22)
              ),
            ),
          )
          
        ],
      ),
    );

  }
```

### [#](https://jspang.com/posts/2019/03/01/flutter-shop.html#结算按钮方法) 结算按钮方法

这个方法里边的按钮，我们并没有使用`Flutter Button Widget` 而是使用`InkWell`自己制作一个组件。这样作能很好的控制按钮的形状，还可以解决水波纹的问题，一举两得。代码如下:

```dart
//结算按钮
  Widget goButton(){
    
    return Container(
      width: ScreenUtil().setWidth(160),
      padding: EdgeInsets.only(left: 10),
      child:InkWell(
        onTap: (){},
        child: Container(
          padding: EdgeInsets.all(10.0),
          alignment: Alignment.center,
          decoration: BoxDecoration(
             color: Colors.red,
             borderRadius: BorderRadius.circular(3.0)
          ),
          child: Text(
            '结算(6)',
            style: TextStyle(
              color: Colors.white
            ),
          ),
        ),
      ) ,
    );
    
    
  }
```

### [#](https://jspang.com/posts/2019/03/01/flutter-shop.html#加入到页面中-2) 加入到页面中

组件样式基本都各自完成后，接下来就是组合和加入到页面中了，我们先把个个方法组合到底部结算区域,也就是放到`build`方法里。

```dart
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(5.0),
      color: Colors.white,
      width: ScreenUtil().setWidth(750),
      child: Row(
        children: <Widget>[
          selectAllBtn(),
          allPriceArea(),
          goButton()
        ],
      ),
    );
  }
```

这步完成后就是到`lib/pages/cart_page.dart`文件中，加入底部结算栏的操作了，这里我们需要使用`Stack Widget`组件。

首先需要引入`cart_bottom.dart`。

```text
import './cart_page/cart_bottom.dart';
```

然后改写`FutureBuilder Widget`里边的`builder`方法，这时候返回的是一个`Stack Widget`。代码如下：

```diff
import 'package:flutter/material.dart';
import 'package:provide/provide.dart';
import '../provide/cart.dart';
import './cart_page/cart_item.dart';
import './cart_page/cart_bottom.dart';



class CartPage extends StatelessWidget {
  	 @override
     Widget build(BuildContext context) {
     _show();  //每次进入前进行显示
     return Scaffold(
       appBar: AppBar(
         title: Text('购物车'),
       ),
       body:FutureBuilder(
         future: _getCartInfo(context),
         builder: (context, snapshot) {
           List cartList = Provide.value<CartProvide>(context).cartList;
-          if (snapshot.hasData) {
-            return ListView.builder(
-              itemCount: cartList.length,
-              itemBuilder: (context, index) {
-                return ListTile(
-                  title: Text(cartList[index].goodsName),
-                );
-              },
+          if (snapshot.hasData && cartList != null) {
+            return Stack(
+              children: <Widget>[
+                ListView.builder(
+                  itemCount: cartList.length,
+                  itemBuilder: (context, index) {
+                    return CartItem(cartList[index]);
+                  },
+                ),
+                Positioned(
+                  bottom: 0,
+                  left: 0,
+                  child: CartBottom(),
+                ),
+              ],
             );
           } else {
             return Text('正在加载');
           }
         },
       ),
     );
   }


  Future<String> _getCartInfo(BuildContext context) async{
     await Provide.value<CartProvide>(context).getCartInfo();
     return 'end';
  }

  
}
```

这步做完之后，就可以进行预览了。相信小伙伴们都可以得到满意的效果，其实学到这里，你应该有自己布局任何页面的能力，你可以试着把这个页面布局成自己想要的样子。下节课制作我们的数量加减组件。

## [#](https://jspang.com/posts/2019/03/01/flutter-shop.html#第56节：购物车-制作数量加减按钮ui) 第56节：购物车_制作数量加减按钮UI

购物车的UI界面已经基本完成了，只差最后一个数量加载的部分没有进行布局，这节课就用几分钟时间，把这个部分的布局制作完成。

###  建立组件和基本结构

在`lib/pages/cart_page/`文件夹下，建立一个新的文件`cart_count.dart`。先引入两个布局使用的基本文件。

```text
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
```

然后开始写基本结构，我们这里使用`Container`和`Row`的形式。

```dart
  Widget build(BuildContext context) {
    return Container(
      width: ScreenUtil().setWidth(165),
      margin: EdgeInsets.only(top:5.0),
      decoration: BoxDecoration(
        border:Border.all(width: 1 , color:Colors.black12)
      ),
      child: Row(
        children: <Widget>[
        ],
      ),
      
    );
  }
```

写完这个，我们再把`Row`里边的每个子元素进行拆分.

### [#](https://jspang.com/posts/2019/03/01/flutter-shop.html#减少按钮ui编写) 减少按钮UI编写

```dart
  // 减少按钮
  Widget _reduceBtn(){
    return InkWell(
      onTap: (){},
      child: Container(
        width: ScreenUtil().setWidth(45),
        height: ScreenUtil().setHeight(45),
        alignment: Alignment.center,
       
        decoration: BoxDecoration(
          color: Colors.white,
          border:Border(
            right:BorderSide(width:1,color:Colors.black12)
          )
        ),
        child: Text('-'),
      ),
    );
  }
```

### [#](https://jspang.com/posts/2019/03/01/flutter-shop.html#添加按钮ui编写) 添加按钮UI编写

```dart
  //添加按钮
  Widget _addBtn(){
    return InkWell(
      onTap: (){},
      child: Container(
        width: ScreenUtil().setWidth(45),
        height: ScreenUtil().setHeight(45),
        alignment: Alignment.center,
       
         decoration: BoxDecoration(
          color: Colors.white,
          border:Border(
            left:BorderSide(width:1,color:Colors.black12)
          )
        ),
        child: Text('+'),
      ),
    );
  }
```

### [#](https://jspang.com/posts/2019/03/01/flutter-shop.html#数量区域ui编写) 数量区域UI编写

```dart
  //中间数量显示区域
  Widget _countArea(){
    return Container(
      width: ScreenUtil().setWidth(70),
      height: ScreenUtil().setHeight(45),
      alignment: Alignment.center,
      color: Colors.white,
       child: Text('1'),
    );
  }
```

### [#](https://jspang.com/posts/2019/03/01/flutter-shop.html#进行组合) 进行组合

组件都写好后，要进行组合和加入到页面中的操作。

组合：直接在build区域的`Row`数组中进行组合。

```diff
  Widget build(BuildContext context) {
    return Container(
      width: ScreenUtil().setWidth(165),
      margin: EdgeInsets.only(top:5.0),
      decoration: BoxDecoration(
        border:Border.all(width: 1 , color:Colors.black12)
      ),
      children: <Widget>[
-
+          selectAllBtn(),
+          allPriceArea(),
+          goButton(),
      ],

      ),
      
    );
  }
```

这个不完成后，再到同级目录下的`cart_item.dart`，引入和使用。先进行文件的引入.

```text
import './cart_count.dart';
```

引入后，再商品名称的方法中直接引入就。

```diff
 //商品名称
  Widget _cartGoodsName(item){
    return Container(
      width: ScreenUtil().setWidth(300),
      padding: EdgeInsets.all(10),
      alignment: Alignment.topLeft,
      child: Column(
            children: <Widget>[
            Text(item.goodsName),
+            CartCount()
          ],
      ),
    );
  }
```

完成后就可以进行预览了。通过几节课的制作，终于算是完成了购物车UI界面的编写。下节课开始编写购物车的业务逻辑。

## [#](https://jspang.com/posts/2019/03/01/flutter-shop.html#第57节：购物车-在model中增加选中字段) 第57节：购物车_在Model中增加选中字段

通过布局，我们可以看到是有选中和多选操作的，但是在设计购物车模型时并没有涉及这个操作，所以这节课利用几分钟时间，把坑填补一下。



###  修改Model文件

首先我们打开`lib/model/cartInfo.dart`文件，增加一个新的变量`isCheck`。

```diff
 class CartInfoMode {
   String goodsId;
   String goodsName;
   int count;
   double price;
   String images;
+  bool isCheck;
 
-  CartInfoMode({this.goodsId, this.goodsName, this.count, this.price, this.images});
+  CartInfoMode({this.goodsId, this.goodsName, this.count, this.price, this.images, this.isCheck});
 
   CartInfoMode.fromJson(Map<String, dynamic> json) {
     goodsId = json['goodsId'];
     goodsName = json['goodsName'];
     count = json['count'];
     price = json['price'];
     images = json['images'];
+    isCheck = json['isCheck'];
   }
 
   Map<String, dynamic> toJson() {
     final Map<String, dynamic> data = new Map<String, dynamic>();
     data['goodsId'] = this.goodsId;
     data['goodsName'] = this.goodsName;
     data['count'] = this.count;
     data['price'] = this.price;
     data['images'] = this.images;
+    data['isCheck'] = this.isCheck;
     return data;
   }
 }

```

### [#](https://jspang.com/posts/2019/03/01/flutter-shop.html#在增加时加入ischeck) 在增加时加入isCheck

打开`lib/provide/cart.dart`文件，找到添加购物车商品的方法`save`,修改增加的部分代码。

```diff
      Map<String, dynamic> newGoods = {
        'goodsId': goodsId,
        'goodsName': goodsName,
        'count': count,
        'price': price,
        'images': images,
+        'isCheck': true   ///是否已经选择
      };
```

### [#](https://jspang.com/posts/2019/03/01/flutter-shop.html#修改ui的值) 修改UI的值

之前UI中多选按钮的值，我们是写死的，现在就可以使用这个动态的值了。打开`lib/pages/cart_page/cart_item.dart`文件，找到多选按钮的部分，修改val的值.

```diff
   @override
   Widget build(BuildContext context) {
     return Container(
         margin: EdgeInsets.fromLTRB(5.0, 2.0, 5.0, 2.0),
         padding: EdgeInsets.fromLTRB(5.0, 10.0, 5.0, 10.0),
         decoration: BoxDecoration(
           color: Colors.white,
           border: Border(
             bottom: BorderSide(width: 1, color: Colors.black12)
           )
         ),
         child: Row(
           children: <Widget>[
-            _cartCheckBt(item),
+            _cartCheckBt(context, item),
             _cartImage(item),
             _cartGoodsName(item),
             _cartPrice(item),
           ],
         ),
     );
   }
 
   //多选按钮
-  Widget _cartCheckBt(item) {
+  Widget _cartCheckBt(context, item) {
     return Container(
       child: Checkbox(
-        value: true,
+        value: item.isCheck,
         activeColor: Colors.pink,
         onChanged: (bool val){ 
 
         },
       ),
     );
   }

```

记得修改完成后，要把原来的持久化字符串删除掉，删除掉后再次填入新的商品到购物车，就可以正常显示了。

## [#](https://jspang.com/posts/2019/03/01/flutter-shop.html#第58节：购物车-删除单个商品功能制作) 第58节：购物车_删除单个商品功能制作

页面终于制作完成了，剩下来就是逐步完善购物车中的各项功能，这部分的视频可能拆分的比较细致。这节课主要讲一下如何实现购物车中的删除功能。

###  编写删除方法

直接在`provide`中的`cart.dart`文件里，增加一个`deleteOneGoods`方法。编写思路是这样的，先从持久化数据里得到数据，然后把纯字符串转换成字List，转换之后进行循环，如果goodsId，相同，说明就是要删除的项，把索引进行记录，记录之后用`removeAt`方法进行删除，删除后再次进行持久化，并重新获得数据。 主要代码如下：

```dart
  //删除单个购物车商品
  deleteOneGoods(String goodsId) async{
     SharedPreferences prefs = await SharedPreferences.getInstance();
     cartString=prefs.getString('cartInfo'); 
     List<Map> tempList= (json.decode(cartString.toString()) as List).cast();
   
     int tempIndex =0;
     int delIndex=0;
     tempList.forEach((item){
         
         if(item['goodsId']==goodsId){
          delIndex=tempIndex;
        
         }
         tempIndex++;
     });
      tempList.removeAt(delIndex);
      cartString= json.encode(tempList).toString();
      prefs.setString('cartInfo', cartString);//
      await getCartInfo();
     

  }
```

这个部分需要注意的是，为什么循环时不进行删除，因为dart语言不支持迭代时进行修改，这样可以保证在循环时不出错。

### [#](https://jspang.com/posts/2019/03/01/flutter-shop.html#修改ui界面，实现效果) 修改UI界面，实现效果

UI界面主要时增加Proivde组件，就是当值法伤变化时，界面也随着变化。打开`cart_page.dart`文件，主要修改build里的ListView区域，代码如下：

```diff
import 'package:flutter/material.dart';
import 'package:provide/provide.dart';
import '../provide/cart.dart';
import './cart_page/cart_item.dart';
import './cart_page/cart_bottom.dart';




class CartPage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('购物车'),
      ),
      body: FutureBuilder(
        future:_getCartInfo(context),
        builder: (context,snapshot){
          List cartList=Provide.value<CartProvide>(context).cartList;
          if(snapshot.hasData && cartList!=null){
             return Stack(
               children: <Widget>[
-                ListView.builder(
-                  itemCount: cartList.length,
-                  itemBuilder: (context, index) {
-                    return CartItem(cartList[index]);
+                Provide<CartProvide>(
+                  builder: (context, child, childCategory){
+                    cartList = Provide.value<CartProvide>(context).cartList;
+                    print(cartList);
+                    return ListView.builder(
+                      itemCount: cartList.length,
+                      itemBuilder: (context, index) {
+                        return CartItem(cartList[index]);
+                      },
+                    );
                   },
                 ),
                 Positioned(
                   bottom: 0,
                   left: 0,
                   child: CartBottom(),
                 ),
               ],
             );

          }else{
            return Text('正在加载');
          }
        },
      ),
    );
  }

  Future<String> _getCartInfo(BuildContext context) async{
     await Provide.value<CartProvide>(context).getCartInfo();
     return 'end';
  }

  
}
```

### [#](https://jspang.com/posts/2019/03/01/flutter-shop.html#增加删除响应事件) 增加删除响应事件

在`cart_item.dart`文件中，增加删除响应事件，由于所有业务逻辑都在Provide中，所以需要引入下面两个文件。

```text
import 'package:provide/provide.dart';
import '../../provide/cart.dart';
```

有了这两个文件后，可以修改对应的方法`_cartPrice`。首先要加入context选项，然后修改里边的`onTap`方法。具体代码如下:

```diff
     //商品价格
-  Widget _cartPrice(item) {
+  Widget _cartPrice(context, item) {
     return Container(
       width: ScreenUtil().setWidth(150),
       alignment: Alignment.centerRight,
 
       child: Column(
         children: <Widget>[
           Text('￥${item.price}'),
           Container(
             child: InkWell(
-              onTap: (){},
+              onTap: (){
+                Provide.value<CartProvide>(context).deleteOneGoods(item.goodsId);
+              },
               child: Icon(
                 Icons.delete_forever,
                 color: Colors.black26,
                 size: 30,
               ),
             ),
           )
         ],
       ),
     );
   }

```

这步做完，已经有了删除功能，可以进行测试了.

## [#](https://jspang.com/posts/2019/03/01/flutter-shop.html#第59节：购物车-计算商品价格和数量) 第59节：购物车_计算商品价格和数量

购物车中都有自动计算商品价格和商品数量的功能，这节课我们就把这两个小功能实现一下。

###  增加Provide变量

在`lib/provide/cart.dart`文件的类头部，增加总价格`allPrice`和总商品数量`allGoodsCount`两个变量.

```diff
class CartProvide with ChangeNotifier {
  List<CartInfoMode> cartList = [];
  String cartString ="[]";

+  double allPrice = 0;    //总价格
+  int allGoodsCount = 0;  //商品总数量
+
  //添加商品到购物车
//... ...
```

### [#](https://jspang.com/posts/2019/03/01/flutter-shop.html#修改getcartinfo（）方法) 修改`getCartInfo（）`方法

主要是在循环是累计增加数量和价格，这里给出全部增加的代码，并标注了修改部分。

```diff
  getCartInfo() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    //获得购物车中的商品,这时候是一个字符串
    cartString = prefs.getString('cartInfo');
    //把cartList进行初始化，防止数据混乱 
    cartList = [];
    //判断得到的字符串是否有值，如果不判断会报错
    if (cartString == null) {
      cartList = [];
    } else {
      List<Map> tempList = (json.decode(cartString.toString()) as List).cast();
+
+      allPrice = 0;
+      allGoodsCount = 0;

      tempList.forEach((item){
+        if (item['isCheck']) {
+          allPrice += (item['count'] * item['price']);
+          allGoodsCount += item['count'];
+        }
        
        cartList.add(new CartInfoMode.fromJson(item));
      });
    }
    notifyListeners();
  }

```

### [#](https://jspang.com/posts/2019/03/01/flutter-shop.html#修改ui界面-显示结果) 修改UI界面 显示结果

有了业务逻辑，就应该可以正常的显示出界面效果了。但是需要把原来我们写死的值，都改成动态的。

打开`lib/pages/cart_page/cart_bottom.dart`文件，先用`import`引入`provide package`

```text
import 'package:provide/provide.dart';
import '../../provide/cart.dart';
```

然后把底部的三个区域方法都加上`context`上下文参数,因为`Provide`的使用，必须有上下文参数。

```diff
     @override
   Widget build(BuildContext context) {
     return Container(
       margin: EdgeInsets.all(5.0),
       color: Colors.white,
       width: ScreenUtil().setWidth(750),
       child: Row(
         children: <Widget>[
           selectAllBtn(),
-          allPriceArea(),
-          goButton(),
+          allPriceArea(context),
+          goButton(context),
         ],
       ),
     );
   }

```

然后在两个方法中都从`Provide`里动态获取变量，就可以实现效果了。

合计区域的方法代码：

```diff
     //合计区域
-  Widget allPriceArea() {
+  Widget allPriceArea(context) {
+
+    double allPrice = Provide.value<CartProvide>(context).allPrice;
+
     return Container(
       width: ScreenUtil().setWidth(430),
       alignment: Alignment.centerRight,
       child: Column(
         children: <Widget>[
           Row(
             children: <Widget>[
               Container(
                 alignment: Alignment.centerRight,
                 width: ScreenUtil().setWidth(280),
                 child: Text(
                   '合计：',
                   style: TextStyle(
                     fontSize: ScreenUtil().setSp(36)
                   ),
                 ),
               ),
               Container(
                 alignment: Alignment.centerLeft,
                 width: ScreenUtil().setWidth(150),
                 child: Text(
-                  '￥1922',
+                  '￥${allPrice}',
                   style: TextStyle(
                     fontSize: ScreenUtil().setSp(36),
                     color: Colors.red,
                   ),
                 ),
               ),
             ],
           ),
           Container(
             width: ScreenUtil().setWidth(430),
             alignment: Alignment.centerRight,
             child: Text(
               '满10元免配送费，预购免配送费',
               style: TextStyle(
                 color: Colors.black38,
                 fontSize: ScreenUtil().setSp(22),
               ),
             ),
           ),
         ],
       ),
     );
   }

```

结算按钮区域

```diff
   //结算按钮
-  Widget goButton() {
+  Widget goButton(context) {
+
+    int allGoodsCount = Provide.value<CartProvide>(context).allGoodsCount;
+
     return Container(
       width: ScreenUtil().setWidth(160),
       padding: EdgeInsets.only(left: 10),
       child: InkWell(
         onTap: (){},
         child: Container(
           padding: EdgeInsets.all(10.0),
           alignment: Alignment.center,
           decoration: BoxDecoration(
             color: Colors.red,
             borderRadius: BorderRadius.circular(3.0)
           ),
           child: Text(
-            '结算(6)',
+            '结算(${allGoodsCount})',
             style: TextStyle(
               color: Colors.white,
             ),
           ),
         ),
       ),
     );
   }
```

这步完成后，就应该可以正常动态显示购物车中的商品数量和商品价格了。

