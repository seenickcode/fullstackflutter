import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  LoginPage({Key key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  String _accessToken;
  String _refreshToken;
  String _authorizationCode;

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
              onPressed: () {
                Navigator.of(context).pushNamed('/oauth');
              },
              child: const Text('Login via nickmanning.dev',
                  style: TextStyle(fontSize: 20)),
            ),
            Text("Access token is: $_accessToken"),
            Text("Refresh token is: $_refreshToken"),
            Text("Refresh token is: $_authorizationCode"),
          ],
        ),
      ),
    );
  }
}
