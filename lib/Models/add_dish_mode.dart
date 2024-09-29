import 'base_model.dart';

class AddDishModel extends BaseModel {
  final DishItem? data;

  AddDishModel({
    super.status,
    super.errorCode,
    this.data,
  });

  factory AddDishModel.fromJson(Map<String, dynamic> json) {
    return AddDishModel(
      status: json['status'].toString(),
      errorCode: json['error_code'] ?? -1,
      data: json['data'] != null ? DishItem.fromJson(json['data']) : null,
    );
  }
}

class DishItem {
  int? itemId;
  int? storeId;
  String? itemName;
  double? price;
  String? description;
  int? preparationTime;
  List<String>? images;

  DishItem({
    this.itemId,
    this.storeId,
    this.itemName,
    this.price,
    this.description,
    this.preparationTime,
    this.images,
  });

  factory DishItem.fromJson(Map<String, dynamic> json) {
    return DishItem(
      itemId: json['ItemId'],
      storeId: json['StoreId'],
      itemName: json['ItemName'],
      price: (json['Price'] as num).toDouble(),
      description: json['Description'],
      preparationTime: json['PreparationTime'],
      images: List<String>.from(json['Images'] ?? []),
    );
  }
}
