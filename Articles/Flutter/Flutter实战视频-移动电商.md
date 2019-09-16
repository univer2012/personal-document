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

