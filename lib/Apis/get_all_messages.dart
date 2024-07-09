import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

import '../Models/messages_model.dart';
import '../Models/request_model.dart';
import '../Utils/Constants/app_links.dart';

Future<MessagesModel> getAllMessagesApi(
    {required RequestModel requestModel}) async {
  MessagesModel messages = MessagesModel();

  try {
    Uri url = Uri.parse(AppLinks.api);

    http.Response response = await http.post(
      url,
      headers: <String, String>{
        'Content-Type': 'application/json',
      },
      body: convert.jsonEncode(requestModel.toJson()),
    );

    var body = convert.json.decode(response.body);

    messages = MessagesModel.fromJson(body);

    return messages;
  } catch (e) {
    throw Exception(e);
  }
}
