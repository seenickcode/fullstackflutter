import 'package:server/server.dart';

Future main() async {
  final port = int.parse(Platform.environment["PORT"] ?? "8080");

  final app = Application<ServerChannel>()
    ..options.configurationFilePath = "config.yaml"
    ..options.port = port;

  await app.startOnCurrentIsolate();

  print("Application started on port: ${app.options.port}.");
  print("Use Ctrl-C (SIGINT) to stop running the application.");
}
