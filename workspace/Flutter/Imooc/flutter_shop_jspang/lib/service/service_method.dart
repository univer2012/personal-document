import 'package:dio/dio.dart';
import 'dart:async';
import 'dart:io';
import '../config/serivce_url.dart';


// 获取首页主题内容
Future getHomePageContent()async{
  try{
    //print('开始获取首页数据......');
    Response response;
    Dio dio = new Dio();
    dio.options.contentType = ContentType.parse("application/x-www-form-urlencoded");
    var formData = {'lon': '115.02932', 'lat':'35.76189'};
    response = await dio.post(servicePath['homePageContent'],data:formData);
    if (response.statusCode == 200) {
      return response.data;
    } else {
      throw Exception('后端接口出现异常。');
    }
  }catch(e){
    return print('ERROR: =======>${e}');
  }
  
}

//获得火爆专区商品的方法
Future getHomePageBelowConten() async {
  try{
    print('开始获取下拉列表数据.....');
    Response response;
    Dio dio = new Dio();
    dio.options.contentType = ContentType.parse("application/x=www-form-urlencoded");
    int page = 1;
    response = await dio.post(servicePath['homePageBelowConten'],data: page);
    if (response.statusCode == 200) {
      return response.data;
    } else {
      throw Exception('后端接口出现异常，请检测代码和服务器情况......');
    }
  }catch(e){
    return print('ERROR: =======> ${e}');
  }
}

Future request(url, {formData})async {
  try {
    //print('开始获取数据.....');
    Response response;
    Dio dio = new Dio();
    dio.options.contentType = ContentType.parse("application/x=www-form-urlencoded");
    var sPath = servicePath[url];
    print('sPath=${sPath}');
    print('formData=${formData}');
    if (formData == null) {
      response = await dio.post(sPath);
    } else {
      response = await dio.post(sPath, data: formData);
    }
    if (response.statusCode == 200) {
      print('response_data=${response.data}');
      return response.data;
    } else {
      throw Exception('后端接口出现异常，请检测代码和服务器情况.....');
    }

  } catch (e) {
    return print('ERROR: =======> ${e}');
  }
}