import 'base_model.dart';
import 'dart:convert' as convert;

class StoreModel extends BaseModel {
  final List<Store>? data;

  StoreModel({
    super.status,
    super.errorCode,
    this.data,
  });

  factory StoreModel.fromJson(Map<String, dynamic> json) {
    return StoreModel(
      status: json['status'].toString(),
      errorCode: json['error_code'] ?? -1,
      data: (json['data'] as List<dynamic>?)
          ?.map((item) => Store.fromJson(item as Map<String, dynamic>))
          .toList(),
    );
  }
}

class Store {
  int? storeId;
  String? storeName;
  String? storeDescription;
  String? storeLocation;
  String? storeImage;
  double? deliveryCost;
  String? storeRating;
  bool? isFavorite;
  int? active;
  List<DishModel>? dishs;

  Store({
    this.storeId,
    this.storeName,
    this.storeDescription,
    this.storeLocation,
    this.storeImage,
    this.deliveryCost,
    this.storeRating,
    this.isFavorite,
    this.active,
    this.dishs,
  });

  factory Store.fromJson(Map<String, dynamic> json) {
    return Store(
      storeId: json['StoreId'],
      storeName: json['StoreName'],
      storeDescription: json['Description'],
      storeLocation: json['Location'],
      storeImage: json['Image'],
      deliveryCost: json['DeliveryCost'].toDouble(),
      storeRating: json['StoreRating'].toString(),
      isFavorite: json['isFavourite'],
      active: json['active'],
      dishs: (json['Items'] as List<dynamic>).map((item) {
        // Create a copy of the item with the store's active status
        final dishJson = Map<String, dynamic>.from(item);
        dishJson['store_active'] =
            json['active']; // Pass store's active status to dish
        return DishModel.fromJson(dishJson);
      }).toList(),
    );
  }
}

class DishModel {
  int? cartItemId;
  int? itemId;
  int? amount;
  int? storeId;
  String? dishName;
  String? storeName;
  double? dishPrice;
  String? dishDescription;
  List<String>? dishImages;
  double? dishRating;
  int? preparationTime;
  int? storeActive;

  DishModel({
    this.cartItemId,
    this.itemId,
    this.amount,
    this.storeId,
    this.dishName,
    this.storeName,
    this.dishPrice,
    this.dishDescription,
    this.dishImages,
    this.dishRating,
    this.preparationTime,
    this.storeActive,
  });

  factory DishModel.fromJson(Map<String, dynamic> json) {
    List<String> images = [];

    if (json['Images'] != null) {
      images = (convert.jsonDecode(json['Images']) as List<dynamic>)
          .map((imageJson) => imageJson.toString())
          .toList();
    }

    return DishModel(
      cartItemId: json['CartItemId'],
      itemId: json['ItemId'],
      amount: json['Amount'] ?? 0,
      storeId: json['StoreId'],
      dishName: json['ItemName'] ?? 'Unknown Dish',
      storeName: json['StoreName'] ?? 'Unknown Store',
      dishPrice: (json['Price'] as num?)?.toDouble() ?? 0.0,
      dishDescription: json['Description'] ?? 'No description available',
      dishImages: images.isNotEmpty ? images : ['default_image_url'],
      dishRating: (json['ItemRating'] as num?)?.toDouble() ?? 0.0,
      preparationTime: json['PreparationTime'] ?? 0,
      storeActive:
          json['store_active'], // Get store active status from passed data
    );
  }
}
