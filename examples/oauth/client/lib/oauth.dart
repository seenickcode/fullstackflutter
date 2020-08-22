import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';
import 'dart:io';
import 'package:http/http.dart' as httpClient;

class OAuthPage extends StatefulWidget {
  OAuthPage({Key key}) : super(key: key);

  @override
  _OAuthPageState createState() => _OAuthPageState();
}

class _OAuthPageState extends State<OAuthPage> {
  final flutterWebviewPlugin = FlutterWebviewPlugin();
  bool _fetching = false;

  _OAuthPageState();

  @override
  Widget build(BuildContext context) {
    flutterWebviewPlugin.onUrlChanged
        .listen((String url) => handleURLChanged(context, url));

    return WebviewScaffold(
      url:
          "http://10.0.3.2:8888/auth/code?response_type=code&client_id=dev.nickmanning&state=1234",
      mediaPlaybackRequiresUserGesture: false,
      appBar: AppBar(
        title: const Text('Login to nickmanning.dev'),
      ),
      withZoom: true,
      withLocalStorage: true,
      hidden: true,
      initialChild: Container(
        color: Colors.white,
        child: const Center(
          child: Text('Waiting...'),
        ),
      ),
    );
  }

  handleURLChanged(BuildContext context, String url) async {
    print("url changed to $url");
    if (url.startsWith('oauth://exchange') && !_fetching) {
      final uri = Uri.parse(url);
      final authCode = uri.queryParameters['code'];
      final tokenRespose = await getAccessToken(authCode);
      if (Navigator.canPop(context)) {
        Navigator.pop(context);
      }
      setState(() {
        _fetching = false;
      });
    }
  }

  Future<String> getAccessToken(String authCode) async {
    // NOTE only an example, as we should never hard code stuff like this here
    var url = 'http://10.0.3.2:8888/auth/token';
    var clientID = "dev.nickmanning";
    var clientSecret =
        "1234"; // NOTE only for example, this is typically kept secret
    var clientCredentials =
        Base64Encoder().convert("$clientID:$clientSecret".codeUnits);

    var resp = await httpClient.post(url, headers: {
      HttpHeaders.authorizationHeader: "Basic $clientCredentials"
    }, body: {
      'grant_type': 'authorization_code',
      'code': authCode,
    });

    Map<String, dynamic> respMap = json.decode(resp.body);
    if (resp.hashCode == HttpStatus.ok) {
      return Future.value(respMap['access_token']);
    } else {
      print("error is ${respMap['error']}");
      return Future.value(null);
    }
  }
}
