import 'package:flutter/material.dart';

class ContainerPage extends StatefulWidget {
  ContainerPage({Key key}) : super(key: key);

  @override
  _ContainerPageState createState() => _ContainerPageState();
}

class _ContainerPageState extends State<ContainerPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios),
          onPressed: (){
            Navigator.pop(context);
          },
        ),
        title: Text('Container'),
      ),
       body: Center(
         child: Container(
           child: new Text('Hello JSPang', style: TextStyle(fontSize: 40.0),),
           alignment: Alignment.center,
           width: 500.0,
           height: 400.0,
           //color: Colors.lightBlue,
           padding: const EdgeInsets.fromLTRB(10.0, 30.0, 0.0, 0.0),
           margin: const EdgeInsets.all(10.0),
           decoration: new BoxDecoration(
             gradient: const LinearGradient(
               colors: [Colors.lightBlue,Colors.greenAccent,Colors.purple]
              ),
              border: Border.all(width: 2.0, color: Colors.red),
           ),
           
         ),
       ),
    );
  }
}