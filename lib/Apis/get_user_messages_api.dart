import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

import '../Models/request_model.dart';
import '../Models/messages_model.dart';
import '../Utils/Constants/app_links.dart';

Future<MessagesModel> getUserMessagesApi(
    {required RequestModel getUserMessagesRequest}) async {
  MessagesModel userMessages = MessagesModel(status: '', data: []);

  try {
    Uri url = Uri.parse(AppLinks.api);
    http.Response response = await http.post(
      url,
      headers: <String, String>{
        'Content-Type': 'application/json',
      },
      body: convert.jsonEncode(getUserMessagesRequest.toJson()),
    );
    print('get User Messages');
    print(convert.jsonEncode(getUserMessagesRequest.toJson()));

    var body = convert.json.decode(response.body);

    userMessages = MessagesModel.fromJson(body);
    return userMessages;
  } catch (e) {
    throw Exception(e);
  }
}
