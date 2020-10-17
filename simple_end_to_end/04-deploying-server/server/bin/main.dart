import 'package:server/server.dart';

Future main() async {
  print("PORT env var is ${Platform.environment["PORT"]}");

  final port = int.parse(Platform.environment["PORT"]);

  print("port parsed is $port");

  final app = Application<ServerChannel>()
    ..options.configurationFilePath = "config.yaml"
    ..options.port = port;

  await app.startOnCurrentIsolate();

  print("Application started on port: ${app.options.port}.");
  print("Use Ctrl-C (SIGINT) to stop running the application.");

  var n = 0;
  ProcessSignal.sigint.watch().listen((signal) {
    print(" caught ${++n} of 3");

    if (n == 3) {
      exit(0);
    }
  });
}
