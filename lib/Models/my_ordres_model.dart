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
    return MyOrdersModel(
      status: json['status'].toString(),
      errorCode: json['error_code'] ?? -1,
      data: (json['data'] as Map<String, dynamic>?)?.map((key, value) {
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
  int? userId;
  int? itemId;
  int? amount;
  String? itemName;
  List<String>? images;
  String? userName;

  Item({
    this.userId,
    this.itemId,
    this.amount,
    this.itemName,
    this.images,
    this.userName,
  });

  factory Item.fromJson(Map<String, dynamic> json) {
    return Item(
      userId: json['UserId'],
      itemId: json['ItemId'],
      amount: json['Amount'],
      itemName: json['ItemName'],
      images: parseImages(json['Images']),
      userName: json['UserName'],
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
