import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

import '../Models/base_model.dart';
import '../Models/request_model.dart';
import '../Utils/Constants/app_links.dart';

Future<BaseModel> baseApi({
  required RequestModel requestModel,
}) async {
  BaseModel baseResponse = BaseModel();

  try {
    Uri url = Uri.parse(AppLinks.api);
    print(url);
    http.Response response = await http.post(
      url,
      headers: <String, String>{
        'Content-Type': 'application/json',
      },
      body: convert.jsonEncode(requestModel.toJson()),
    );
    print('========> sendOtpForCreateAccount');
    print(convert.jsonEncode(requestModel.toJson()));
    var body = convert.json.decode(response.body);
    print(body);
    print('========> sendOtpForCreateAccount');

    baseResponse = BaseModel.fromJson(body);

    return baseResponse;
  } catch (e) {
    throw Exception('Failed to add dish: $e');
  }
}
