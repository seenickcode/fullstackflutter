import 'dart:async';
import 'dart:io';
import 'package:aqueduct/aqueduct.dart';
import 'package:mustache/mustache.dart';
import '../models/user.dart';

class RegisterController extends QueryController<User> {
  RegisterController(ManagedContext context, this.authServer) : super(context);

  final AuthServer authServer;

  @Operation.get()
  Future<Response> newUser() async {
    final templateContents =
        File("templates/register.mustache").readAsStringSync();

    final template = Template(templateContents);

    final rendered = template.renderString({});

    return Response.ok(rendered)..contentType = ContentType.html;
  }

  @Operation.post()
  Future<Response> createUser() async {
    if (query.values.username == null || query.values.password == null) {
      return Response.badRequest(
          body: {"error": "username and password required."});
    }

    final salt = AuthUtility.generateRandomSalt();
    final hashedPassword =
        AuthUtility.generatePasswordHash(query.values.password, salt);

    query.values.hashedPassword = hashedPassword;
    query.values.salt = salt;
    query.values.email = query.values.username;

    await query.insert();

    const clientID = "dev.nickmanning";
    const clientSecret = "1234";

    final authCode = await authServer.authenticateForCode(
        query.values.username, query.values.password, clientID,
        requestedScopes: [AuthScope('*')]);

    final token =
        await authServer.exchange(authCode.code, clientID, clientSecret);

    return AuthController.tokenResponse(token);
  }
}
