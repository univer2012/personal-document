import 'package:flutter/material.dart';
import 'package:fluro/fluro.dart';
import './router_handler.dart';


class Routes {
  static String root = "/";
  static String detailsPage = '/detail';
  static void configureRoutes(Router router) {
    //没有找到 Handler的 响应
    router.notFoundHandler = new Handler(
      handlerFunc: (BuildContext context, Map<String, List<String>> params) {
        print('ERROR----> ROUTER WAS NOT FOUND!!!!');
      }
    );

    router.define(detailsPage, handler:detailsHandler);
  }
}
