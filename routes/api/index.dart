import 'dart:developer';

import 'package:dart_frog/dart_frog.dart';
import 'package:mongo_dart/mongo_dart.dart';

Response onRequest(RequestContext context) {
  return Response(body: 'Welcome to api');
}
