import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

import '../Models/register_model.dart';
import '../Models/request_model.dart';
import '../Utils/Constants/app_links.dart';

Future<RegisterResponseModel> registerApi({
  required RequestModel registerRequestModel,
}) async {
  RegisterResponseModel registerResponse = RegisterResponseModel();

  try {
    Uri url = Uri.parse(AppLinks.api);

    http.Response response = await http.post(
      url,
      headers: <String, String>{
        'Content-Type': 'application/json',
      },
      body: convert.jsonEncode(registerRequestModel.toJson()),
    );
    print('======= register api ======');
    print(convert.jsonEncode(registerRequestModel.toJson()));
    print(response.body);

    var body = convert.json.decode(response.body);

    registerResponse = RegisterResponseModel.fromJson(body);

    return registerResponse;
  } catch (e) {
    throw Exception(e);
  }
}
