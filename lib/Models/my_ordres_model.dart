import 'base_model.dart';
import 'dart:convert' as convert;

class MyOrdersModel extends BaseModel {
  final Map<String, List<Item>>? data;

  MyOrdersModel({
    super.status,
    super.errorCode,
    this.data,
  });

  factory MyOrdersModel.fromJson(Map<String, dynamic> json) {
    final data = json['data'] as Map<String, dynamic>?;
    return MyOrdersModel(
      status: json['status'].toString(),
      errorCode: json['error_code'] ?? -1,
      data: data?.map((key, value) {
        return MapEntry(
          key,
          (value as List<dynamic>)
              .map((item) => Item.fromJson(item as Map<String, dynamic>))
              .toList(),
        );
      }),
    );
  }
}

class Item {
  int? cartItemId;
  int? userId;
  int? storeId;
  int? itemId;
  int? amount;
  int? status;
  String? itemName;
  List<String>? images;
  String? userName;
  String? method;
  int? date;
  String? orderStatus;
  String? storeName;

  Item({
    this.cartItemId,
    this.userId,
    this.storeId,
    this.itemId,
    this.amount,
    this.status,
    this.itemName,
    this.images,
    this.userName,
    this.method,
    this.date,
    this.orderStatus,
    this.storeName,
  });

  factory Item.fromJson(Map<String, dynamic> json) {
    return Item(
      cartItemId: json['CartItemId'],
      userId: json['UserId'],
      storeId: json['StoreId'],
      itemId: json['ItemId'],
      amount: json['Amount'],
      status: json['Status'],
      itemName: json['ItemName'],
      images: parseImages(json['Images']),
      userName: json['UserName'],
      method: json['Method'],
      date: json['Time'],
      orderStatus: json['OrderStatus'],
      storeName: json['StoreName'],
    );
  }

  static List<String> parseImages(dynamic imagesJson) {
    if (imagesJson is String) {
      final List<dynamic> decoded = convert.jsonDecode(imagesJson);
      return decoded.map((image) => image.toString()).toList();
    } else if (imagesJson is List) {
      return imagesJson.map((image) => image.toString()).toList();
    } else {
      return [];
    }
  }
}
