import 'package:families/Models/my_ordres_model.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

import '../Models/request_model.dart';
import '../Utils/Constants/app_links.dart';

Future<MyOrdersModel> getMyOrdersApi(
    {required RequestModel getMyOredesRequest}) async {
  MyOrdersModel myOredersModel = MyOrdersModel();

  try {
    Uri url = Uri.parse(AppLinks.api);

    http.Response response = await http.post(
      url,
      headers: <String, String>{
        'Content-Type': 'application/json',
      },
      body: convert.jsonEncode(getMyOredesRequest.toJson()),
    );

    var body = convert.json.decode(response.body);

    myOredersModel = MyOrdersModel.fromJson(body);

    return myOredersModel;
  } catch (e) {
    throw Exception(e);
  }
}
