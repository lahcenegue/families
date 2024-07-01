import 'dart:async';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../Apis/base_api.dart';
import '../Apis/get_cart_api.dart';
import '../Models/base_model.dart';
import '../Models/cart_model.dart';
import '../Models/request_model.dart';
import '../Utils/Constants/api_methods.dart';
import '../Utils/Constants/app_strings.dart';
import '../View_models/cart_view_model.dart';

class CartProvider extends ChangeNotifier {
  SharedPreferences? _prefs;
  bool isApiCallProcess = false;
  String? token;

  CartViewModel? cartViewModel;

  Map<int, int> itemQuantities = {};

  int _selectedPaymentMethod = 0; // 0 for Apple Pay, 1 for Cash on Delivery

  CartProvider() {
    initial();
  }

  Future<void> initial() async {
    _prefs = await SharedPreferences.getInstance();
    token = _prefs!.getString(PrefKeys.token);

    await getCartItems();
  }

  int get selectedPaymentMethod => _selectedPaymentMethod;

  Future<void> getCartItems() async {
    isApiCallProcess = true;
    notifyListeners();

    RequestModel requestModel = RequestModel(
      method: ApiMethods.getCartItems,
      token: token,
    );

    try {
      CartModel cartModel = await getCartItemsApi(request: requestModel);

      itemQuantities.clear();
      for (var item in cartModel.data ?? []) {
        itemQuantities[item.itemId ?? 0] = item.amount ?? 1;
        print(itemQuantities);
      }

      if (cartModel.status == 'Success') {
        cartViewModel = CartViewModel(cartModel: cartModel);
        isApiCallProcess = false;
        notifyListeners();
      } else {
        print('Failed to fetch cart items');
      }
    } catch (e) {
      print('Error fetching cart items: $e');
    }
  }

  int getQuantity(int itemId) {
    return itemQuantities[itemId] ?? 1;
  }

  void incrementQuantity(int itemId) {
    itemQuantities[itemId] = getQuantity(itemId) + 1;
    notifyListeners();
  }

  void decrementQuantity(int itemId) {
    int currentQuantity = getQuantity(itemId);
    if (currentQuantity > 1) {
      itemQuantities[itemId] = currentQuantity - 1;
      notifyListeners();
    }
  }

  Future<void> addToCart({required int itemId, required int amount}) async {
    isApiCallProcess = true;
    notifyListeners();

    RequestModel requestModel = RequestModel(
      method: ApiMethods.addToCart,
      token: token,
      itemId: itemId,
      amount: amount,
    );
    try {
      BaseModel value = await baseApi(requestModel: requestModel);
      if (value.status == 'Success') {
        isApiCallProcess = false;
        notifyListeners();
      }
    } catch (e) {
      print('Error fetching cart items: $e');
    }
  }

  Future<void> removeFromCart({required int cartItemId}) async {
    isApiCallProcess = true;
    notifyListeners();

    RequestModel requestModel = RequestModel(
      method: ApiMethods.remouveFromCart,
      token: token,
      cartItemId: cartItemId,
    );
    try {
      BaseModel value = await baseApi(requestModel: requestModel);

      if (value.status == 'Success') {
        cartViewModel?.items
            .removeWhere((item) => item.cartItemId == cartItemId);
        notifyListeners();
        await getCartItems();
      }
    } catch (e) {
      print('Error removing item from cart: $e');
    }
  }

  void updateCartItemQuantity(int cartItemId, int quantity) {
    final cartItem = cartViewModel?.items
        .firstWhere((item) => item.cartItemId == cartItemId);
    if (cartItem != null) {
      cartItem.updateAmount(quantity);
      notifyListeners();
    }
  }

  void setSelectedPaymentMethod(int value) {
    _selectedPaymentMethod = value;
    notifyListeners();
  }
}
