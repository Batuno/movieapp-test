import 'package:dio/dio.dart';

class CustomInterceptors extends InterceptorsWrapper {
  CustomInterceptors()
      : super(onRequest: (options, handler) {
          print("onreques");
          if (options.uri.toString() == "https://pub.dev/packages/dio") {
            return handler.reject(
              DioError(requestOptions: options, type: DioErrorType.cancel),
            );
          }
          return handler.next(options);
        }, onResponse: (response, handler) {
          print("onresponse");
          return handler.next(response);
        }, onError: (DioError e, handler) {
          print("on error");
          return handler.next(e);
        });
}
