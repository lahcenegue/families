import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

import '../Models/get_reset_token_model.dart';
import '../Models/request_model.dart';
import '../Utils/Constants/app_links.dart';

Future<ResetTokenResponseModel> getResetTokenApi({
  required RequestModel requestModel,
}) async {
  ResetTokenResponseModel resetTokenResponse = ResetTokenResponseModel();

  try {
    Uri url = Uri.parse(AppLinks.api);

    http.Response response = await http.post(
      url,
      headers: <String, String>{
        'Content-Type': 'application/json',
      },
      body: convert.jsonEncode(requestModel.toJson()),
    );
    print(convert.jsonEncode(requestModel.toJson()));
    print(response.body);
    print(response.statusCode);

    var body = convert.json.decode(response.body);

    resetTokenResponse = ResetTokenResponseModel.fromJson(body);

    return resetTokenResponse;
  } catch (e) {
    throw Exception(e);
  }
}
