import 'package:dio/dio.dart';

const String BASEURL = 'http://www.daokoudai.com';

class HttpConfig {
  static const baseURL = BASEURL;
  static const timeout = 1000;
}

class CYHttpRequest {
  static final BaseOptions options = BaseOptions(
    baseUrl: HttpConfig.baseURL, connectTimeout: HttpConfig.timeout
  );
  static final Dio dio = Dio(options);

  static Future<T> request<T>(String url,
    {String method = 'get', Map<String, dynamic> params, Interceptor inter}) async{
    // 请求的单独配置
    final options = Options(method: method);
    // 添加第一个拦截器
    Interceptor dInter = InterceptorsWrapper(
      onRequest: (RequestOptions options){
        /*
        * 1、在进行任何网络请求的时候，可以添加一个loading显示
        * 2、可以在这里判断是否有token
        * 3、对参数进行一些出来，序列化处理
        * */
        return options;
      },
      onResponse: (Response response){
        // 响应
        return response;
      },
      onError: (DioError error){
        // 错误
        return error;
      }
    );

    List<Interceptor> inters = [dInter];
    if (inter != null) {
      inters.add(inter);
    }
    dio.interceptors.addAll(inters);

    try{
      Response response = await dio.request<T>(url, queryParameters: params, options: options);
      return response.data;
    } on DioError catch(err){
      return Future.error(err);
    }

  }
}