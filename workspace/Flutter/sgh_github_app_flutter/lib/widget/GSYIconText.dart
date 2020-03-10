import 'package:flutter/material.dart';

/**
 * Created by sengoln huang
 * Date: 2020-03-10
 */
class GSYIconText extends StatelessWidget {
  final String iconText;

  final IconData iconData;

  final TextStyle textStyle;

  final Color iconColor;

  final double padding;

  final double iconSize;

  const GSYIconText(this.iconData, this.iconText, this.textStyle, this.iconColor, this.iconSize, {this.padding = 0.0});

  @override
  Widget build(BuildContext context) {
    return new Row(
      children: <Widget>[
        new Icon(
          iconData,
          size: iconSize,
          color: iconColor,
        ),
        new Padding(padding: new EdgeInsets.all(padding)),
        new Text(
          iconText,
          style: textStyle,
        ),
      ],
    );
  }
}