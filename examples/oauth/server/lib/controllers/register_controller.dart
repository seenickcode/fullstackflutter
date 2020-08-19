import '../models/user.dart';
import 'package:aqueduct/aqueduct.dart';

class RegisterController extends QueryController<User> {
  RegisterController(ManagedContext context, this.authServer) : super(context);

  final AuthServer authServer;

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

    final u = await query.insert();

    return Response.ok(u);
  }
}
