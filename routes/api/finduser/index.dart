import 'dart:developer';

import 'package:dart_frog/dart_frog.dart';
import 'package:mongo_dart/mongo_dart.dart';

Future<Response> onRequest(
  RequestContext context,
) async {
  print(
      "check the query log---->${context.request.headers}"); //get reuest query parameter

  final query =
      finduserrequestdataModel.fromJson(context.request.url.queryParameters);

  final db = await Db.create(
      "mongodb+srv://bhumit_antala:Bhumit_antala@flutterapp.stbrkwn.mongodb.net/?retryWrites=true&w=majority");

  await db.open();

  final collection = db.collection("bhumit");
  final List<Map<String, dynamic>> data = [];

  ///get where field exact match with query
  // final a = await collection
  //     .find(where.all('name'.toLowerCase(), [query.name!.toLowerCase()]))
  //     .forEach((element) {
  //   data.add(element);
  //   print(data);
  // }).whenComplete(() => null); //get where field exact match with query

  ///get where field data contains with query
  final a = await collection
      .find(where.match("name", query.name!))
      .forEach((element) {
    data.add(element);
  }).whenComplete(() => null); //get where field data contains with query

  return Response.json(body: {"data": data});
}

class finduserrequestdataModel {
  String? name;
  int? id;

  finduserrequestdataModel({this.name, this.id});

  finduserrequestdataModel.fromJson(Map<String, dynamic> json) {
    name = json['name'].toString();
    id = int.tryParse(json['id'].toString());
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['id'] = this.id;
    return data;
  }
}
