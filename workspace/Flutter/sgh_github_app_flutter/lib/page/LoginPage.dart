import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:sgh_github_app_flutter/common/config/Config.dart';
import 'package:sgh_github_app_flutter/common/dao/UserDao.dart';
import 'package:sgh_github_app_flutter/common/local/LocalStorage.dart';
import 'package:sgh_github_app_flutter/common/style/GSYStyle.dart';
import 'package:sgh_github_app_flutter/widget/GSYFlexButton.dart';
import 'package:sgh_github_app_flutter/widget/GSYInputWidget.dart';


class LoginPage extends StatefulWidget {

  @override
  State createState() {
    return new _LoginPageState();
  }
}

class _LoginPageState extends State<LoginPage> {
  var _userName = "";

  var _password = "";

  final TextEditingController userController = new TextEditingController();
  final TextEditingController pwController = new TextEditingController();

  _LoginPageState(): super();

  @override
  void initState() { 
    super.initState();
    initParams();
  }

  initParams() async {
    _userName = await LocalStorage.get(Config.USER_NAME_KEY);
    _password = await LocalStorage.get(Config.PW_KEY);
    userController.value = new TextEditingValue(text: _userName);
    pwController.value = new TextEditingValue(text: _password);
  }

  @override
  Widget build(BuildContext context) {
    return new Container(
      color: Color(GSYColors.primaryValue),
      child: new Center(
        child: new Card(
          elevation: 5.0, //海拔高度
          shape: new RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(10.0))),
          color: Color(GSYColors.cardWhite),
          margin: const EdgeInsets.all(30.0),
          child: new Padding(
            padding: new EdgeInsets.only(left: 30.0, top: 60.0, right: 30.0, bottom: 80.0),
            child: new Column(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                new Image(
                  image: new AssetImage('static/images/logo.png'),
                  width: 80.0,
                  height: 80.0,
                ),
                new Padding(padding: new EdgeInsets.all(10.0)),
                new GSYInputWidget(
                  hintText: GSYStrings.login_username_hint_text, 
                  iconData: Icons.access_alarm,
                  obscureText: false,
                  onChanged: (String value) {
                    _userName = value;
                  },
                  controller: userController,
                ),
                new Padding(padding: new EdgeInsets.all(10.0)),
                new GSYInputWidget(
                  hintText: GSYStrings.login_password_hint_text, 
                  iconData: Icons.access_alarm,
                  obscureText: true,
                  onChanged: (String value) {
                    _password = value;
                  },
                  controller: pwController,
                ),
                new Padding(padding: new EdgeInsets.all(30.0)),
                new GSYFlexButton(
                  text: GSYStrings.login_text,
                  color: Color(GSYColors.primaryValue),
                  textColor: Color(GSYColors.textWhite),
                  onPress: (){
                    if (_userName == null || _userName.length == 0) {
                      return;
                    }
                    if (_password == null || _password.length == 0) {
                      return;
                    }
                    UserDao.login(_userName, _password, (data) {
                      if (data != null && data.result == true) {
                        Fluttertoast.showToast(msg: GSYStrings.login_success);
                      }
                    });
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
