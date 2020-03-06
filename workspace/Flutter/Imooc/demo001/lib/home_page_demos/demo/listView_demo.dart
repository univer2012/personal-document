import 'package:flutter/material.dart';

class ListViewPage extends StatefulWidget {
  ListViewPage({Key key}) : super(key: key);

  @override
  _ListViewPageState createState() => _ListViewPageState();
}

class _ListViewPageState extends State<ListViewPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
       appBar: AppBar(
         leading: IconButton(icon: Icon(Icons.arrow_back_ios), onPressed: (){
           Navigator.pop(context);
         }),
         title: Text('ListView'),
       ),
      body: Center(
        child: Container(
          height: 200.0,
          child: MyList(),
        ),
      ),



      //========= demo2 start
      //  body: new ListView(
      //    children: <Widget>[
      //      new Image.network(
      //        'https://ss1.bdstatic.com/70cFuXSh_Q1YnxGkpoWK1HF6hhy/it/u=3486575109,25094756&fm=26&gp=0.jpg'
      //      ),
      //      new Image.network(
      //        'https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1582279056325&di=681f8aabcf464a1577eb3b41a983e785&imgtype=0&src=http%3A%2F%2Fimage.biaobaiju.com%2Fuploads%2F20190807%2F13%2F1565156399-SGrnbwhBjR.jpg'
      //      ),
      //      new Image.network(
      //        'https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1582279056324&di=d67715980e5ab50e6beb9d96eca839e8&imgtype=0&src=http%3A%2F%2Fimage.biaobaiju.com%2Fuploads%2F20190508%2F17%2F1557307364-SJENtIuizm.jpg'
      //      ),
      //      new Image.network(
      //        'https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1582279087969&di=515895907abb3ab1d6488f06252f1a98&imgtype=jpg&src=http%3A%2F%2Fimg0.imgtn.bdimg.com%2Fit%2Fu%3D3016471395%2C869812649%26fm%3D214%26gp%3D0.jpg'
      //      ),
      //    ],
      //  ),
      //========= demo2 end




      //========= demo1 start
      //  body: ListView(
      //    children: <Widget>[
      //      Container(
      //       child: new ListTile(
      //         leading: Icon(Icons.access_time),
      //         title: new Text('access_time',style: TextStyle(color: Colors.blueAccent),),
      //       ),
      //       color: Colors.red,
      //      ),
      //      new ListTile(
      //        leading: Icon(Icons.account_balance),
      //        title: new Text('account_balance'),
      //      ),
      //    ],
      //  ),
      //========= demo1 end
    );
  }
}



class MyList extends StatelessWidget {
  const MyList({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return new ListView(
      scrollDirection: Axis.horizontal,
      children: <Widget>[
        new Container(
          width: 80.0,
          color: Colors.lightBlue,
        ),
        new Container(
          width: 80.0,
          color: Colors.amber,
        ),
        new Container(
          width: 80.0,
          color: Colors.deepOrange,
        ),
        new Container(
          width: 80.0,
          color: Colors.deepPurpleAccent,
        ),
      ],
    );
  }
}