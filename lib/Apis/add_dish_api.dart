import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

import '../Models/add_dish_mode.dart';
import '../Models/request_model.dart';
import '../Utils/Constants/app_links.dart';

Future<AddDishModel> addDishApi({required RequestModel addDishRequest}) async {
  try {
    Uri url = Uri.parse(AppLinks.api);

    http.Response response = await http.post(
      url,
      headers: <String, String>{
        'Content-Type': 'application/json',
      },
      body: convert.jsonEncode(addDishRequest.toJson()),
    );

    print('==== Add New Dish======');
    print(convert.jsonEncode(addDishRequest.toJson()));

    var body = convert.json.decode(response.body);
    print(body);
    print('==== Add New Dish======');

    AddDishModel addDishModel = AddDishModel.fromJson(body);
    return addDishModel;
  } catch (e) {
    throw Exception('Failed to add dish: $e');
  }
}
