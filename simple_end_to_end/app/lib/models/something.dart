import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';

class Something {
  // fetchHostname makes an example HTTP call to fetch some data.
  // To play with the endpoint on your own, check out https://docs.postman-echo.com/
  static Future<String> fetch() async {
    try {
      http.Response response = await http.get('https://postman-echo.com/get');
      if (response.statusCode == 200 || response.statusCode == 201) {
        print(response.body);

        // convert response into a Map
        Map<String, dynamic> map = json.decode(response.body);

        return map['headers']['host'];
      }
    } catch (error) {
      print(error);

      return error.toString();
    }
    return null;
  }
}
