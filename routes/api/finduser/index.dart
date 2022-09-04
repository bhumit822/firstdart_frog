import 'package:dart_frog/dart_frog.dart';

Future<Response> onRequest(
  RequestContext context,
) async {
  print(
      "check the log---->${context.request.url.queryParameters}"); //get reuest query parameter
  return Response(body: "finding");
}
