import 'base_model.dart';
import 'dart:convert' as convert;

class SearchModel extends BaseModel {
  final List<SearchItem>? data;

  SearchModel({
    super.status,
    super.errorCode,
    this.data,
  });

  factory SearchModel.fromJson(Map<String, dynamic> json) {
    return SearchModel(
      status: json['status'].toString(),
      errorCode: json['error_code'] ?? -1,
      data: (json['data'] as List<dynamic>?)
          ?.map((item) => SearchItem.fromJson(item as Map<String, dynamic>))
          .toList(),
    );
  }
}

class SearchItem {
  int? itemId;
  int? storeId;
  int? categoryId;
  String? itemName;
  double? price;
  String? description;
  int? preparationTime;
  List<String>? options;
  List<String>? images;

  SearchItem({
    this.itemId,
    this.storeId,
    this.categoryId,
    this.itemName,
    this.price,
    this.description,
    this.preparationTime,
    this.options,
    this.images,
  });

  factory SearchItem.fromJson(Map<String, dynamic> json) {
    return SearchItem(
      itemId: json['ItemId'],
      storeId: json['StoreId'],
      categoryId: json['CategoryId'],
      itemName: json['ItemName'],
      price: json['Price'].toDouble(),
      description: json['Description'],
      preparationTime: json['PreparationTime'],
      options: (json['CommaSeperatedOptions'] as String)
          .split(',')
          .map((option) => option.trim())
          .toList(),
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
