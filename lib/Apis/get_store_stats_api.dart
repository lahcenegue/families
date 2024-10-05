// Create a new file named get_store_stats_api.dart
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

import '../Models/request_model.dart';
import '../Models/store_stats_model .dart';
import '../Utils/Constants/app_links.dart';

Future<StoreStatsModel> getStoreStatsApi(
    {required RequestModel request}) async {
  try {
    Uri url = Uri.parse(AppLinks.api);

    http.Response response = await http.post(
      url,
      headers: <String, String>{
        'Content-Type': 'application/json',
      },
      body: convert.jsonEncode(request.toJson()),
    );

    var body = convert.json.decode(response.body);
    return StoreStatsModel.fromJson(body);
  } catch (e) {
    throw Exception('Error fetching store stats: $e');
  }
}
