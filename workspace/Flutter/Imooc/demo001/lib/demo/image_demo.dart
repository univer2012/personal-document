import 'package:flutter/material.dart';

class ImagePage extends StatelessWidget {
  const ImagePage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios), 
          onPressed: (){
            Navigator.pop(context);
        }),
        title: Text('Image'),
      ),
      body: Center(
        child: Container(
          child: new Image.network(
            'http://image.huahuibk.com/uploads/20190222/23/1550850387-MFLyASvKBD.jpg',
            scale: 1.0,
            fit: BoxFit.scaleDown,
            repeat: ImageRepeat.repeat,
            width: 50,
            height: 40,
            //图片的混合模式：(要color和colorBlendMode结合使用)
            color: Colors.greenAccent,
            colorBlendMode: BlendMode.darken,
          ),
          width: 350.0,
          height: 500.0,
          color: Colors.lightBlue,
        ),
      ),
    );
  }
}