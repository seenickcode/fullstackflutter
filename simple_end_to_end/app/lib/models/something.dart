import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'dart:async';

class Something {
  // fetchHostname makes an example HTTP call to fetch some data.
  // To play with the endpoint on your own, check out https://docs.postman-echo.com/
  static Future<String> fetch() async {
    try {
      var url = '${DotEnv().env['API_BASE_URI']}/example';
      http.Response response = await http.get(url);
      if (response.statusCode == 200 || response.statusCode == 201) {
        print(response.body);
        return response.body;
      }
    } catch (error) {
      print(error);
      return error.toString();
    }
    return null;
  }
}
