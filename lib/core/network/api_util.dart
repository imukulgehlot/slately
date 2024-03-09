import 'dart:convert';

import '../basic_features.dart';
import 'generic_response.dart';

class ApiUtil {
  ApiUtil._();

  static final instance = ApiUtil._();

  dynamic jsonConverter(T data, String d) {
    if (d.startsWith('[')) {
      const starter = '{ "result" : ';
      final String result = '$starter$d}';
      if (kDebugMode) {
        print('final string ===== $result');
      }
      return data.fromJson(json.decode(result));
    }
    return data.fromJson(json.decode(d));
  }
}
