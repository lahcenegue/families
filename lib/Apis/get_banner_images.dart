import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

import '../Models/banner_images.dart';
import '../Models/request_model.dart';
import '../Utils/Constants/app_links.dart';

Future<BannerImagesModel> getBannerImagesApi(
    {required RequestModel getBannerRequest}) async {
  BannerImagesModel bannerImages = BannerImagesModel();

  try {
    Uri url = Uri.parse(AppLinks.api);

    http.Response response = await http.post(
      url,
      headers: <String, String>{
        'Content-Type': 'application/json',
      },
      body: convert.jsonEncode(getBannerRequest.toJson()),
    );
    print(convert.jsonEncode(getBannerRequest.toJson()));
    print(response.body);
    print(response.statusCode);

    var body = convert.json.decode(response.body);

    bannerImages = BannerImagesModel.fromJson(body);

    return bannerImages;
  } catch (e) {
    throw Exception(e);
  }
}
