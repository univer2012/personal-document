import 'package:flutter/material.dart';

class BesselCurveDemo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:Column(
        children: <Widget>[
          ClipPath(
            //clipper:BottomClipperTest(),  //贝塞尔曲线切割
            clipper: BottomClipper(), //波浪形式的贝塞尔曲线
            child: Container(
              //color:Colors.deepPurpleAccent,
              color: Colors.lightBlueAccent,
              height: 200.0,
            ),
          )
        ],
      )
    );
  }
}


//波浪形式的贝塞尔曲线
class BottomClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = Path();
    path.lineTo(0, size.height - 20);
    var firstControlPoint = Offset(size.width / 4, size.height);//第一个控制点
    var firstEndPoint = Offset(size.width / 2.25, size.height - 30);//第一个结束点

    path.quadraticBezierTo(firstControlPoint.dx, firstControlPoint.dy, firstEndPoint.dx, firstEndPoint.dy);

    var secondControlPoint = Offset(size.width / 4 * 3 , size.height - 80);//第二个控制点
    var secondEndPoint = Offset(size.width, size.height - 40);//第二个结束点

    path.quadraticBezierTo(secondControlPoint.dx, secondControlPoint.dy, secondEndPoint.dx, secondEndPoint.dy);

    path.lineTo(size.width, size.height - 40);
    path.lineTo(size.width, 0);

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return false;
  }
}

//贝塞尔曲线切割
class BottomClipperTest extends CustomClipper<Path>{
  @override
    Path getClip(Size size) {
      // TODO: implement getClip
      var path = Path();
      path.lineTo(0, 0);
      path.lineTo(0, size.height-30);
      print('size_height:${size.height}'); //这个size.height就是ClipPath.height = 200.0
      var firstControlPoint =Offset(size.width/2,size.height); //第一个控制点:在中间
      var firstEndPoint = Offset(size.width,size.height-30); //第一个结束点

      path.quadraticBezierTo(firstControlPoint.dx, firstControlPoint.dy, firstEndPoint.dx, firstEndPoint.dy);

      path.lineTo(size.width, size.height-30);
      path.lineTo(size.width, 0);
    
      return path;

    }
    @override
      bool shouldReclip(CustomClipper<Path> oldClipper) {
        // TODO: implement shouldReclip
        return false;
      }

}