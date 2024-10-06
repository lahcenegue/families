// review_api.dart
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../Models/add_review_model.dart';
import '../Models/request_model.dart';
import '../Utils/Constants/app_links.dart';

Future<ReviewModel> submitReviewApi(
    {required RequestModel reviewRequest}) async {
  try {
    Uri url = Uri.parse(AppLinks.api);
    http.Response response = await http.post(
      url,
      headers: <String, String>{
        'Content-Type': 'application/json',
      },
      body: jsonEncode(reviewRequest.toJson()),
    );

    print('=========== rreviews');
    print(jsonEncode(reviewRequest.toJson()));

    var body = jsonDecode(response.body);

    print(body);
    print('=========== rreviews');

    return ReviewModel.fromJson(body);
  } catch (e) {
    throw Exception('Error submitting review: $e');
  }
}
