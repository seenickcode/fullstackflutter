import 'package:server/server.dart';

Future main() async {
  final port = int.parse(Platform.environment["PORT"] ?? "8888");

  final app = Application<ServerChannel>()
    ..options.configurationFilePath = "config.yaml"
    ..options.port = port;

  await app.start(numberOfInstances: 1, consoleLogging: true);

  // this doesn't work for Google Cloud Run
  // await app.startOnCurrentIsolate();

  print("Application started on port: ${app.options.port}.");
  print("Use Ctrl-C (SIGINT) to stop running the application.");

  // needed when we want to send a SIGINT to a running Docker container
  ProcessSignal.sigint.watch().listen((signal) {
    print("receivd SIGINT, exiting");
    exit(0);
  });
}
