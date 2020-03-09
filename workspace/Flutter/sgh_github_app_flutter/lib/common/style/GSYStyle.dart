import 'package:flutter/material.dart';

class GSYColors {
  static const String welcomeMessage = "Welcome To Flutter";

  static const int primaryValue = 0xFF24292E;
  static const int primaryLightValue = 0xFF42464b;
  static const int primaryDarkValue = 0xFF121917;

  static const int cardWhite = 0xFFFFFFFF;

  static const int textWhite = 0xFFFFFFFF;

  static const int miWhite = 0xffececec;
  static const int white = 0xFFFFFFFF;
  static const int transparentColor = 0x00000000;

  static const int mainBackgroundColor = miWhite;
  static const int tabBackgroundColor = 0xffffffff;
  static const int cardBackgroundColor = 0xFFFFFFFF;
  static const int cardShadowColor = 0xff000000;
  static const int actionBlue = 0xff267aff;

  static const int lineColor = 0xff42464b;

  static const int webDraculaBackgroundColor = 0xff282a36;

  static const int selectedColor = primaryDarkValue;

  static const int titleTextColor = miWhite;
  static const int mainTextColor = primaryDarkValue;
  static const int subTextColor = 0xff959595;
  static const int subLightTextColor = 0xffc4c4c4;
  static const TextColorWhite = 0xFFFFFFFF;
  static const TextColorMiWhite = miWhite;

  static const tabSelectedColor = primaryValue;
  static const tabUnSelectColor = 0xffa6aaaf;


  static const MaterialColor primarySwatch = const MaterialColor(
    primaryValue,
    const <int, Color>{
      50: const Color(primaryLightValue),
      100: const Color(primaryLightValue),
      200: const Color(primaryLightValue),
      300: const Color(primaryLightValue),
      400: const Color(primaryLightValue),
      500: const Color(primaryValue),
      600: const Color(primaryDarkValue),
      700: const Color(primaryDarkValue),
      800: const Color(primaryDarkValue),
      900: const Color(primaryDarkValue),
    },
  );
}

class GSYConstant {
  // navbar 高度
  static const iosnavHeaderHeight = 70.0;
  static const andrnavHeaderHeight = 70.0;

  static const largetTextSize = 30.0;
  static const bigTextSize = 23.0;
  static const normalTextSize = 18.0;
  static const middleTextWhiteSize = 16.0;
  static const smallTextSize = 14.0;
  static const minTextSize = 12.0;

  // tabBar 高度
  static const tabBarHeight = 44.0;
  static const tabIconSize = 20.0;

  static const normalIconSize = 40.0;
  static const bigIconSize = 50.0;
  static const largeIconSize = 80.0;
  static const smallIconSize = 30.0;
  static const minIconSize = 20.0;
  static const littleIconSize = 10.0;

  static const normalMarginEdge = 10.0;
  static const normalNumberOfLine = 4.0;

  static const titleTextStyle = TextStyle(
    color: Color(GSYColors.titleTextColor),
    fontSize: normalTextSize,
    fontWeight: FontWeight.bold,
  );

  static const smallTextWhite = TextStyle(
    color: Color(GSYColors.TextColorWhite),
    fontSize: smallTextSize,
  );

  static const smallText = TextStyle(
    color: Color(GSYColors.mainTextColor),
    fontSize: smallTextSize,
  );


  static const smallTextBold = TextStyle(
    color: Color(GSYColors.mainTextColor),
    fontSize: smallTextSize,
    fontWeight: FontWeight.bold,
  );

  static const subLightSmallText = TextStyle(
    color: Color(GSYColors.subLightTextColor),
    fontSize: smallTextSize,
  );

  static const miLightSmallText = TextStyle(
    color: Color(GSYColors.miWhite),
    fontSize: smallTextSize,
  );

  static const subSmallText = TextStyle(
    color: Color(GSYColors.subTextColor),
    fontSize: smallTextSize,
  );

  static const middleText = TextStyle(
    color: Color(GSYColors.mainTextColor),
    fontSize: middleTextWhiteSize,
  );

  static const normalText = TextStyle(
    color: Color(GSYColors.mainTextColor),
    fontSize: normalTextSize,
  );

  static const subNormalText = TextStyle(
    color: Color(GSYColors.subTextColor),
    fontSize: normalTextSize,
  );

  static const normalTextWhite = TextStyle(
    color: Color(GSYColors.TextColorWhite),
    fontSize: normalTextSize,
  );

  static const normalTextMitWhite = TextStyle(
    color: Color(GSYColors.miWhite),
    fontSize: normalTextSize,
  );

  static const normalTextLight = TextStyle(
    color: Color(GSYColors.primaryLightValue),
    fontSize: normalTextSize,
  );

  static const middleTextWhite = TextStyle(
    color: Color(GSYColors.TextColorWhite),
    fontSize: middleTextWhiteSize,
  );

  static const largeText = TextStyle(
    color: Color(GSYColors.mainTextColor),
    fontSize: bigTextSize,
  );

  static const largeTextWhite = TextStyle(
    color: Color(GSYColors.TextColorWhite),
    fontSize: bigTextSize,
  );
}


class GSYStrings {
  static const String app_name = "GSYGithubAppFlutter";

  static const String login_text = "登录";

  static const String login_username_hint_text = "请输入github用户名";
  static const String login_password_hint_text = "请输入密码";
  static const String login_success = "登录成功";

  static const String network_error_401 = "未授权或授权登录失败";
  static const String network_error_403 = "403权限错误";
  static const String network_error_404 = "404错误";
  static const String network_error_timeout = "请求超时";
  static const String network_error_unknown = "其他异常";

  static const String load_more_not = "没有更多数据";
  
}