import 'package:flutter/material.dart';

void main()=> runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '电影海报实例',
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
    );
  }
}