import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

import '../Models/request_model.dart';
import '../Models/base_model.dart';
import '../Utils/Constants/app_links.dart';

Future<BaseModel> addToFavoriteApi(
    {required RequestModel favoriteRequest}) async {
  BaseModel favoriteResult = BaseModel();

  try {
    Uri url = Uri.parse(AppLinks.api);
    http.Response response = await http.post(
      url,
      headers: <String, String>{
        'Content-Type': 'application/json',
      },
      body: convert.jsonEncode(favoriteRequest.toJson()),
    );

    print(convert.jsonEncode(favoriteRequest.toJson()));
    print(response.body);
    print(response.statusCode);

    var body = convert.json.decode(response.body);

    favoriteResult = BaseModel.fromJson(body);
    return favoriteResult;
  } catch (e) {
    throw Exception('Error adding item to favorites: $e');
  }
}
