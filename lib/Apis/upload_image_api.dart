import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

import '../Models/request_model.dart';
import '../Models/ulpoad_image_model.dart';
import '../Utils/Constants/app_links.dart';

Future<UploadImageModel> uploadImageApi(
    {required RequestModel uploadImageRequest}) async {
  try {
    Uri url = Uri.parse(AppLinks.api);
    http.Response response = await http.post(
      url,
      headers: <String, String>{
        'Content-Type': 'application/json',
      },
      body: convert.jsonEncode(uploadImageRequest.toJson()),
    );
    print('====== uloqd imqge====');
    print(convert.jsonEncode(uploadImageRequest.toJson()));
    var body = convert.json.decode(response.body);
    print(body);
    print('====== uloqd imqge====');
    UploadImageModel uploadImageModel = UploadImageModel.fromJson(body);
    return uploadImageModel;
  } catch (e) {
    throw Exception('Failed to upload image: $e');
  }
}
