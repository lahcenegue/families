import 'base_model.dart';
import 'dart:convert' as convert;

class MyDishsModel extends BaseModel {
  final List<MyDish>? data;

  MyDishsModel({
    super.status,
    super.errorCode,
    this.data,
  });

  factory MyDishsModel.fromJson(Map<String, dynamic> json) {
    return MyDishsModel(
      status: json['status'].toString(),
      errorCode: json['error_code'] ?? -1,
      data: (json['data'] as List<dynamic>?)
          ?.map((item) => MyDish.fromJson(item as Map<String, dynamic>))
          .toList(),
    );
  }
}

class MyDish {
  int? itemId;
  int? storeId;
  int? categoryId;
  String? itemName;
  double? price;
  String? description;
  int? preparationTime;
  List<String>? images;

  MyDish({
    this.itemId,
    this.storeId,
    this.categoryId,
    this.itemName,
    this.price,
    this.description,
    this.preparationTime,
    this.images,
  });

  factory MyDish.fromJson(Map<String, dynamic> json) {
    return MyDish(
      itemId: json['ItemId'],
      storeId: json['StoreId'],
      categoryId: json['CategoryId'],
      itemName: json['ItemName'],
      price: json['Price'].toDouble(),
      description: json['Description'],
      preparationTime: json['PreparationTime'],
      images: parseImages(json['Images']),
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
