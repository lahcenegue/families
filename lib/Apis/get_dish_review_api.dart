import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

import '../Models/dish_review_model.dart';
import '../Models/request_model.dart';
import '../Utils/Constants/app_links.dart';

Future<DishReviewModel> getDishReviewsApi(
    {required RequestModel request}) async {
  DishReviewModel dishReviewModel = DishReviewModel();
  print('========== get dish reviews from api ==================');
  try {
    Uri url = Uri.parse(AppLinks.api);

    http.Response response = await http.post(
      url,
      headers: <String, String>{
        'Content-Type': 'application/json',
      },
      body: convert.jsonEncode(request.toJson()),
    );

    print(convert.jsonEncode(request.toJson()));
    print(response.body);
    print(response.statusCode);

    var body = convert.json.decode(response.body);

    dishReviewModel = DishReviewModel.fromJson(body);

    return dishReviewModel;
  } catch (e) {
    throw Exception(e);
  }
}
