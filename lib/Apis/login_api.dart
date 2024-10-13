import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

import '../Models/login_response_model.dart';
import '../Models/request_model.dart';
import '../Utils/Constants/app_links.dart';

Future<LoginResponseModel> loginApi({
  required RequestModel loginRequestModel,
}) async {
  LoginResponseModel loginResponse = LoginResponseModel();

  try {
    Uri url = Uri.parse(AppLinks.api);

    http.Response response = await http.post(
      url,
      headers: <String, String>{
        'Content-Type': 'application/json',
      },
      body: convert.jsonEncode(loginRequestModel.toJson()),
    );
    print('====================');
    print(convert.jsonEncode(loginRequestModel.toJson()));

    var body = convert.json.decode(response.body);
    print(body);
    print('====================');

    loginResponse = LoginResponseModel.fromJson(body);

    return loginResponse;
  } catch (e) {
    throw Exception(e);
  }
}
