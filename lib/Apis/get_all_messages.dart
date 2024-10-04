import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

import '../Models/all_messages_model.dart';
import '../Models/request_model.dart';
import '../Utils/Constants/app_links.dart';

Future<AllMessagesModel> getAllMessagesApi(
    {required RequestModel requestModel}) async {
  AllMessagesModel messages = AllMessagesModel();

  try {
    Uri url = Uri.parse(AppLinks.api);

    http.Response response = await http.post(
      url,
      headers: <String, String>{
        'Content-Type': 'application/json',
      },
      body: convert.jsonEncode(requestModel.toJson()),
    );

    print('fetch all messages =======================');
    print(convert.jsonEncode(requestModel.toJson()));

    var body = convert.json.decode(response.body);
    print(body);
    print('fetch all messages =======================');

    messages = AllMessagesModel.fromJson(body);

    return messages;
  } catch (e) {
    throw Exception(e);
  }
}
