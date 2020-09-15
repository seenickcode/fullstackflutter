import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

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
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                RaisedButton(
                    child: Text("Fetch Data"),
                    color: Colors.blue,
                    textColor: Colors.white,
                    onPressed: handleFetchTap),
                RaisedButton(child: Text("Reset"), onPressed: handleResetTap),
              ],
            ),
            Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
              Flexible(
                  child: Text(message,
                      maxLines: 20, style: TextStyle(fontSize: 18.0)))
            ])
          ],
        )));
  }

  handleFetchTap() async {
    var someData = await fetch();

    setState(() {
      message = someData;
    });
  }

  handleResetTap() {
    setState(() {
      message = "";
    });
  }

  Future<String> fetch() async {
    try {
      var url = "${DotEnv().env['API_BASE_URI']}/example";
      var resp = await get(url);
      return resp.body;
    } catch (error) {
      print(error);
      return error.toString();
    }
  }
}
