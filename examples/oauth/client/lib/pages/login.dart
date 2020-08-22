import 'package:flutter/material.dart';
import 'package:oauth/pages/oauth.dart';
import '../models/token.dart';

class LoginPage extends StatefulWidget {
  LoginPage({Key key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  String _accessToken;
  String _refreshToken;

  _LoginPageState();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("OAuth Example"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            RaisedButton(
              onPressed: () => presentOAuthForAccessToken(context),
              child: const Text('Login via nickmanning.dev',
                  style: TextStyle(fontSize: 20)),
            ),
            Text("Access token is: $_accessToken"),
            Text("Refresh token is: $_refreshToken"),
          ],
        ),
      ),
    );
  }

  presentOAuthForAccessToken(BuildContext context) async {
    final Token token = await Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => OAuthPage(),
        ));
    if (token == null) {
      setState(() {
        _accessToken = "error";
        _refreshToken = "error";
      });
    } else {
      setState(() {
        _accessToken = token.accessToken;
        _refreshToken = token.refreshToken;
      });
    }
  }
}
