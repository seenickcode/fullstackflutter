import 'dart:async';
import 'package:aqueduct/aqueduct.dart';

class ProtectedController extends ResourceController {
  @Operation.get()
  Future<Response> somethingProtected() async {
    return Response.ok({"something": "protected"});
  }
}
