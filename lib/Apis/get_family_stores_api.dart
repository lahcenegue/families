import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

import '../Models/request_model.dart';
import '../Models/store_model.dart';
import '../Utils/Constants/app_links.dart';

Future<StoreModel> getFamilyStoresApi(
    {required RequestModel getFamilyStoresRequest}) async {
  StoreModel familyStores = StoreModel();
  try {
    Uri url = Uri.parse(AppLinks.api);
    http.Response response = await http.post(
      url,
      headers: <String, String>{
        'Content-Type': 'application/json',
      },
      body: convert.jsonEncode(getFamilyStoresRequest.toJson()),
    );

    print(convert.jsonEncode(getFamilyStoresRequest.toJson()));
    print(response.body);
    print(response.statusCode);

    var body = convert.json.decode(response.body);

    familyStores = StoreModel.fromJson(body);
    return familyStores;
  } catch (e) {
    throw Exception(e);
  }
}
