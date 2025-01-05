import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:go_sell_sdk_flutter/go_sell_sdk_flutter.dart';
import 'package:go_sell_sdk_flutter/model/models.dart';

import 'package:shared_preferences/shared_preferences.dart';
import '../Apis/base_api.dart';
import '../Apis/get_cart_api.dart';
import '../Models/base_model.dart';
import '../Models/cart_model.dart';
import '../Models/request_model.dart';
import '../Utils/Constants/api_methods.dart';
import '../Utils/Constants/app_strings.dart';
import '../Utils/Helprs/navigation_service.dart';
import '../View_models/cart_view_model.dart';

class CartProvider extends ChangeNotifier {
  SharedPreferences? _prefs;
  bool isApiCallProcess = false;
  bool addTocartProcess = false;
  String? token;
  CartViewModel? cartViewModel;
  Map<int, int> itemQuantities = {};
  int _selectedPaymentMethod = 0;

  CartProvider() {
    initial();
  }

  Future<void> initial() async {
    _prefs = await SharedPreferences.getInstance();
    token = _prefs!.getString(PrefKeys.token);

    if (token != null) {
      await getCartItems();
    }
  }

  int get selectedPaymentMethod => _selectedPaymentMethod;

  // Payment Functions
  Future<void> startTapPayment(
    BuildContext context,
    double totalAmount,
  ) async {
    if (isApiCallProcess) return;

    try {
      isApiCallProcess = true;
      notifyListeners();

      // Configuration initiale TAP
      GoSellSdkFlutter.configureApp(
        bundleId: "com.za3ad.macoolapp",
        productionSecretKey: AppStrings.tapPublicKey,
        sandBoxSecretKey: AppStrings.tapPublicKey,
        lang: "ar",
      );

      await Future.delayed(const Duration(milliseconds: 500));
      await _setupSDKSession(totalAmount);

      final response = await GoSellSdkFlutter.startPaymentSDK;

      if (response["sdk_result"] == "SUCCESS" &&
          response["status"] == "CAPTURED") {
        await checkout();
      }
    } catch (e) {
      if (context.mounted) {
        _showPaymentError(context,
            'حدث خطأ أثناء معالجة الدفع. يرجى المحاولة مرة أخرى لاحقًا.');
      }
      debugPrint('Payment error: $e');
    } finally {
      isApiCallProcess = false;
      notifyListeners();
    }
  }

  Future<void> _setupSDKSession(double totalAmount) async {
    final paymentItems = cartViewModel?.items
            .map((item) => PaymentItem(
                  name: item.dishName ?? '',
                  amountPerUnit: item.dishPrice?.toDouble() ?? 0.0,
                  quantity: Quantity(value: item.amount ?? 1),
                  discount: {
                    "type": "F",
                    "value": 0,
                    "maximum_fee": 0,
                    "minimum_fee": 0
                  },
                  description: item.dishDescription ?? '',
                  taxes: [
                    Tax(
                      amount: Amount(
                          type: "F", value: 0, minimumFee: 0, maximumFee: 0),
                      name: "VAT",
                      description: "VAT Tax",
                    )
                  ],
                  totalAmount:
                      ((item.dishPrice ?? 0) * (item.amount ?? 1)).toInt(),
                ))
            .toList() ??
        [];

    GoSellSdkFlutter.sessionConfigurations(
      trxMode: TransactionMode.PURCHASE,
      transactionCurrency: "SAR",
      amount: totalAmount,
      customer: Customer(
        customerId: "",
        email: "test@test.com",
        isdNumber: "966",
        number: _prefs!.getString(PrefKeys.phoneNumber)!,
        firstName: _prefs!.getString(PrefKeys.userName)!,
        middleName: '',
        lastName: '',
        metaData: '',
      ),
      paymentItems: paymentItems,
      taxes: [
        Tax(
          amount: Amount(type: "F", value: 0, minimumFee: 0, maximumFee: 0),
          name: "Tax",
          description: "Tax description",
        )
      ],
      shippings: [
        Shipping(
          name: "Delivery",
          amount: 0.0,
          description: "Delivery fee",
        )
      ],
      postURL: "https://za3ad.com/apps/webook.php",
      paymentDescription: "Order payment",
      paymentMetaData: {
        'userID': _prefs!.getString(PrefKeys.id)!,
        'userToken': _prefs!.getString(PrefKeys.token)!
      },
      paymentReference: Reference(
        acquirer: "acquirer",
        gateway: "gateway",
        payment: "payment",
        track: "track",
        transaction: "trans_${DateTime.now().millisecondsSinceEpoch}",
        order: "order_${DateTime.now().millisecondsSinceEpoch}",
      ),
      paymentStatementDescriptor: "Payment",
      isUserAllowedToSaveCard: true,
      isRequires3DSecure: true,
      receipt: Receipt(true, false),
      authorizeAction: AuthorizeAction(
        type: AuthorizeActionType.CAPTURE,
        timeInHours: 10,
      ),
      merchantID: "46827443",
      allowedCadTypes: CardType.ALL,
      applePayMerchantID: "",
      allowsToSaveSameCardMoreThanOnce: false,
      cardHolderName: "",
      allowsToEditCardHolderName: true,
      supportedPaymentMethods: ["VISA", "MASTERCARD", "MADA", "APPLE_PAY"],
      paymentType: PaymentType.ALL,
      sdkMode: SDKMode.Production,
    );
  }

  void handleFailedPayment(Map<String, dynamic> errorData) {
    debugPrint('Payment failed: ${errorData.toString()}');

    isApiCallProcess = false;
    notifyListeners();
  }

  void _showPaymentError(BuildContext context, String message) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Payment Error'),
        content: Text(message),
        actions: [
          TextButton(
            child: const Text('حسنا'),
            onPressed: () => Navigator.pop(context),
          ),
        ],
      ),
    );
  }

  //Cart function
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
      }

      if (cartModel.status == 'success') {
        cartViewModel = CartViewModel(cartModel: cartModel);
        isApiCallProcess = false;
        notifyListeners();
      } else {
        debugPrint('Failed to fetch cart items');
        isApiCallProcess = false;
        notifyListeners();
      }
    } catch (e) {
      debugPrint('Error fetching cart items: $e');
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

  Future<int> addToCart({
    required int itemId,
    required int amount,
  }) async {
    addTocartProcess = true;
    notifyListeners();

    RequestModel requestModel = RequestModel(
      method: ApiMethods.addToCart,
      token: token,
      itemId: itemId,
      amount: amount,
    );
    try {
      BaseModel value = await baseApi(requestModel: requestModel);
      if (value.status == 'success') {
        await getCartItems();
        addTocartProcess = false;
        notifyListeners();
        return 11;
      } else {
        addTocartProcess = false;
        notifyListeners();
        return value.errorCode ?? 12;
      }
    } catch (e) {
      addTocartProcess = false;
      notifyListeners();
      debugPrint('Error fetching cart items: $e');
      return 13;
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

      if (value.status == 'success') {
        cartViewModel?.items
            .removeWhere((item) => item.cartItemId == cartItemId);
        notifyListeners();
        await getCartItems();
      }
    } catch (e) {
      debugPrint('Error removing item from cart: $e');
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

  Future<void> checkout() async {
    isApiCallProcess = true;
    generateToken();

    notifyListeners();

    try {
      RequestModel checkoutRequest = RequestModel(
        method: ApiMethods.checkout,
        token: token,
        paymentMethode: 'OnlinePayment',
        orderToken: generateToken(),
      );

      BaseModel value = await baseApi(requestModel: checkoutRequest);
      if (value.status == 'success') {
        await getCartItems();
        NavigationService.navigateTo(AppRoutes.myOrdersScreen);
      } else {
        debugPrint('Failed to checkout: ${value.errorCode}');
      }
    } catch (e) {
      debugPrint('Error checkout: $e');
    } finally {
      isApiCallProcess = false;
      notifyListeners();
    }
  }

  String generateToken() {
    const chars =
        '0123456789abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ';
    Random random = Random.secure();
    return List.generate(16, (index) => chars[random.nextInt(chars.length)])
        .join();
  }
}
