import 'dart:async';
import 'dart:io';
import 'package:aqueduct/aqueduct.dart';
import 'package:mustache/mustache.dart';

class OAuthRedirectRenderer extends AuthRedirectControllerDelegate {
  @override
  Future<String> render(AuthRedirectController forController, Uri requestUri,
      String responseType, String clientID, String state, String scope) {
    final templateContents = File("templates/auth.mustache").readAsStringSync();

    final template = Template(templateContents);

    final rendered = template.renderString({});

    return Future<String>.value(rendered);
  }
}
