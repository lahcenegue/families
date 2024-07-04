import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

import '../Models/my_dishs_model.dart';
import '../Models/request_model.dart';
import '../Utils/Constants/app_links.dart';

Future<MyDishsModel> getMyDishsApi(
    {required RequestModel getItemsRequest}) async {
  MyDishsModel myDishsModel = MyDishsModel();

  try {
    Uri url = Uri.parse(AppLinks.api);

    http.Response response = await http.post(
      url,
      headers: <String, String>{
        'Content-Type': 'application/json',
      },
      body: convert.jsonEncode(getItemsRequest.toJson()),
    );

    var body = convert.json.decode(response.body);

    myDishsModel = MyDishsModel.fromJson(body);

    return myDishsModel;
  } catch (e) {
    throw Exception(e);
  }
}
