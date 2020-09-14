import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  Home({Key key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  String message = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Example"),
      ),
      body: Center(
          child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
            Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
              RaisedButton(
                  child: Text("Fetch Data"),
                  color: Colors.blue,
                  textColor: Colors.white,
                  onPressed: handleFetchTap),
              RaisedButton(child: Text("Reset"), onPressed: handleResetTap),
            ]),
            Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
              Flexible(
                  child: Text(message,
                      maxLines: 20, style: TextStyle(fontSize: 18.0))),
            ]),
          ])),
    );
  }

  handleFetchTap() async {
    var someData = await fetch();

    setState(() {
      message = someData;
    });
  }

  handleResetTap() async {
    setState(() {
      message = "";
    });
  }

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
