import 'dart:convert';

import 'package:dart_frog/dart_frog.dart';
import 'package:mongo_dart/mongo_dart.dart';

Future<Response> onRequest(RequestContext context) async {
  // db.collection("bhumit").insert(context)
  switch (context.request.method) {
    case HttpMethod.delete:
      return otherRespose();
      break;
    case HttpMethod.get:
      return otherRespose();
      break;
    case HttpMethod.head:
      return otherRespose();
      break;
    case HttpMethod.options:
      return otherRespose();
      break;
    case HttpMethod.patch:
      return otherRespose();
      break;
    case HttpMethod.post:
      return postResponse(context);
      break;
    case HttpMethod.put:
      return otherRespose();
      break;
  }
}

Future<Response> postResponse(RequestContext context) async {
  final db = await Db.create(
      "mongodb+srv://bhumit_antala:Bhumit_antala@flutterapp.stbrkwn.mongodb.net/?retryWrites=true&w=majority");

  await db.open();

  await db.createCollection("bhumit");

  Map<String, dynamic> data =
      jsonDecode((await (context.request.body()))) as Map<String, dynamic>;
  final collection = db.collection("bhumit");
  // final a = await collection.insert(data, writeConcern: WriteConcern());
  final a = await collection.insertOne(data, bypassDocumentValidation: true);
  return Response.json(body: {
    "data": a.document,
    "message": "Added new user successfuly.",
    "statusCode": 200
  }, statusCode: 200);
}

Response otherRespose() {
  return Response.json(body: {
    "data": [],
    "message": "Invalid request method.",
    "statusCode": 200
  }, statusCode: 200);
}
