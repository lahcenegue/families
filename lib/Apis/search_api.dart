import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

import '../Models/request_model.dart';
import '../Models/search_model.dart';
import '../Utils/Constants/app_links.dart';

Future<SearchModel> searchApi({required RequestModel searchRequest}) async {
  SearchModel searchResult = SearchModel();

  try {
    Uri url = Uri.parse(AppLinks.api);
    http.Response response = await http.post(
      url,
      headers: <String, String>{
        'Content-Type': 'application/json',
      },
      body: convert.jsonEncode(searchRequest.toJson()),
    );

    print('search Api============');
    print(convert.jsonEncode(searchRequest.toJson()));
    print(response.body);
    print(response.statusCode);

    var body = convert.json.decode(response.body);

    searchResult = SearchModel.fromJson(body);
    return searchResult;
  } catch (e) {
    throw Exception('Error searching for items: $e');
  }
}
