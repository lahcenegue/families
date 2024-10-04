import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

import '../Models/request_model.dart';
import '../Models/messages_model.dart';
import '../Utils/Constants/app_links.dart';

Future<MessagesModel> getUserMessagesApi(
    {required RequestModel getUserMessagesRequest}) async {
  try {
    Uri url = Uri.parse(AppLinks.api);
    print('Sending request to: $url');

    http.Response response = await http.post(
      url,
      headers: <String, String>{
        'Content-Type': 'application/json',
      },
      body: convert.jsonEncode(getUserMessagesRequest.toJson()),
    );

    print(
        'Request body: ${convert.jsonEncode(getUserMessagesRequest.toJson())}');
    print('Response status code: ${response.statusCode}');
    print('Response body: ${response.body}');

    var body = convert.json.decode(response.body);
    print(body);

    return MessagesModel.fromJson(body);
  } catch (e) {
    print('Error in getUserMessagesApi: $e');
    throw Exception('Error in getUserMessagesApi: $e');
  }
}
