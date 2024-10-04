import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

import '../Models/cart_model.dart';
import '../Models/request_model.dart';
import '../Utils/Constants/app_links.dart';

Future<CartModel> getCartItemsApi({required RequestModel request}) async {
  CartModel cartModel = CartModel();

  try {
    Uri url = Uri.parse(AppLinks.api);

    http.Response response = await http.post(
      url,
      headers: <String, String>{
        'Content-Type': 'application/json',
      },
      body: convert.jsonEncode(request.toJson()),
    );

    print('===== get Cart Items ====');
    print(convert.jsonEncode(request.toJson()));

    var body = convert.json.decode(response.body);
    print(body);
    print('===== get Cart Items ====');

    cartModel = CartModel.fromJson(body);

    return cartModel;
  } catch (e) {
    throw Exception(e);
  }
}
