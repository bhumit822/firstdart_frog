import 'dart:convert';
import 'dart:developer';

import 'package:dart_frog/dart_frog.dart';
import 'package:mongo_dart/mongo_dart.dart';

Future<Response> onRequest(RequestContext context) async {
  final db = await Db.create(
      "mongodb+srv://bhumit_antala:Bhumit_antala@flutterapp.stbrkwn.mongodb.net/?retryWrites=true&w=majority");

  await db.open();

  await db.createCollection("bhumit");

  final collection = db.collection("bhumit");
// final pipeline = AggregationPipelineBuilder().addStage(stage);
  Map<String, dynamic> a = {"data": []};
  collection.find().listen((event) {
    print((event.runtimeType));
    a["data"].add(jsonDecode(jsonEncode({
      "id": (event["_id"] as ObjectId).$oid,
      "name": event["name"].toString()
    })));
    // a.addEntries([
    //   MapEntry(
    //       "data",
    //      [ ({
    //         "id": (event["_id"] as ObjectId).$oid,
    //         "name": event["name"].toString()
    //       } as Map<String, dynamic>)])
    // ]);
  });

  print("${(await collection.count())}");
  return Response.json(body: jsonDecode(jsonEncode(a)), statusCode: 200);
}
