import 'package:dio/dio.dart';

import 'interceptors.dart';

class ApiService {
  final Dio dio;

  ApiService()
      : dio = Dio(
          BaseOptions(
            baseUrl: "https://api.jsonbin.io/v3/b/",
            receiveTimeout: const Duration(milliseconds: 30000),
            sendTimeout: const Duration(milliseconds: 30000),
          ),
        )..interceptors.add(CustomInterceptors());

  Future<Response> getRequest(String path, [bool isAuth = false]) async {
    if (isAuth) {
      print("Auth required");
      return dio.get(path,
          options: Options(headers: {
            "X-ACCESS-KEY":
                "\$2b\$10\$pLVYmeN9qX.PvOBwYjXXtesjrkE.r7ns.T0OjubyNu8jEd9CmNMTi"
          }));
    } else {
      return dio.get(path);
    }
  }

  Future<Response> postRequest(String path,
      {bool isAuth = false, dynamic body}) async {
    if (isAuth) {
      print("Auth required");
      return dio.post(path,
          data: body, options: Options(headers: {"authorization": "bearer"}));
    } else {
      return dio.post(path, data: body);
    }
  }

  Future<Response> putRequest(String path,
      {bool isAuth = false, dynamic body}) async {
    if (isAuth) {
      print("Auth required");
      return dio.put(path,
          data: body, options: Options(headers: {"authorization": "bearer"}));
    } else {
      return dio.put(path, data: body);
    }
  }

  Future<Response> deleteRequest(String path,
      {bool isAuth = false, dynamic body}) async {
    if (isAuth) {
      print("Auth required");
      return dio.delete(path,
          data: body, options: Options(headers: {"authorization": "bearer"}));
    } else {
      return dio.delete(path, data: body);
    }
  }
}
