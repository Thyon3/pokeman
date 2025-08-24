import 'package:dio/dio.dart';

class HttpServices {
  final _dio = Dio();
  // send the get request using the dio package

  Future<Response?> get(String path) async {
    try {
      Response? res = await _dio.get(path);
      return res;
    } catch (e) {
      print(e);
    }
    return null;
  }

  String hello(String word) {
    return 'hello ${word}';
  }
}
