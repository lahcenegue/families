import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

import '../Models/request_model.dart';
import '../Models/messages_model.dart';
import '../Utils/Constants/app_links.dart';

Future<MessagesModel> getUserMessagesApi(
    {required RequestModel getUserMessagesRequest}) async {
  try {
    Uri url = Uri.parse(AppLinks.api);

    http.Response response = await http.post(
      url,
      headers: <String, String>{
        'Content-Type': 'application/json',
      },
      body: convert.jsonEncode(getUserMessagesRequest.toJson()),
    );

    var body = convert.json.decode(response.body);

    return MessagesModel.fromJson(body);
  } catch (e) {
    debugPrint('Error in getUserMessagesApi: $e');
    throw Exception('Error in getUserMessagesApi: $e');
  }
}
