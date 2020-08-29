import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Home extends StatefulWidget {
  Home({Key key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  String message = "";

  @override
  void initState() {
    super.initState();
    fetchPageData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("My test message is: $message"),
      ),
    );
  }

  // fetchPageData makes an example HTTP call to fetch some data.
  // To play with the endpoint on your own, check out https://docs.postman-echo.com/
  // NOTE we'll move this method to a proper place in a later lesson
  void fetchPageData() async {
    try {
      http.Response response = await http.get('https://postman-echo.com/get');
      if (response.statusCode == 200 || response.statusCode == 201) {
        print(response.body);

        // convert response into a Map
        Map<String, dynamic> map = json.decode(response.body);

        setState(() {
          message = map['headers']['host'];
        });
      }
    } catch (error) {
      print(error);

      setState(() {
        message = "error: ${error.toString()}";
      });
    }
  }
}
