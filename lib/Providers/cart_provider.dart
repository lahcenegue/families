import 'dart:async';

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
import '../View_models/cart_view_model.dart';

class CartProvider extends ChangeNotifier {
  SharedPreferences? _prefs;
  bool isApiCallProcess = false;
  bool addTocartProcess = false;
  String? token;

  // Add TAP SDK configuration
  String? customerId; // Store customer ID after first payment
  static const String tapScretKey = 'sk_test_OWLXy6Br4ZaIkjdV0w9JShfi';
  static const String tapPublicKey = 'pk_test_UGiTAtakqxICDBZ27L6d45pm';

  CartViewModel? cartViewModel;

  Map<int, int> itemQuantities = {};

  int _selectedPaymentMethod = 1; // 0 for TAP Payment, 1 for Cash on Delivery

  CartProvider() {
    initial();
  }

  Future<void> initial() async {
    _prefs = await SharedPreferences.getInstance();
    token = _prefs!.getString(PrefKeys.token);
    customerId = _prefs!.getString('tap_customer_id');

    if (token != null) {
      await getCartItems();
      await configureTapSDK();
    }
  }

  int get selectedPaymentMethod => _selectedPaymentMethod;

  // Payment Functions
  Future<void> configureTapSDK() async {
    try {
      GoSellSdkFlutter.configureApp(
        bundleId: "com.za3ad.macoolapp",
        productionSecretKey: tapScretKey,
        sandBoxSecretKey: tapScretKey,
        lang: "ar",
      );
    } catch (e) {
      debugPrint('Error configuring TAP SDK: $e');
    }
  }

  Future<void> startTapPayment(BuildContext context, double totalAmount) async {
    try {
      await setupSDKSession(totalAmount);

      var response = await GoSellSdkFlutter.startPaymentSDK;

      if (response != null) {
        debugPrint("Payment Response: $response");

        if (response is Map<String, dynamic>) {
          if (response["status"] == "SUCCESS" ||
              response["status"] == "CAPTURED") {
            processSuccessfulPayment(response);
          } else {
            handleFailedPayment(response);
          }
        }
      }
    } catch (e) {
      debugPrint('Error starting TAP payment: $e');
      handleFailedPayment({"error": e.toString()});
    }
  }

  Future<void> setupSDKSession(double totalAmount) async {
    try {
      List<PaymentItem> paymentItems = cartViewModel?.items.map((item) {
            return PaymentItem(
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
                    type: "F",
                    value: 0,
                    minimumFee: 0,
                    maximumFee: 0,
                  ),
                  name: "VAT",
                  description: "VAT Tax",
                )
              ],
              totalAmount: ((item.dishPrice ?? 0) * (item.amount ?? 1)).toInt(),
            );
          }).toList() ??
          [];

      GoSellSdkFlutter.sessionConfigurations(
        trxMode: TransactionMode.PURCHASE,
        transactionCurrency: "SAR",
        amount: totalAmount,
        customer: Customer(
          customerId: customerId ?? "",
          email: "test@test.com", // Replace with actual customer email
          isdNumber: "966",
          number: "000000000", // Replace with actual customer phone
          firstName: "Customer", // Replace with actual customer name
          middleName: "",
          lastName: "",
          metaData: null,
        ),
        paymentItems: paymentItems,
        taxes: [
          Tax(
            amount: Amount(
              type: "F",
              value: 0,
              minimumFee: 0,
              maximumFee: 0,
            ),
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
        postURL: "https://your-backend-url.com/payment/callback",
        paymentDescription: "Order payment",
        paymentMetaData: {},
        paymentReference: Reference(
            acquirer: "acquirer",
            gateway: "gateway",
            payment: "payment",
            track: "track",
            transaction: "trans_${DateTime.now().millisecondsSinceEpoch}",
            order: "order_${DateTime.now().millisecondsSinceEpoch}"),
        paymentStatementDescriptor: "Payment",
        isUserAllowedToSaveCard: true,
        isRequires3DSecure: true,
        receipt: Receipt(true, false),
        authorizeAction:
            AuthorizeAction(type: AuthorizeActionType.CAPTURE, timeInHours: 10),
        merchantID: "",
        allowedCadTypes: CardType.ALL,
        applePayMerchantID: "",
        allowsToSaveSameCardMoreThanOnce: false,
        cardHolderName: "",
        allowsToEditCardHolderName: true,
        supportedPaymentMethods: ["VISA", "MASTERCARD", "MADA", "APPLE_PAY"],
        paymentType: PaymentType.ALL,
        sdkMode: SDKMode.Sandbox,
      );
    } catch (e) {
      debugPrint('Error setting up SDK session: $e');
      rethrow;
    }
  }

  Future<void> processSuccessfulPayment(
      Map<String, dynamic> paymentData) async {
    try {
      if (paymentData["charge"] != null &&
          paymentData["charge"]["customer"] != null &&
          paymentData["charge"]["customer"]["id"] != null) {
        customerId = paymentData["charge"]["customer"]["id"];
        await _prefs?.setString(
          'tap_customer_id',
          customerId!,
        );
      }

      RequestModel checkoutRequest = RequestModel(
        method: ApiMethods.checkout,
        token: token,
        paymentMethode: 'TAP',
      );

      BaseModel value = await baseApi(requestModel: checkoutRequest);
      if (value.status == 'Success') {
        await getCartItems();
      }
    } catch (e) {
      debugPrint('Error processing successful payment: $e');
    }
  }

  void handleFailedPayment(Map<String, dynamic> errorData) {
    debugPrint('Payment failed: ${errorData.toString()}');
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
    notifyListeners();

    try {
      RequestModel checkoutRequest = RequestModel(
        method: ApiMethods.checkout,
        token: token,
        paymentMethode: _selectedPaymentMethod == 1 ? 'CashOnDelivery' : '',
      );

      BaseModel value = await baseApi(requestModel: checkoutRequest);
      if (value.status == 'Success') {
        await getCartItems();
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
}
