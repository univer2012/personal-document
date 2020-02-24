import 'package:flutter/material.dart';

class DynamicListViewPage extends StatelessWidget {

  final List<String> items;
  const DynamicListViewPage({Key key, @required this.items}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(icon: Icon(Icons.arrow_back_ios), onPressed: (){
          Navigator.pop(context);
        }),
        title: Text('动态ListView'),
      ),
      body: new ListView.builder(
        itemCount: items.length,
        itemBuilder: (context, index){
          return new ListTile(
            title: new Text('${items[index]}'),
          );
      }),
    );
  }
}