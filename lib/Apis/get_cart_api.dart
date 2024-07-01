import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

import '../Models/cart_model.dart';
import '../Models/request_model.dart';
import '../Utils/Constants/app_links.dart';

Future<CartModel> getCartItemsApi({required RequestModel request}) async {
  CartModel cartModel = CartModel();
  print('========== get cart items from api ==================');
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

    cartModel = CartModel.fromJson(body);

    return cartModel;
  } catch (e) {
    throw Exception(e);
  }
}
