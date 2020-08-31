import 'package:aqueduct/managed_auth.dart';
import 'controllers/oauth_redirect_renderer.dart';
import 'controllers/protected_controller.dart';
import 'controllers/register_controller.dart';
import 'models/user.dart';
import 'oauth.dart';

/// This type initializes an application.
///
/// Override methods in this class to set up routes and initialize services like
/// database connections. See http://aqueduct.io/docs/http/channel/.
class OauthChannel extends ApplicationChannel {
  ManagedContext context;
  AuthServer authServer;
  AuthRedirectController authRedirController;
  OAuthRedirectRenderer renderer;

  /// Initialize services in this method.
  ///
  /// Implement this method to initialize services, read values from [options]
  /// and any other initialization required before constructing [entryPoint].
  ///
  /// This method is invoked prior to [entryPoint] being accessed.
  @override
  Future prepare() async {
    logger.onRecord.listen(
        (rec) => print("$rec ${rec.error ?? ""} ${rec.stackTrace ?? ""}"));

    final config = AppConfig(options.configurationFilePath);
    final dataModel = ManagedDataModel.fromCurrentMirrorSystem();
    final persistentStore = PostgreSQLPersistentStore.fromConnectionInfo(
        config.database.username,
        config.database.password,
        config.database.host,
        config.database.port,
        config.database.databaseName);

    context = ManagedContext(dataModel, persistentStore);

    renderer = OAuthRedirectRenderer();

    authRedirController =
        AuthRedirectController(authServer, delegate: renderer);

    authServer = AuthServer(ManagedAuthDelegate<User>(context));
  }

  /// Construct the request channel.
  ///
  /// Return an instance of some [Controller] that will be the initial receiver
  /// of all [Request]s.
  ///
  /// This method is invoked after [prepare].
  @override
  Controller get entryPoint {
    final router = Router();

    // Prefer to use `link` instead of `linkFunction`.
    // See: https://aqueduct.io/docs/http/request_controller/
    router.route("/healthz").linkFunction((request) async {
      return Response.ok({"status": "ok"});
    });

    router
      .route("/register")
      .link(() => RegisterController(context, authServer));

    // Set up auth token route- this grants and refresh tokens
    router.route("/auth/token").link(() => AuthController(authServer));

    // Set up auth code route- this grants temporary access codes that can be exchanged for token
    router
      .route("/auth/code")
      .link(() => AuthRedirectController(authServer, delegate: renderer));

    // Set up protected route
    router
      .route("/protected")
      .link(() => Authorizer.bearer(authServer))
      .link(() => ProtectedController());

    return router;
  }
}

class AppConfig extends Configuration {
  AppConfig(String path) : super.fromFile(File(path));

  DatabaseConfiguration database;
}
