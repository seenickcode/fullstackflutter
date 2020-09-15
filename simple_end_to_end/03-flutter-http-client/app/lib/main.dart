import 'package:flutter/material.dart';
import 'app.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

void main() async {
  await DotEnv().load('local.env');
  runApp(App());
}
