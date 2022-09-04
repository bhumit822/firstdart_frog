import 'dart:convert';
import 'dart:developer';

import 'package:dart_frog/dart_frog.dart';
import 'package:mongo_dart/mongo_dart.dart';

Future<Response> onRequest(RequestContext context) async {
  final db = await Db.create(
      "mongodb+srv://bhumit_antala:Bhumit_antala@flutterapp.stbrkwn.mongodb.net/?retryWrites=true&w=majority");

  await db.open();

  await db.createCollection("bhumit");

  Map<String, dynamic> data =
      jsonDecode((await (context.request.body()))) as Map<String, dynamic>;
  final collection = db.collection("bhumit");
  collection.insert(data);

  print("${data}");
  // db.collection("bhumit").insert(context)
  return Response(body: 'Welcome to Dart Frog!');
}
